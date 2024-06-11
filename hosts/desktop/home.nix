{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [

      # tui apps
      graph-easy
      nmap
      slides

      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      chromium
      darktable
      dbeaver
      firefox
      mangohud
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
}
