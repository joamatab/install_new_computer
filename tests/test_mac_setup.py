"""Run setup scripts safely: local Git repos, isolated HOME, no system changes."""

import os
import shutil
import signal
import subprocess
from pathlib import Path

import pytest

SCRIPTS = Path(__file__).resolve().parents[1] / "inc" / "bash"


@pytest.fixture
def setup_env(tmp_path):
    home = tmp_path / "new user"
    home.mkdir()
    bins = tmp_path / "bin"
    bins.mkdir()
    env = dict(
        os.environ,
        HOME=str(home),
        PATH=f"{bins}:/usr/bin:/bin",
        GIT_CONFIG_GLOBAL=str(tmp_path / "gitconfig"),
        GIT_CONFIG_NOSYSTEM="1",
        GIT_TERMINAL_PROMPT="0",
        LOG=str(tmp_path / "events"),
    )
    env.pop("BASH_ENV", None)
    env.pop("ENV", None)
    for name in (
        "XDG_DATA_HOME",
        "XDG_CONFIG_HOME",
        "XDG_CACHE_HOME",
        "HOMEBREW_PREFIX",
    ):
        env.pop(name, None)
    Path(env["LOG"]).touch()

    def command(name, body):
        path = bins / name
        path.write_text("#!/bin/bash\n" + body + "\n")
        path.chmod(0o755)
        return path

    def run(script):
        proc = subprocess.Popen(
            ["/bin/bash", str(script)],
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            start_new_session=True,
        )
        try:
            stdout, stderr = proc.communicate(timeout=5)
            return subprocess.CompletedProcess(
                proc.args, proc.returncode, stdout, stderr
            )
        finally:
            # Also clean up descendants when testing a broken keepalive or installer.
            try:
                os.killpg(proc.pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
            proc.wait()

    return home, env, command, run


def local_dotfiles(
    tmp_path,
    env,
    installer='mkdir -p "$HOME/.config"\nln -sf "$PWD/config" "$HOME/.config/example"\n',
):
    repo = tmp_path / "upstream"
    repo.mkdir()
    (repo / "install").write_text("#!/bin/bash\nset -e\n" + installer)
    (repo / "config").write_text("installed configuration\n")
    for args in (
        ["init", "-q"],
        ["add", "."],
        [
            "-c",
            "user.name=Test",
            "-c",
            "user.email=test@example.invalid",
            "commit",
            "-qm",
            "fixture",
        ],
    ):
        subprocess.run(
            ["git", "-C", str(repo), *args], env=env, check=True, capture_output=True
        )
    return repo


def map_remote(env, remote, local):
    subprocess.run(
        ["git", "config", "--global", "--add", f"url.{local}.insteadOf", remote],
        env=env,
        check=True,
    )


@pytest.mark.parametrize("fallback", [False, True])
def test_dotfiles_fresh_install_and_update(tmp_path, setup_env, fallback):
    home, env, _, run = setup_env
    repo = local_dotfiles(tmp_path, env)
    map_remote(
        env,
        "git@github.com:joamatab/dotfiles.git",
        tmp_path / "missing" if fallback else repo,
    )
    map_remote(env, "https://github.com/joamatab/dotfiles.git", repo)
    for _ in range(2):
        result = run(SCRIPTS / "dotfiles.sh")
        assert result.returncode == 0, result.stderr
        assert (home / ".config/example").is_symlink()
        assert (home / ".config/example").read_text() == "installed configuration\n"
        assert "Done! Dotfiles installed." in result.stdout


@pytest.mark.parametrize("failure", ["clone", "pull", "installer"])
def test_dotfiles_does_not_claim_success_on_failure(tmp_path, setup_env, failure):
    home, env, _, run = setup_env
    repo = local_dotfiles(
        tmp_path,
        env,
        "exit 7\n" if failure == "installer" else 'touch "$HOME/installed"\n',
    )
    target = tmp_path / "missing" if failure == "clone" else repo
    map_remote(env, "git@github.com:joamatab/dotfiles.git", target)
    map_remote(env, "https://github.com/joamatab/dotfiles.git", target)
    if failure == "pull":
        subprocess.run(
            ["git", "clone", str(repo), str(home / "dotfiles")],
            env=env,
            check=True,
            capture_output=True,
        )
        shutil.rmtree(repo)
    result = run(SCRIPTS / "dotfiles.sh")
    assert result.returncode != 0
    assert not (home / "installed").exists()
    assert "Done! Dotfiles installed." not in result.stdout


def fish_commands(env, command):
    fish = command(
        "fish",
        """
case " $* " in
  *" --noninteractive "*) ;;
  *) echo "unexpected interactive shell" >&2; exit 42 ;;
esac
[ -s "$1" ] || exit 43
exit "${FISH_STATUS:-0}"
""",
    )
    env["SHELL"] = str(fish)
    command("sudo", "cat >/dev/null; exit 0")
    command(
        "curl",
        """
while [ "$#" -gt 0 ]; do
  if [ "$1" = -o ]; then
    cat > "$2" <<'INSTALLER'
contains -- --noninteractive $argv; or exit 42
contains -- --yes $argv; or exit 43
touch "$HOME/omf-installed"
INSTALLER
    break
  fi
  shift
done
exit "${CURL_STATUS:-0}"
""",
    )


@pytest.mark.parametrize("failure", [None, "curl", "fish"])
def test_fish_finishes_unattended_and_reports_failures(setup_env, failure):
    _, env, command, run = setup_env
    fish_commands(env, command)
    if failure:
        env[f"{failure.upper()}_STATUS"] = "7"
    result = run(SCRIPTS / "fish.sh")
    if failure:
        assert result.returncode != 0
        assert "Done! Restart" not in result.stdout
    else:
        assert result.returncode == 0, result.stderr
        assert "Done! Restart" in result.stdout


@pytest.fixture
def mac_flow(tmp_path, setup_env):
    home, env, command, run = setup_env
    scripts = tmp_path / "setup scripts"
    shutil.copytree(SCRIPTS, scripts)
    fish_commands(env, command)
    command("brew", "exit 0")
    command(
        "sudo",
        """
echo "sudo $*" >> "$LOG"
case "$*" in
  -v) exit "${AUTH_STATUS:-0}" ;;
  "-n -v") exit 0 ;;
esac
exit 0
""",
    )
    for name in ("xcode-select", "defaults", "killall"):
        command(name, "exit 0")
    # Shorten only the keepalive interval; a slow package step forces a refresh.
    command("sleep", "/bin/sleep 0.02")
    for name in ("brew", "brew_cask", "ssh_create_key", "vim", "git_config"):
        (scripts / f"{name}.sh").write_text(
            f'echo "{name}" >> "$LOG"\n'
            + ("/bin/sleep 0.1\n" if name == "brew" else "")
            + f'[ "$FAIL_STAGE" != "{name}" ]\n'
        )
    repo = local_dotfiles(tmp_path, env)
    map_remote(env, "git@github.com:joamatab/dotfiles.git", repo)
    map_remote(env, "https://github.com/joamatab/dotfiles.git", repo)
    return scripts, setup_env


def test_mac_flow_reaches_dotfiles_and_finishes(mac_flow):
    scripts, (home, env, _, run) = mac_flow
    result = run(scripts / "new_mac.sh")
    assert result.returncode == 0, result.stderr
    assert (home / ".config/example").is_symlink()
    events = Path(env["LOG"]).read_text().splitlines()
    assert events[0] == "sudo -v"
    assert events.count("sudo -n -v") >= 2
    assert [e for e in events if not e.startswith("sudo ")] == [
        "brew",
        "brew_cask",
        "ssh_create_key",
        "vim",
        "git_config",
    ]


@pytest.mark.parametrize("failure", ["auth", "brew", "fish", "dotfiles"])
def test_mac_flow_stops_on_failed_prerequisite(mac_flow, failure):
    scripts, (home, env, _, run) = mac_flow
    if failure == "auth":
        env["AUTH_STATUS"] = "1"
    elif failure == "brew":
        env["FAIL_STAGE"] = "brew"
    elif failure == "fish":
        env["FISH_STATUS"] = "7"
    else:
        (scripts / "dotfiles.sh").write_text("exit 7\n")
    result = run(scripts / "new_mac.sh")
    assert result.returncode != 0
    assert not (home / ".config/example").exists()
    assert "git_config" not in Path(env["LOG"]).read_text().splitlines()


@pytest.mark.parametrize(
    "script,failed_package", [("brew.sh", "neovim"), ("brew_cask.sh", "neovide")]
)
@pytest.mark.parametrize("installed", [False, True])
def test_package_failure_stops_installation(
    setup_env, script, failed_package, installed
):
    _, env, command, run = setup_env
    env["FAILED_PACKAGE"] = failed_package
    env["LIST_STATUS"] = "0" if installed else "1"
    command(
        "brew",
        """
case "$1" in
  list) exit "$LIST_STATUS" ;;
  install|upgrade)
    echo "$*" >> "$LOG"
    case " $* " in *" $FAILED_PACKAGE "*) exit 7;; esac ;;
esac
""",
    )
    result = run(SCRIPTS / script)
    assert result.returncode != 0
    assert "Done!" not in result.stdout
    assert Path(env["LOG"]).read_text().splitlines()[-1].endswith(failed_package)


def test_new_homebrew_environment_reaches_later_steps(mac_flow):
    scripts, (home, env, _, run) = mac_flow
    (Path(env["PATH"].split(":")[0]) / "brew").unlink()
    # Simulate brew.sh installing Homebrew outside the caller's original PATH.
    (scripts / "brew.sh").write_text("""
mkdir -p "$HOME/.homebrew/bin"
cat > "$HOME/.homebrew/bin/brew" <<'BREW'
#!/bin/bash
if [ "$1" = shellenv ]; then
  printf 'export HOMEBREW_PREFIX="%s/.homebrew"\n' "$HOME"
fi
BREW
chmod +x "$HOME/.homebrew/bin/brew"
""")
    (scripts / "brew_cask.sh").write_text(
        '[ "$HOMEBREW_PREFIX" = "$HOME/.homebrew" ]\n'
    )
    result = run(scripts / "new_mac.sh")
    assert result.returncode == 0, result.stdout + result.stderr
    assert (home / ".config/example").is_symlink()


def test_fish_installer_arguments_with_real_fish(setup_env):
    real_fish = shutil.which("fish")
    if real_fish is None:
        pytest.skip("Fish binary unavailable; covered by the isolated flow tests")
    home, env, command, run = setup_env
    fish_commands(env, command)
    shim = Path(env["SHELL"])
    shim.unlink()
    shim.symlink_to(real_fish)
    result = run(SCRIPTS / "fish.sh")
    assert result.returncode == 0, result.stderr
    assert (home / "omf-installed").exists()


@pytest.mark.parametrize("xdg", [False, True])
def test_fish_rerun_preserves_existing_plugins(setup_env, xdg):
    home, env, command, run = setup_env
    fish_commands(env, command)
    data = home / ("custom data" if xdg else ".local/share")
    if xdg:
        env["XDG_DATA_HOME"] = str(data)
    else:
        env.pop("XDG_DATA_HOME", None)
    omf = data / "omf"
    (omf / "pkg/omf").mkdir(parents=True)
    plugin = omf / "pkg/custom-plugin"
    plugin.write_text("keep my plugin")
    # Existing OMF should not be passed to a destructive reinstall at all.
    command("curl", 'echo "unexpected reinstall" >&2; exit 7')
    result = run(SCRIPTS / "fish.sh")
    assert result.returncode == 0, result.stderr
    assert plugin.read_text() == "keep my plugin"


def test_keepalive_does_not_delay_exit_or_leave_sleep_running(mac_flow):
    scripts, (home, _, command, run) = mac_flow
    command("sleep", 'echo "$$" > "$HOME/sleep-pid"\nexec /bin/sleep 30')
    result = run(scripts / "new_mac.sh")
    assert result.returncode == 0, result.stderr
    pid = int((home / "sleep-pid").read_text())
    with pytest.raises(ProcessLookupError):
        os.kill(pid, 0)
