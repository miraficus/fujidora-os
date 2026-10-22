#!/bin/bash
set -euo pipefail

# Motivy jsou verzované přímo zde; sestavení nic nestahuje ani nepřepisuje.
overlay_dir=${1:-root}
required_files=(
    usr/share/backgrounds/fuji/default/fuji.jpg
    usr/share/icons/hicolor/scalable/apps/fujidora.svg
    usr/share/color-schemes/Monochrome.colors
    usr/share/plasma/look-and-feel/Monochrome/metadata.json
    usr/share/plasma/desktoptheme/Monochrome/metadata.json
    usr/share/aurorae/themes/Monochrome/metadata.json
    usr/share/aurorae/themes/Monochrome/decoration.svg
    etc/skel/.config/Kvantum/Monochrome/Monochrome.kvconfig
    etc/skel/.config/Kvantum/Monochrome/Monochrome.svg
    etc/skel/.config/conky/conky.conf
    etc/skel/.config/kitty/kitty.conf
    etc/skel/.config/kxkbrc
    etc/calamares/branding/fujidora/branding.desc
    etc/skel/.config/autostart/fujidora-live-installer.desktop
    etc/skel/.config/kdesurc
    usr/local/bin/fujidora-live-installer
    usr/share/applications/fujidora-protondb.desktop
    usr/share/applications/fujidora-anticheat.desktop
)
for relative_path in "${required_files[@]}"; do
    if [[ ! -s "$overlay_dir/$relative_path" ]]; then
        echo "Chybí součást motivu nebo konfigurace: $overlay_dir/$relative_path" >&2
        exit 1
    fi
done
if [[ ! -x "$overlay_dir/usr/local/bin/fujidora-live-installer" ]]; then
    echo "Live spouštěč instalátoru není spustitelný." >&2
    exit 1
fi
echo "Lokální součásti Monochrome, Conky a Kitty jsou připravené."
