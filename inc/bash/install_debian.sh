# loaded by systemd

mkdir -p ~/.config/environment.d
echo 'SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket' > ~/.config/environment.d/envvars.conf
