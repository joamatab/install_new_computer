#!/bin/sh

echo "==> Installing Google Cloud SDK..."

curl https://sdk.cloud.google.com | bash

echo "    Copying SDK to ~/.local/..."
cp -r google-cloud-sdk ~/.local/

echo "==> Done! Run 'gcloud init' to configure."
