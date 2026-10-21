#!/bin/bash
set -euo pipefail

# Doplň chybějící součásti motivu z konkrétní ověřitelné verze upstreamu.
theme_revision=1c9983e8d1384ec2d9ff0fac59c5265fc74d0e6b
overlay_dir=${1:-root}
theme_dir=$(mktemp -d)
trap 'rm -rf "$theme_dir"' EXIT
git -C "$theme_dir" init -q
git -C "$theme_dir" remote add origin https://github.com/pwyde/monochrome-kde.git
git -C "$theme_dir" fetch -q --depth=1 origin "$theme_revision"
git -C "$theme_dir" checkout -q --detach FETCH_HEAD

mkdir -p "$overlay_dir/usr/share/"{color-schemes,plasma/desktoptheme,aurorae/themes,Kvantum,doc/fujidora-monochrome}
cp "$theme_dir/color-schemes/Monochrome.colors" "$overlay_dir/usr/share/color-schemes/"
cp -a "$theme_dir/plasma/desktoptheme/Monochrome" "$overlay_dir/usr/share/plasma/desktoptheme/"
cp -a "$theme_dir/aurorae/themes/Monochrome" "$overlay_dir/usr/share/aurorae/themes/"
cp -a "$theme_dir/Kvantum/Monochrome" "$overlay_dir/usr/share/Kvantum/"
cp "$theme_dir/LICENSE" "$overlay_dir/usr/share/doc/fujidora-monochrome/LICENSE"
