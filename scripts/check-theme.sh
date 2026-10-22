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
)
for relative_path in "${required_files[@]}"; do
    if [[ ! -s "$overlay_dir/$relative_path" ]]; then
        echo "Chybí součást motivu nebo konfigurace: $overlay_dir/$relative_path" >&2
        exit 1
    fi
done
echo "Lokální součásti Monochrome, Conky a Kitty jsou připravené."
