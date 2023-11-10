{ pkgs }:

{
	git = import ./git.nix;
	helix = import ./helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	zellij.enable = true;
}
