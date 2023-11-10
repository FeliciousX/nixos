{
	enable = true;
	includes = [
		{ path = "~/.gitconfig"; }
		{
			path = "~/workspaces/valetservice/.gitconfig";
			condition = "gitdir:~/workspaces/valetservice";
		}
	];
	aliases = {
		pushf = "push --force-with-lease";
		wip = "commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
		ap = "add -p";
	};
	delta = {
		enable = true;
		options = {
			syntax-theme = "Dracula";
			navigate = true;
			side-by-side = true;
		};
	};
	extraConfig = {
		hub = {
			protocol = "git";
		};
		user = {
			email = "hello@feliciousx.dev";
			name = "Churchill Lee";
		};
		core = {
			editor = "hx";
			excludesfile = "~/.gitignore";
		};
		push = {
			default = "upstream";
		};
		init = {
			defaultBranch = "main";
		};
	};
}
