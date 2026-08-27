"""Commands for managing the installed inc CLI."""

import subprocess

import typer

self_app = typer.Typer(no_args_is_help=True)


@self_app.command()
def update() -> None:
    """Update inc to the latest published version."""
    command = ["uv", "tool", "upgrade", "inc"]
    typer.echo(f"Running: {' '.join(command)}")

    try:
        result = subprocess.run(command, check=False)
    except FileNotFoundError:
        typer.echo(
            "uv is required to update inc. Install it with 'inc run uv'.", err=True
        )
        raise typer.Exit(1) from None

    if result.returncode != 0:
        raise typer.Exit(result.returncode)
