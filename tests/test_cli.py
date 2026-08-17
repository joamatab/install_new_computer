from types import SimpleNamespace

from typer.testing import CliRunner

from inc import app
from inc.apps import (
    complete_app,
    complete_profile,
    detect_platform,
    install_command,
    load_catalog,
    resolve_apps,
    verify_app,
)

runner = CliRunner()


def test_ls():
    result = runner.invoke(app, ["ls"])
    assert result.exit_code == 0
    assert "Available bash scripts:" in result.stdout
    assert "Available applications:" in result.stdout
    assert "  gh" in result.stdout


def test_ls_recursive():
    result = runner.invoke(app, ["ls", "-r"])
    assert result.exit_code == 0
    assert "Available bash scripts:" in result.stdout


def test_cat_brew():
    result = runner.invoke(app, ["cat", "brew"])
    assert result.exit_code == 0
    assert "brew" in result.stdout.lower()


def test_cat_missing_script():
    result = runner.invoke(app, ["cat", "nonexistent_script_xyz"])
    assert result.exit_code == 0
    assert "not found" in result.stdout


def test_run_dry_run():
    result = runner.invoke(app, ["run", "--dry-run", "brew"])
    assert result.exit_code == 0
    assert "Would execute" in result.stdout


def test_run_missing_script():
    result = runner.invoke(app, ["run", "nonexistent_script_xyz"])
    assert result.exit_code == 0
    assert "not found" in result.stdout


def test_run_app_dry_run(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr("inc.apps.shutil.which", lambda command: None)

    result = runner.invoke(app, ["run", "gh", "--dry-run"])

    assert result.exit_code == 0
    assert "sudo pacman -S --needed --noconfirm github-cli" in result.stdout


def test_run_completion_includes_catalog_apps():
    from inc.app import complete_script

    assert "gh" in complete_script("gh")


def test_version():
    from inc import __version__

    assert __version__


def test_apps_list(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr("inc.apps.shutil.which", lambda command: None)

    result = runner.invoke(app, ["apps", "list"])

    assert result.exit_code == 0
    assert "Platform: arch" in result.stdout
    assert "gh" in result.stdout
    assert "github-cli" in result.stdout
    assert "Profiles:" in result.stdout


def test_apps_without_subcommand_lists_catalog(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr("inc.apps.shutil.which", lambda command: None)

    result = runner.invoke(app, ["apps"])

    assert result.exit_code == 0
    assert "Applications:" in result.stdout
    assert "github-cli" in result.stdout


def test_apps_install_dry_run(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr("inc.apps.shutil.which", lambda command: None)

    result = runner.invoke(app, ["apps", "install", "gh", "--dry-run"])

    assert result.exit_code == 0
    assert "sudo pacman -S --needed --noconfirm github-cli" in result.stdout


def test_apps_install_profile_deduplicates(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr("inc.apps.shutil.which", lambda command: None)

    result = runner.invoke(
        app, ["apps", "install", "gh", "--profile", "core", "--dry-run"]
    )

    assert result.exit_code == 0
    assert result.stdout.count("gh: sudo pacman") == 1
    assert "ripgrep: sudo pacman" in result.stdout


def test_apps_install_failure_returns_nonzero(monkeypatch):
    monkeypatch.setattr("inc.apps.detect_platform", lambda: "arch")
    monkeypatch.setattr(
        "inc.apps.shutil.which",
        lambda command: "/usr/bin/pacman" if command == "pacman" else None,
    )
    monkeypatch.setattr(
        "inc.apps.subprocess.run", lambda *args, **kwargs: SimpleNamespace(returncode=1)
    )

    result = runner.invoke(app, ["apps", "install", "gh", "--yes"])

    assert result.exit_code == 1
    assert "Failed applications: gh" in result.output


def test_unknown_app_returns_usage_error():
    result = runner.invoke(app, ["apps", "install", "not-in-catalog", "--dry-run"])

    assert result.exit_code == 2
    assert "Unknown apps: not-in-catalog" in result.output


def test_resolve_profile():
    catalog = load_catalog()

    resolved = resolve_apps(catalog, [], "core")

    assert [item.name for item in resolved] == ["gh", "git", "curl", "ripgrep", "fzf"]


def test_detect_manjaro_as_arch(monkeypatch):
    monkeypatch.setattr("inc.apps.sys.platform", "linux")
    monkeypatch.setattr("inc.apps._linux_ids", lambda: {"manjaro", "arch"})

    assert detect_platform() == "arch"


def test_install_command_does_not_use_shell():
    assert install_command("arch", "github-cli") == [
        "sudo",
        "pacman",
        "-S",
        "--needed",
        "--noconfirm",
        "github-cli",
    ]


def test_verify_app_runs_version_command(monkeypatch):
    catalog = load_catalog()
    calls = []

    def fake_run(command, **kwargs):
        calls.append(command)
        return SimpleNamespace(returncode=0, stdout="gh version 2.0\n", stderr="")

    monkeypatch.setattr("inc.apps.subprocess.run", fake_run)

    verified, detail = verify_app(catalog.apps["gh"])

    assert verified is True
    assert detail == "gh version 2.0"
    assert calls == [["gh", "--version"]]


def test_app_name_completion():
    assert complete_app("g") == ["gh", "git"]
    assert complete_app("shell") == ["shellcheck"]


def test_profile_completion():
    assert complete_profile("c") == ["core"]
    assert complete_profile("d") == ["dev"]
