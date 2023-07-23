{ pkgs, ... }:

{
  imports =
    [
      ../../modules/bluetooth.nix
      ../../modules/firmware.nix
      ../../modules/gnome.nix
      ../../modules/localisation.nix
      ../../modules/pipewire.nix
      ../../modules/programs.nix
      ../../modules/ssh.nix
      ../../modules/yubikey.nix
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