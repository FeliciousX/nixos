{ pkgs }:

{
	git = {
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
	};

	helix = {
		enable = true;
		languages = {
				language-server.typescript-language-server = with pkgs.nodePackages; {
					command = "${typescript-language-server}/bin/typescript-language-server";
					args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
				};
				language = [
				{
					name = "erb";
					auto-format = true;
					file-types = ["cfm"];
					indent = {
						tab-width = 2;
						unit = "\t";
					};
				}
				{
					name = "java";
					file-types = ["cfc"];
					indent = {
						tab-width = 2;
						unit = "\t";
					};
				}
				{
					name = "typescript";
					auto-format = true;
				}
				{
					name = "tsx";
					auto-format = true;
				}
			];
		};
		settings = {
			theme = "dracula";
			editor = {
				line-number = "relative";
				lsp.display-messages = true;
			};
			editor.cursor-shape = {
				insert = "bar";
				normal = "block";
				select = "underline";
			};
			editor.whitespace = {
				render = "all";
				characters = { newline = "¬"; };
			};
			keys.insert = {
				j = {
					k = "normal_mode";
				};
			};
		};
	};
}
