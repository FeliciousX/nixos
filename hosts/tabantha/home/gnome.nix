{ pkgs, ... }: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
          "sound-output-device-chooser@kgshank.net"
          "space-bar@luchrioh"
          "gsconnect@andyholmes.github.io"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "default";
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/fx/.local/share/backgrounds/2024-10-27-02-37-17-Wallpaper.jpg";
        picture-uri-dark = "file:///home/fx/.local/share/backgrounds/2024-10-27-02-37-17-Wallpaper.jpg";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/fx/.local/share/backgrounds/2024-10-27-02-37-17-Wallpaper.jpg";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs.gnomeExtensions)
      user-themes
      vitals
      sound-output-device-chooser
      space-bar
      gsconnect
      ;
  };
}
