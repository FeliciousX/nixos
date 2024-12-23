{ user, ... }: {
  imports = [
    ./theme.nix
    ./gnome.nix
    ./programs
    ./syncthing.nix
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

    # allow login from my yubikeys
    file.".config/Yubico/u2f_keys".text = builtins.concatStringsSep ":" [
      user
      "ZfUZ027k+7i904j1kl989cijmkwNXX2eX7nulsiZKJqCBtmQ1V0cmjDqMgf4G8EJnWRN05WSkpGkYXyxqsuW4w==,/8phG4CBREiu+p51iCfu9X72R9nU5ftXCrJaWxNjli13ZleHTo4tap0nAJhVq48CazhDE0eGGYsGeGTtYcUnAw==,es256,+presence"
      "dHYTq1lCa6zmTj4oOsExLxNmGoLsVzvisl++jlopwmO09qJAtMrlXeemX8I6q4JRA0kahjZzckMsgR2CfJyyfw==,d9JUMfu8mZ2KTBR7aXy3nVaJhjNUZ8PLV8BwhtmI/UC+myyh3ErGtAG+3r/Xim/+aeccMcl+OaQKAuE5yVQoCA==,es256,+presence"
    ];

    # Steam proton installation path #
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
