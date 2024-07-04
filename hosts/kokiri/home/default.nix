{ user, ... }: {
  imports = [
    ./programs
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
