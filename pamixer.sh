
[ ! -d pamixer ] && git clone https://github.com/cdemoulins/pamixer.git
cd pamixer
meson setup build
meson compile -C build
