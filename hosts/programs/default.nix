{ pkgs }:

{
	git = import ./git.nix;
	helix = import ./helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	starship = import ./starship.nix;
	zellij.enable = true;
}
