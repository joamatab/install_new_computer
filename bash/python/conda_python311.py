import os
import platform
import subprocess
import sys


def is_conda_installed():
    return os.path.isdir(os.path.expanduser("~/miniconda3"))

def install_conda(version):
    os_name = platform.system()
    architecture = platform.machine()
    home_dir = os.path.expanduser("~")

    if os_name == "Darwin":
        if architecture == "arm64":
            # arm64 installer for Apple Silicon
            print("Detected arm64 architecture. Using arm-specific Miniconda installer.")
            installer_url = f"https://repo.anaconda.com/miniconda/Miniconda3-{version}-MacOSX-arm64.sh"
        else:
            # x86_64 installer for Intel Macs
            print("Detected x86_64 architecture. Using x86_64 Miniconda installer.")
            installer_url = f"https://repo.anaconda.com/miniconda/Miniconda3-{version}-MacOSX-x86_64.sh"
    elif os_name == "Linux":
        # Linux installer
        print("Detected Linux. Using Linux Miniconda installer.")
        installer_url = f"https://repo.anaconda.com/miniconda/Miniconda3-{version}-Linux-x86_64.sh"
    else:
        print("Unsupported operating system.")
        sys.exit(1)

    installer_path = os.path.join(home_dir, "miniconda.sh")
    # Download installer
    subprocess.run(["curl", "-o", installer_path, installer_url], check=True)
    # Install Miniconda
    subprocess.run(["bash", installer_path, "-b", "-u", "-p", f"{home_dir}/miniconda3"], check=True)
    # Remove installer
    os.remove(installer_path)

    # Update .bashrc
    bashrc_path = os.path.join(home_dir, ".bashrc")
    conda_path_line = f'export PATH="{home_dir}/miniconda3/bin:$PATH"'
    with open(bashrc_path, "a") as bashrc:
        if conda_path_line not in open(bashrc_path).read():
            bashrc.write(f"{conda_path_line}\n")
            print("Conda has been added to .bashrc.")
        else:
            print("Conda is already in .bashrc.")

    # Reload .bashrc
    subprocess.run(["bash", "-c", "source ~/.bashrc"], check=True)
    print("Conda installation completed and added to PATH.")

def main(version):
    print("Checking conda installation for Python 3 (64-bit)...")
    if not is_conda_installed():
        print("Conda is not installed. Installing now...")
        install_conda(version)
    else:
        print("Conda is already installed.")

if __name__ == "__main__":
    version = "py311_24.7.1-0"
    main(version)

