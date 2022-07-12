
[[ -d ~/apps/bashtop ]] && exit
mkdir -p ~/apps
git clone https://github.com/aristocratos/bashtop.git ~/apps/bashtop
ln -s ~/apps/bashtop/bashtop ~/.local/bin
