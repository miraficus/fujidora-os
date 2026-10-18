#!/bin/bash
set -e

# --- INSTALACE MONOCHROME KDE THEME ---
echo "Stahuji a instaluji Monochrome KDE theme..."
rm -rf /tmp/monochrome-kde
git clone https://github.com/kalaschnik/monochrome-kde.git /tmp/monochrome-kde

# Vytvoření globálních adresářů pro motivy vzhledu
mkdir -p /usr/share/themes
mkdir -p /usr/share/aurorae/themes
mkdir -p /usr/share/color-schemes
mkdir -p /usr/share/plasma/look-and-feel
mkdir -p /usr/share/plasma/desktoptheme
mkdir -p /usr/share/Kvantum

# Rozkopírování jednotlivých částí motivu do systému
cp -r /tmp/monochrome-kde/Kvantum/* /usr/share/Kvantum/ 2>/dev/null || true
cp -r /tmp/monochrome-kde/Aurorae/* /usr/share/aurorae/themes/ 2>/dev/null || true
cp -r /tmp/monochrome-kde/Color-Schemes/*.colors /usr/share/color-schemes/ 2>/dev/null || true
cp -r /tmp/monochrome-kde/Look-and-Feel/* /usr/share/plasma/look-and-feel/ 2>/dev/null || true
cp -r /tmp/monochrome-kde/Plasma-Themes/* /usr/share/plasma/desktoptheme/ 2>/dev/null || true


# --- INSTALACE KORA GREY ICONS ---
echo "Stahuji Kora Grey ikony..."
rm -rf /tmp/kora-icons
git clone https://github.com/AndroShot/kora.git /tmp/kora-icons

mkdir -p /usr/share/icons
# Přesun kora-grey a jejích závislostí
cp -r /tmp/kora-icons/kora /usr/share/icons/ 2>/dev/null || true
cp -r /tmp/kora-icons/kora-grey /usr/share/icons/ 2>/dev/null || true
cp -r /tmp/kora-icons/kora-light-grey /usr/share/icons/ 2>/dev/null || true

# Obnova cache ikon
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