{ config, lib, pkgs, unstable, user, ... }:

{
	git = {
		enable = true;
		includes = [
			{ path = "~/.gitlocalconfig"; }
		];
		aliases = {
			pushf = "push --force-with-lease";
			wip = "commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
			ap = "add -p";
		};
		delta.enable = true;
		extraConfig = {
			hub = {
				protocol = "git";
			};
			user = {
				email = "hello@feliciousx.dev";
				name = "Churchill Lee";
			};
			core = {
				editor = "helix";
				pager = "delta";
				excludesfile = "~/.gitlocalignore";
			};
			push = {
				default = "upstream";
			};
			init = {
				defaultBranch = "main";
			};
			commit = {
				gpgSign = true;
			};
		};
	};
}
