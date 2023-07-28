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
    cbatticon = {
      enable = true;
      criticalLevelPercent = 10;
      commandCriticalLevel = ''notify-send "battery critical!"'';
      lowLevelPercent = 30;
      iconType = "standard";
    };
  };
}