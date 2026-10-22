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


## ISO finalization

After KIWI builds the image, both workflows run `python3 scripts/pad-iso.py /tmp/fujidora_output/*.iso` before uploading it. This ensures at least 300 KiB of readable trailing space beyond the ISO 9660 volume and writes a matching `.iso.sha256` checksum. The operation is idempotent and rejects truncated images.

The original image placed the kernel at the very end of an unpadded ISO. A reconstructed diagnostic image reproduced an incorrect GRUB file hash and a triple fault at kernel entry; adding the padding restored the correct hash and let the kernel initialize. The padding does not change files inside the ISO. For a manual local KIWI build, run the same script before distributing the image.

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
| Fuji wallpaper | `root/usr/share/backgrounds/fuji/default/fuji.jpg` |
| Plasma keyboard layout | `root/etc/skel/.config/kxkbrc` |
| Calamares branding | `root/etc/calamares/branding/fujidora/branding.desc` |

Monochrome originates from [pwyde/monochrome-kde](https://github.com/pwyde/monochrome-kde). The bundled Plasma desktop component was copied from commit `1c9983e8d1384ec2d9ff0fac59c5265fc74d0e6b`; its license and authorship files are included.

`config.sh` copies the completed `/etc/skel/.config` into the existing liveuser account, because KIWI creates that user before running the script. New users receive the same defaults from `/etc/skel`.

The default terminal is Kitty (`TerminalApplication` and `TerminalService` in `kdeglobals`), including applications launched with `Terminal=true`. Plasma defaults to the Czech keyboard layout through `kxkbrc`; this is separate from the console keymap and ReGreet layout. Calamares uses the `fujidora` branding component, reusing the bundled launcher SVG and Fuji wallpaper. This supplies the missing startup branding; disk installation still requires an end-to-end VM test.

Plasma's one-time update scripts in `root/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/` set the Fujidora launcher icon and Fuji wallpaper after the initial layout is created. Subsequent logins preserve the user's choices. ReGreet uses the same bundled wallpaper independently.

On live boots, the autologin generator creates a runtime-only greetd configuration. Before greetd starts, `ExecStartPre` copies the SELinux label from `/etc/greetd/config.toml` onto that generated file. This lets greetd read it with SELinux enforcing, including after generator reruns; normal installed-system boots do not receive the override.
