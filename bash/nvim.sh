#! /bin/bash

# Fetch the latest release URL from GitHub API
latest_url=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep "browser_download_url.*nvim-linux64.tar.gz" | cut -d '"' -f 4)
# Download the latest Neovim tarball
wget "$latest_url" -O nvim-linux64.tar.gz

# Download the Neovim tarball
# wget https://github.com/neovim/neovim/releases/download/latest/nvim-linux64.tar.gz

# Extract the tarball
tar xzvf nvim-linux64.tar.gz

# Check if ~/.local/bin exists
if [ -d "$HOME/.local/bin" ]; then
    # If ~/.local/bin exists, place the nvim binary there
    ln -s "$PWD/nvim-linux64/bin/nvim" "$HOME/.local/bin/"
    echo "Neovim binary linked to $HOME/.local/bin"
else
    # If ~/.local/bin does not exist, place the nvim binary in /usr/local/bin
    mv "$PWD/nvim-linux64/bin/nvim" /usr/local/bin/
    echo "Neovim binary moved to /usr/local/bin"
fi

# Clean up
rm -rf nvim-linux64 nvim-linux64.tar.gz

# Verify the installation
if command -v nvim &> /dev/null
then
    echo "Neovim installed successfully"
else
    echo "Neovim installation failed"
fi
