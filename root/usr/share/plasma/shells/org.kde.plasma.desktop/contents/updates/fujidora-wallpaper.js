// Nastav distribuční tapetu jednou po vytvoření ploch nového uživatele.
// Další přihlášení uživatelem zvolenou tapetu nepřepisují.
var allDesktops = desktops();
for (var i = 0; i < allDesktops.length; i++) {
    var desktop = allDesktops[i];
    desktop.wallpaperPlugin = "org.kde.image";
    desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desktop.writeConfig("Image", "file:///usr/share/backgrounds/fuji/default/fuji.jpg");
    desktop.reloadConfig();
}
