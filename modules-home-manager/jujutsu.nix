{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.jujutsu
  ];

  programs.jujutsu.enable = lib.mkDefault true;

  programs.jujutsu.settings = { };
}
