// Plasma provede tento skript jednou pro každého uživatele po vytvoření panelů.
// Použij přímo distribuční SVG, nezávisle na aktuální sadě ikon.
var launcherTypes = [
    "org.kde.plasma.kickoff",
    "org.kde.plasma.kicker",
    "org.kde.plasma.kickerdash"
];
var allPanels = panels();
for (var i = 0; i < allPanels.length; i++) {
    var widgets = allPanels[i].widgets();
    for (var j = 0; j < widgets.length; j++) {
        var widget = widgets[j];
        if (launcherTypes.indexOf(widget.type) !== -1) {
            widget.currentConfigGroup = ["General"];
            widget.writeConfig("icon", "/usr/share/icons/hicolor/scalable/apps/fujidora.svg");
            widget.reloadConfig();
        }
    }
}
