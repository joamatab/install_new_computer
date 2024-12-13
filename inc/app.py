import os
import subprocess
import webbrowser
from pathlib import Path

import typer

app = typer.Typer()


@app.command()
def ssh_create(
    email: str = typer.Option(..., help="Email address for the SSH key"),
):
    """Create an SSH key and set it up with GitHub and GitLab."""
    KEY_NAME = "id_ed25519"
    ssh_dir = os.path.expanduser("~/.ssh")
    key_path = os.path.join(ssh_dir, KEY_NAME)

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
def fish():
    """Setup Fish shell and install Oh My Fish."""

    try:
        # Find fish binary
        fish_bin = (
            subprocess.check_output(["which", "fish"], stderr=subprocess.DEVNULL)
            .decode()
            .strip()
        )
        print(f"Fish binary found at: {fish_bin}")

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


if __name__ == "__main__":
    app()
