{ pkgs, ... }:

{
  imports =
    [
      ../../modules/gnome.nix
      ../../modules/programs.nix
    ];

  home = {
    packages = with pkgs; [
      # Applications

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