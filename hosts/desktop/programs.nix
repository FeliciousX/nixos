{ pkgs, ... }@args:

{
	alacritty = import ../../modules-home-manager/alacritty.nix;
	atuin = import ../../modules-home-manager/atuin.nix;
	fish = import ../../modules-home-manager/fish;
	git = import ../../modules-home-manager/git.nix;
	helix = import ../../modules-home-manager/helix.nix { pkgs = pkgs; };
	lazygit.enable = true;
	lf = import ../../modules-home-manager/lf.nix;
	nnn = import ../../modules-home-manager/nnn.nix;
	nix-index = {
		enable = true;
		enableFishIntegration = true;
	};
	starship = import ../../modules-home-manager/starship.nix;
	zellij = import ../../modules-home-manager/zellij.nix;
}
