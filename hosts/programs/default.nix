{ pkgs }:

{
	git = import ./git.nix;
	helix = import ./helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	starship = import ./startship.nix;
	zellij.enable = true;
}
