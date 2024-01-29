{ pkgs }:

{
	git = import ./git.nix;
	helix = import ./helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	nnn = import ./nnn.nix;
	starship = import ./starship.nix;
	zellij.enable = true;
}
