#!/bin/bash

echo "==> Enabling SSH server (sshd)..."

echo "    Starting sshd service..."
systemctl start sshd.service

echo "    Enabling sshd on boot..."
systemctl enable sshd.service

echo "==> Done! SSH server is running and enabled."
