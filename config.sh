#!/bin/bash
set -e

# Jeden aktivní správce přihlášení; live autologin doplňuje systemd generátor.
systemctl disable sddm.service
systemctl enable --force greetd.service
systemctl set-default graphical.target

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

[KDE]
LookAndFeelPackage=Monochrome
widgetStyle=kvantum
EOF

cat << 'EOF' > /etc/skel/.config/kservicerc
[ScreenMapping]
screenMapping=
EOF

cat << 'EOF' > /etc/skel/.config/kwinrc
[org.kde.kdecoration2]
library=org.kde.kwin.aurorae
theme=__aurorae__svg__Monochrome
EOF

cat << 'EOF' > /etc/skel/.config/plasmarc
[Theme]
name=Monochrome
EOF

mkdir -p /etc/skel/.config/Kvantum /etc/skel/.config/conky /etc/skel/.config/autostart
cat << 'EOF' > /etc/skel/.config/Kvantum/kvantum.kvconfig
[General]
theme=Monochrome
EOF

cp /etc/xdg/conky/conky.conf /etc/skel/.config/conky/conky.conf
cat << 'EOF' > /etc/skel/.config/autostart/fujidora-conky.desktop
[Desktop Entry]
Type=Application
Name=Fujidora Conky
Exec=/usr/bin/conky --pause=10
TryExec=/usr/bin/conky
OnlyShowIn=KDE;
Terminal=false
EOF

# KIWI vytvořilo liveuser již před config.sh, proto skel zkopírujeme i jemu.
mkdir -p /home/liveuser/.config
cp -a /etc/skel/.config/. /home/liveuser/.config/
chown -R liveuser:liveuser /home/liveuser/.config

# Nastavení systémového jazyka a klávesnice
echo "LANG=cs_CZ.UTF-8" > /etc/locale.conf
echo "KEYMAP=cz" > /etc/vconsole.conf

# Přidání Flathub repozitáře (pokud ještě není)
flatpak --system remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Instalace vybraných Flatpak aplikací (například Steam, Heroic, Lutris atd.)
# Používá se přepínač --system pro instalaci pro všechny uživatele
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.prismlauncher.PrismLauncher
flatpak install -y flathub com.github.Matoking.protontricks
flatpak install -y flathub one.ablaze.floorp
flatpak install -y flathub net.davidotek.pupgui2
