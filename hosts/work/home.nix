{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [

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
      delta
      git
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