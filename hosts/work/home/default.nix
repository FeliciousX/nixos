{ user, ... }: {
  imports = [
    ./theme.nix
    ./programs
  ];

  # ####### #
  # Applets #
  # ####### #

  services.blueman-applet.enable = true; # Bluetooth
  services.flameshot.enable = true; # Screenshot

  # TODO: look at this
  # Tray.target can not be found when xsession is not enabled. This fixes the issue.
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
