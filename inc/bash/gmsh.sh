#!/bin/bash

echo "Installing gmsh and dependencies..."

os_name=$(uname -s)

if [[ "$os_name" == "Linux" ]]; then
  sudo apt-get update
  sudo apt-get install -y python3-gmsh gmsh libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev
  echo "gmsh installation completed."
elif [[ "$os_name" == "Darwin" ]]; then
  echo "macOS detected. Use 'brew install gmsh' instead."
  exit 1
else
  echo "Unsupported operating system."
  exit 1
fi
