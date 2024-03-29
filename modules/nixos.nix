{ ... }: {
  # garbage collection
  nix.gc.automatic = false;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  # automatic updates, probably fine 🙈
  # system.autoUpgrade.enable = true;

  # allow unfree applications
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.vivaldi = {
    proprietaryCodecs = true;
    enableWidevine = true;
  };

  # > Every once in a while, a new NixOS release may change configuration
  # > defaults in a way incompatible with stateful data. For instance, if the
  # > default version of PostgreSQL changes, the new version will probably be
  # > unable to read your existing databases. To prevent such breakage, you
  # > should set the value of this option to the NixOS release with which you
  # > want to be compatible. The effect is that NixOS will use defaults
  # > corresponding to the specified release (such as using an older version
  # > of PostgreSQL). It‘s perfectly fine and recommended to leave this value
  # > at the release version of the first install of this system. Changing this
  # > option will not upgrade your system. In fact it is meant to stay constant
  # > exactly when you upgrade your system. You should only bump this option,
  # > if you are sure that you can or have migrated all state on your system
  # > which is affected by this option.
  system.stateVersion = "21.11";
}
