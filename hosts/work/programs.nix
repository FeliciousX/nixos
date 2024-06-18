{ pkgs, ... }@args:

{
  alacritty = import ../../modules-home-manager/alacritty.nix;
  atuin = import ../../modules-home-manager/atuin.nix;
  fish = import ../../modules-home-manager/fish;
  git = import ../../modules-home-manager/git.nix;
  helix = import ../../modules-home-manager/helix/helix.nix { pkgs = pkgs; };
  lazygit = import ../../modules-home-manager/lazygit.nix;
  lf = import ../../modules-home-manager/lf.nix;
  nix-index = import ../../modules-home-manager/nix-index.nix;
  nnn = import ../../modules-home-manager/nnn.nix;
  starship = import ../../modules-home-manager/starship.nix;
  zellij = import ../../modules-home-manager/zellij.nix;
}
