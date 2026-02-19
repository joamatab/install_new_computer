import os
import subprocess

import typer

app = typer.Typer()


@app.command()
def install(makefile: str, target: str = typer.Argument(None)) -> None:
    """
    Install tooling and tweak your system settings.

    Args:
        makefile (str): The makefile to use. Currently supported makefiles: 'mac.mk', 'ubuntu.mk'
        target (str): The target for the make command.
    """
    supported_makefiles = ["mac.mk", "ubuntu.mk"]

    if makefile in supported_makefiles:
        if not os.path.isfile(makefile):
            typer.echo(f"Error: {makefile} does not exist.")
            raise typer.Exit(code=1)

        try:
            if target:
                subprocess.check_call(["make", "-f", makefile, target])
            else:
                subprocess.check_call(["make", "-f", makefile, "install"])
            typer.echo("Installation completed successfully!")
        except subprocess.CalledProcessError as err:
            typer.echo("Error: Installation failed!")
            raise typer.Exit(code=1) from err

    else:
        typer.echo(f"{makefile} not supported! Currently supported install commands:")
        for mf in supported_makefiles:
            typer.echo(f"- python {__file__} {mf}")


if __name__ == "__main__":
    app()
