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
      protonup
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

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
