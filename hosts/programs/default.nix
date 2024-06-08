{ pkgs }:

{
	alacritty = import ./alacritty.nix;
	atuin = import ./atuin.nix;
	fish = import ./fish.nix;
	git = import ./git.nix;
	helix = import ./helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	nnn = import ./nnn.nix;
	starship = import ./starship.nix;
	zellij = import ./zellij.nix;
}
