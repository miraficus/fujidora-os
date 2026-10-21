# Fujidora

**Fujidora** is my personal, custom Fedora 44 gaming distribution built with `kiwi-ng` and GitHub Actions. 

It is tailored specifically for my desktop PC and handheld devices (such as the Lenovo Legion Go). 

## Features
* **Base**: Fedora 44 (featuring CachyOS kernel).
* **Desktop**: KDE Plasma (Wayland) with a clean, verbose text-based boot sequence (no Plymouth).
* **Display Manager**: ReGreet / SDDM.
* **Pre-installed Gaming & Utilities (Flatpaks)**:
  * Steam, Lutris, Heroic Games Launcher, Prism Launcher, Bottles
  * Discord, Floorp, VSCodium, ProtonPlus, Protontricks, Gear Lever
* **Handheld Support**: Includes `hhd` (Handheld Daemon) for hardware control on devices like the Legion Go.

## Status
🛠️ **Personal Use Only.** This is an experimental, custom-built distribution for my own hardware. There is no official support or guarantee of stability.


## Links
### Themes

[Monochrome Collection](https://store.kde.org/c/1361201)
[Monochrome KDE Theme](https://store.kde.org/p/2143824)
[Kora Grey Icon Pack](https://store.kde.org/p/1256209)


## Desktop assets

Theme files are stored in this repository and can be edited directly. The build only runs `bash scripts/check-theme.sh`; it does not download or overwrite Monochrome assets.

| Component | Repository path |
| --- | --- |
| Global theme | `root/usr/share/plasma/look-and-feel/Monochrome/` |
| Plasma desktop theme | `root/usr/share/plasma/desktoptheme/Monochrome/` |
| Colors | `root/usr/share/color-schemes/Monochrome.colors` |
| Window decorations | `root/usr/share/aurorae/themes/` |
| Kvantum themes | `root/etc/skel/.config/Kvantum/` |
| Conky | `root/etc/skel/.config/conky/conky.conf` |
| Kitty | `root/etc/skel/.config/kitty/kitty.conf` |

Monochrome originates from [pwyde/monochrome-kde](https://github.com/pwyde/monochrome-kde). The bundled Plasma desktop component was copied from commit `1c9983e8d1384ec2d9ff0fac59c5265fc74d0e6b`; its license and authorship files are included.

`config.sh` copies the completed `/etc/skel/.config` into the existing liveuser account, because KIWI creates that user before running the script. New users receive the same defaults from `/etc/skel`.
