#!/bin/bash
set -e

# Obnova ikona keše pro předpřipravené ikony v /usr/share/icons
gtk-update-icon-cache /usr/share/icons/kora-grey || true

# --- NASTAVENÍ JAKO VÝCHOZÍ VZHLED PRO UŽIVATELE ---
mkdir -p /etc/skel/.config

cat << 'EOF' > /etc/skel/.config/kdeglobals
[General]
ColorScheme=Monochrome
XftHintStyle=hintslight
XftSubPixel=rgb

[Icons]
Theme=kora-grey
EOF

cat << 'EOF' > /etc/skel/.config/kservicerc
[ScreenMapping]
screenMapping=
EOF

cat << 'EOF' > /etc/skel/.config/kwinrc
[org.kde.kdecoration2]
theme=__aurorae__svg__Monochrome
EOF

mkdir -p /etc/skel/.config

cat << 'EOF' > /etc/skel/.config/kdeglobals
[KDE]
LookAndFeelPackage=Monochrome
EOF

# Nastavení systémového jazyka a klávesnice
echo "LANG=cs_CZ.UTF-8" > /etc/locale.conf
echo "KEYMAP=cz" > /etc/vconsole.conf