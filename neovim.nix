{ config, pkgs, ... }:

{ environment.systemPackages = [
    (pkgs.neovim.override {
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
    })
  ];
}
