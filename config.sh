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

# Přidání Flathub repozitáře (pokud ještě není)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Instalace vybraných Flatpak aplikací (například Steam, Heroic, Lutris atd.)
# Používá se přepínač --system pro instalaci pro všechny uživatele
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.prismlauncher.PrismLauncher
flatpak install -y flathub com.github.Matoking.protontricks
flatpak install -y flathub one.ablaze.floorp
flatpak install -y flathub net.davidotek.pupgui2