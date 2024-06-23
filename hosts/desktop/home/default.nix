{ user, ... }: {
  imports = [
    ./theme.nix
    ./programs
  ];

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

    # Steam proton installation path #
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
