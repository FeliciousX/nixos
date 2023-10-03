{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [

      # tui apps
      slides

      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      vscode
      chromium
      firefox
      telegram-desktop
      mysql-workbench
      dbeaver

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