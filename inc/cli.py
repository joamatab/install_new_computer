from __future__ import annotations

import subprocess

import typer

app = typer.Typer()


@app.command()
def bump(bump_type: str = "patch") -> None:
    """bumps current package."""
    result = subprocess.run(
        ["tbump", "--current-version"], capture_output=True, text=True
    )
    current_version = result.stdout.strip()

    major, minor, patch = map(int, current_version.split("."))

    if bump_type == "patch":
        patch += 1
    elif bump_type == "minor":
        minor += 1
        patch = 0  # Reset patch version when minor is incremented
    elif bump_type == "major":
        major += 1
        minor = 0  # Reset minor and patch version when major is incremented
        patch = 0

    new_version = f"{major}.{minor}.{patch}"
    subprocess.run(["tbump", new_version])


if __name__ == "__main__":
    import sys

    if len(sys.argv) == 1:  # No arguments provided
        sys.argv.append("--help")
    app()
