{ user, ... }: {
  imports = [
    ./theme.nix
    ./programs
  ];

  # ####### #
  # Applets #
  # ####### #

  services.blueman-applet.enable = true; # bluetooth
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

    # allow login from my yubikeys
    file.".config/Yubico/u2f_keys".text = builtins.concatStringsSep ":" [
      user
      "yCtdvTPGRzzcKnKguGQyYDGh76zw/WvOOqq98kFwrRnokZ4E/yD286IVI6p/gfTJh3yI2JJULXus/IgjF915YQ==,zIXT8okRliZVNtz+sXUrXAiLbHMHqT5M/z3gFj958TwV9HW1nEjXl4GmdcBW+W/425PYTNlho2mcfsUosd2k1g==,es256,+presence"
      "y9t02+6rUbMwSXYgxDzgVR6k+CNRetw/7VKGFqqa8DTnp1Dei3o/smhdNwY+U/eec9MaZzZhRI1NrgvKnkzg5A==,bdRq1NMQzxL3TbUQ30yf7M6B+nFurZV7d6UJ9mOckgxZqwp8lh5fkCLs+p1hTO/U5irhua37prYy1VvwEjPVxA==,es256,+presence"
    ];

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
