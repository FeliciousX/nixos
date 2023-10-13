{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [

      # tui apps
      slides

      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      chromium
      darktable
      dbeaver
      firefox
      mysql-workbench
      protonvpn-gui
      telegram-desktop
      vscode

      # version control
      gh

      # Dependencies
      jdk11
      maven
      mariadb
    ];
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
  };
}