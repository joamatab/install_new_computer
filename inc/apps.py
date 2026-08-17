"""Declarative, cross-platform application installation."""

from __future__ import annotations

import os
import shlex
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import typer

try:
    import tomllib
except ModuleNotFoundError:  # pragma: no cover - Python 3.10 fallback
    import tomli as tomllib


CATALOG_PATH = Path(__file__).with_name("apps.toml")
SUPPORTED_PLATFORMS = ("arch", "debian", "fedora", "opensuse", "macos", "windows")

apps_app = typer.Typer(
    help="Install and inspect applications from the app catalog.",
    invoke_without_command=True,
)


@dataclass(frozen=True)
class AppDefinition:
    """One application and its platform-specific package names."""

    name: str
    description: str
    command: str
    packages: dict[str, str]
    post_install: tuple[str, ...] = ()


@dataclass(frozen=True)
class Catalog:
    """Applications and named groups loaded from the TOML catalog."""

    apps: dict[str, AppDefinition]
    profiles: dict[str, tuple[str, ...]]


def load_catalog(path: Path = CATALOG_PATH) -> Catalog:
    """Load and validate the application catalog."""
    with path.open("rb") as file:
        data: dict[str, Any] = tomllib.load(file)

    apps = {}
    for name, values in data.get("apps", {}).items():
        packages = {
            platform: values[platform]
            for platform in SUPPORTED_PLATFORMS
            if platform in values
        }
        apps[name] = AppDefinition(
            name=name,
            description=values.get("description", ""),
            command=values.get("command", name),
            packages=packages,
            post_install=tuple(values.get("post_install", [])),
        )

    profiles = {
        name: tuple(app_names) for name, app_names in data.get("profiles", {}).items()
    }
    unknown = {
        app_name
        for app_names in profiles.values()
        for app_name in app_names
        if app_name not in apps
    }
    if unknown:
        raise ValueError(f"Unknown apps in profiles: {', '.join(sorted(unknown))}")
    return Catalog(apps=apps, profiles=profiles)


def complete_app(incomplete: str) -> list[str]:
    """Return catalog app names matching the current shell input."""
    return [name for name in load_catalog().apps if name.startswith(incomplete)]


def complete_profile(incomplete: str) -> list[str]:
    """Return profile names matching the current shell input."""
    return [name for name in load_catalog().profiles if name.startswith(incomplete)]


def _linux_ids(os_release: Path = Path("/etc/os-release")) -> set[str]:
    """Return normalized Linux distribution identifiers."""
    values: dict[str, str] = {}
    try:
        for line in os_release.read_text().splitlines():
            if "=" in line:
                key, value = line.split("=", 1)
                values[key] = value.strip().strip('"').lower()
    except OSError:
        return set()
    return {values.get("ID", ""), *values.get("ID_LIKE", "").split()} - {""}


def detect_platform() -> str:
    """Detect the package family used by this operating system."""
    if sys.platform == "darwin":
        return "macos"
    if os.name == "nt" or sys.platform == "win32":
        return "windows"
    if sys.platform.startswith("linux"):
        linux_ids = _linux_ids()
        families = (
            ("arch", {"arch", "manjaro"}),
            ("debian", {"debian", "ubuntu", "linuxmint", "pop"}),
            ("fedora", {"fedora", "rhel", "centos"}),
            ("opensuse", {"opensuse", "suse"}),
        )
        for family, names in families:
            if linux_ids & names:
                return family
    raise RuntimeError(f"Unsupported operating system: {sys.platform}")


def install_command(platform: str, package: str) -> list[str]:
    """Build the native package-manager command for a package."""
    commands = {
        "arch": ["sudo", "pacman", "-S", "--needed", "--noconfirm", package],
        "debian": ["sudo", "apt-get", "install", "-y", package],
        "fedora": ["sudo", "dnf", "install", "-y", package],
        "opensuse": ["sudo", "zypper", "--non-interactive", "install", package],
        "macos": ["brew", "install", package],
        "windows": [
            "winget",
            "install",
            "--id",
            package,
            "--exact",
            "--accept-package-agreements",
            "--accept-source-agreements",
        ],
    }
    try:
        return commands[platform]
    except KeyError as error:
        raise RuntimeError(f"Unsupported package platform: {platform}") from error


def package_manager(platform: str) -> str:
    """Return the executable required for a platform."""
    return {
        "arch": "pacman",
        "debian": "apt-get",
        "fedora": "dnf",
        "opensuse": "zypper",
        "macos": "brew",
        "windows": "winget",
    }[platform]


def resolve_apps(
    catalog: Catalog, names: list[str], profile: str | None
) -> list[AppDefinition]:
    """Resolve app names and a profile to unique app definitions."""
    requested = list(names)
    if profile:
        if profile not in catalog.profiles:
            choices = ", ".join(sorted(catalog.profiles))
            raise ValueError(
                f"Unknown profile '{profile}'. Available profiles: {choices}"
            )
        requested.extend(catalog.profiles[profile])
    if not requested:
        raise ValueError("Provide one or more app names or use --profile.")

    unknown = sorted(set(requested) - catalog.apps.keys())
    if unknown:
        raise ValueError(f"Unknown apps: {', '.join(unknown)}")
    return [catalog.apps[name] for name in dict.fromkeys(requested)]


def _installed(app: AppDefinition) -> bool:
    return shutil.which(app.command) is not None


def verify_app(app: AppDefinition) -> tuple[bool, str]:
    """Run a lightweight version check after installation."""
    try:
        result = subprocess.run(
            [app.command, "--version"],
            check=False,
            capture_output=True,
            text=True,
        )
    except OSError:
        return False, f"'{app.command}' is not on PATH"
    output = (result.stdout or result.stderr).strip().splitlines()
    detail = output[0] if output else f"exit code {result.returncode}"
    return result.returncode == 0, detail


@apps_app.command("list")
def list_apps() -> None:
    """List available applications and profiles."""
    catalog = load_catalog()
    platform = detect_platform()
    typer.echo(f"Platform: {platform}")
    typer.echo("Applications:")
    for item in catalog.apps.values():
        package = item.packages.get(platform, "unsupported")
        state = "installed" if _installed(item) else "missing"
        typer.echo(f"  {item.name:<12} {state:<9} {package:<24} {item.description}")
    typer.echo("Profiles:")
    for name, members in catalog.profiles.items():
        typer.echo(f"  {name:<12} {', '.join(members)}")


@apps_app.callback()
def apps_default(ctx: typer.Context) -> None:
    """Show the application catalog when no subcommand is given."""
    if ctx.invoked_subcommand is None:
        list_apps()


@apps_app.command()
def status(
    names: list[str] | None = typer.Argument(None, autocompletion=complete_app),
) -> None:
    """Show whether catalog applications are installed."""
    catalog = load_catalog()
    try:
        selected = (
            resolve_apps(catalog, names or [], None)
            if names
            else list(catalog.apps.values())
        )
    except ValueError as error:
        typer.echo(f"Error: {error}", err=True)
        raise typer.Exit(2) from error
    for item in selected:
        state = "installed" if _installed(item) else "missing"
        typer.echo(f"{item.name}: {state}")


@apps_app.command()
def install(
    names: list[str] | None = typer.Argument(
        None, help="Applications to install", autocompletion=complete_app
    ),
    profile: str | None = typer.Option(
        None, help="Install a named profile", autocompletion=complete_profile
    ),
    dry_run: bool = typer.Option(False, "--dry-run", help="Print commands only"),
    yes: bool = typer.Option(False, "--yes", "-y", help="Skip confirmation"),
) -> None:
    """Install applications using the native package manager."""
    catalog = load_catalog()
    try:
        selected = resolve_apps(catalog, names or [], profile)
        platform = detect_platform()
    except (RuntimeError, ValueError) as error:
        typer.echo(f"Error: {error}", err=True)
        raise typer.Exit(2) from error

    pending = [item for item in selected if not _installed(item)]
    for item in selected:
        if item not in pending:
            typer.echo(f"Already installed: {item.name}")
    if not pending:
        typer.echo("Everything requested is already installed.")
        return

    unsupported = [item.name for item in pending if platform not in item.packages]
    if unsupported:
        typer.echo(
            f"Error: unsupported on {platform}: {', '.join(unsupported)}", err=True
        )
        raise typer.Exit(2)

    commands = [install_command(platform, item.packages[platform]) for item in pending]
    for item, command in zip(pending, commands):
        typer.echo(f"{item.name}: {shlex.join(command)}")
    if dry_run:
        return

    manager = package_manager(platform)
    if shutil.which(manager) is None:
        typer.echo(
            f"Error: required package manager '{manager}' was not found.", err=True
        )
        raise typer.Exit(2)
    if not yes and not typer.confirm(f"Install {len(pending)} application(s)?"):
        typer.echo("Cancelled.")
        raise typer.Abort()

    failures = []
    for item, command in zip(pending, commands):
        typer.echo(f"Installing {item.name}...")
        result = subprocess.run(command, check=False)
        if result.returncode != 0:
            failures.append(item.name)
            typer.echo(f"Failed: {item.name}", err=True)
            continue
        verified, detail = verify_app(item)
        if verified:
            typer.echo(f"Verified: {item.name} ({detail})")
        else:
            failures.append(item.name)
            typer.echo(f"Verification failed: {item.name} ({detail})", err=True)
            continue
        if item.post_install:
            typer.echo(f"Next: {shlex.join(item.post_install)}")

    if failures:
        typer.echo(f"Failed applications: {', '.join(failures)}", err=True)
        raise typer.Exit(1)


def doctor() -> None:
    """Check platform, package-manager, catalog, and PATH readiness."""
    problems = 0
    try:
        catalog = load_catalog()
        typer.echo(
            f"Catalog: ok ({len(catalog.apps)} apps, {len(catalog.profiles)} profiles)"
        )
    except (OSError, ValueError) as error:
        typer.echo(f"Catalog: error ({error})")
        raise typer.Exit(1) from error

    try:
        platform = detect_platform()
        typer.echo(f"Platform: {platform}")
        manager = package_manager(platform)
        if shutil.which(manager):
            typer.echo(f"Package manager: {manager} (found)")
        else:
            problems += 1
            typer.echo(f"Package manager: {manager} (missing)")
    except RuntimeError as error:
        problems += 1
        typer.echo(f"Platform: error ({error})")

    inc_path = shutil.which("inc")
    if inc_path:
        typer.echo(f"Global command: {inc_path}")
    else:
        problems += 1
        typer.echo("Global command: missing (run 'just tool-install')")

    if shutil.which("gh"):
        auth = subprocess.run(
            ["gh", "auth", "status"], check=False, capture_output=True, text=True
        )
        if auth.returncode == 0:
            typer.echo("GitHub authentication: ready")
        else:
            problems += 1
            typer.echo("GitHub authentication: needed (run 'gh auth login')")

    if problems:
        raise typer.Exit(1)
    typer.echo("Everything looks ready.")
