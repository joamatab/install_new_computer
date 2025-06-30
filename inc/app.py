import os
import subprocess
import webbrowser
from pathlib import Path
from typing import List, Optional

import typer

from .config import PATH

app = typer.Typer()


@app.command()
def ssh_create(
    email: str = typer.Option(..., help="Email address for the SSH key"),
    overwrite: bool = typer.Option(False, help="Overwrite existing SSH key"),
):
    """Create an SSH key and set it up with GitHub and GitLab."""
    KEY_NAME = "id_ed25519"
    ssh_dir = os.path.expanduser("~/.ssh")
    key_path = os.path.join(ssh_dir, KEY_NAME)

    # Check if key already exists
    if os.path.isfile(key_path) and overwrite:
        print("Overwriting existing SSH key...")
        os.remove(key_path)
        os.remove(f"{key_path}.pub")

    # Check if SSH key already exists
    if not os.path.isfile(f"{key_path}.pub"):
        print("Let's create a GIT credential and add it to GitHub and/or GitLab.")
        print("Please log in to GitHub and GitLab in your browser.")
        input("Press Enter to continue...")

        print("Creating an SSH key for connecting your computer with GIT...")
        os.makedirs(ssh_dir, exist_ok=True)

        # Generate SSH key
        subprocess.run(
            ["ssh-keygen", "-f", key_path, "-t", "ed25519", "-C", email, "-N", ""]
        )

        print("SSH key created. Copying the key to the clipboard...")

        # Start the SSH agent
        subprocess.run(["eval", "$(ssh-agent -s)"], shell=True)

        # Add the SSH key to the SSH agent
        subprocess.run(["ssh-add", key_path])

        # Copy the public key to the clipboard
        try:
            if os.name == "posix":
                if (
                    subprocess.run(
                        ["which", "pbcopy"], stdout=subprocess.DEVNULL
                    ).returncode
                    == 0
                ):
                    subprocess.run(
                        ["pbcopy"], input=open(f"{key_path}.pub", "rb").read()
                    )
                elif (
                    subprocess.run(
                        ["which", "xclip"], stdout=subprocess.DEVNULL
                    ).returncode
                    == 0
                ):
                    subprocess.run(
                        ["xclip", "-sel", "clip"],
                        input=open(f"{key_path}.pub", "rb").read(),
                    )
                else:
                    print("Install 'pbcopy' or 'xclip' to copy the key to clipboard.")
            elif os.name == "nt":
                subprocess.run(
                    ["clip"], input=open(f"{key_path}.pub", "rb").read(), shell=True
                )
            else:
                print("Unsupported OS. Please copy the key manually from:")
                print(open(f"{key_path}.pub").read())
        except Exception as e:
            print(f"Error copying key to clipboard: {e}")

        # Open key settings pages
        print("Opening key settings pages...")
        webbrowser.open("https://github.com/settings/keys")
    print("Setup complete. If the key exists, it has been copied to the clipboard.")


@app.command()
def fish(
    make_default: bool = typer.Option(False, help="Make Fish the default shell"),
):
    """Setup Fish shell and install Oh My Fish.

    If `make_default` is set to True, Fish shell will be set as the default shell.
    """

    try:
        # Find fish binary
        fish_bin = (
            subprocess.check_output(["which", "fish"], stderr=subprocess.DEVNULL)
            .decode()
            .strip()
        )
        print(f"Fish binary found at: {fish_bin}")

        if make_default:
            # Add Fish shell to /etc/shells
            subprocess.run(
                ["sudo", "tee", "-a", "/etc/shells"], input=f"{fish_bin}\n", text=True
            )
            print("Fish shell added to /etc/shells.")

            # Change default shell to Fish
            subprocess.run(["chsh", "-s", fish_bin], check=True)
            print("Default shell changed to Fish.")

        # Install Fisher plugin manager
        fisher_path = Path("~/.config/fish/functions/fisher.fish").expanduser()
        fisher_path.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(
            [
                "curl",
                "https://git.io/fisher",
                "--create-dirs",
                "-sLo",
                str(fisher_path),
            ],
            check=True,
        )
        print("Fisher plugin manager installed.")

        # Remove existing Oh My Fish installation
        subprocess.run(["rm", "-rf", "~/.local/share/omf"], check=True)
        print("Existing Oh My Fish installation removed (if any).")

        # Install Oh My Fish
        subprocess.run(
            ["curl", "-L", "-k", "https://get.oh-my.fish", "|", "fish"],
            shell=True,
            check=True,
        )
        print("Oh My Fish installed successfully.")

    except subprocess.CalledProcessError as e:
        print(f"An error occurred: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


@app.command()
def ls():
    """List all available bash scripts."""
    bash_dir = PATH.bash
    if not bash_dir.exists():
        print("Bash directory not found.")
        return

    scripts = sorted([f.stem for f in bash_dir.glob("*.sh")])
    if not scripts:
        print("No bash scripts found.")
        return

    print("Available bash scripts:")
    for script in scripts:
        print(f"  {script}")


@app.command()
def run(
    script: str = typer.Argument(
        ..., help="Name of the bash script to run (without .sh extension)"
    ),
    args: Optional[List[str]] = typer.Argument(
        None, help="Additional arguments to pass to the script"
    ),
    dry_run: bool = typer.Option(
        False, help="Print the command that would be executed without running it"
    ),
):
    """Run a bash script from the bash/ directory."""
    bash_dir = PATH.bash
    script_path = bash_dir / f"{script}.sh"

    if not script_path.exists():
        print(f"Script '{script}.sh' not found in bash directory.")
        print("Use 'inc ls' to see available scripts.")
        return

    # Build the command
    cmd = [str(script_path)]
    if args:
        cmd.extend(args)

    if dry_run:
        print(f"Would execute: {' '.join(cmd)}")
        return

    try:
        print(f"Running: {script}.sh")
        result = subprocess.run(
            cmd, cwd=bash_dir, check=False, text=True, capture_output=False
        )
        print(f"Script completed with exit code: {result.returncode}")
    except Exception as e:
        print(f"Error running script: {e}")


@app.command()
def cat(
    script: str = typer.Argument(
        ..., help="Name of the bash script to display (without .sh extension)"
    ),
):
    """Display the contents of a bash script."""
    bash_dir = PATH.bash
    script_path = bash_dir / f"{script}.sh"

    if not script_path.exists():
        print(f"Script '{script}.sh' not found in bash directory.")
        print("Use 'inc ls' to see available scripts.")
        return

    try:
        with open(script_path, "r") as f:
            print(f.read())
    except Exception as e:
        print(f"Error reading script: {e}")


if __name__ == "__main__":
    app()
