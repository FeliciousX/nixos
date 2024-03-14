{ pkgs }:

{
	enable = true;
	languages = {
			language-server.typescript-language-server = with pkgs.nodePackages; {
				command = "${typescript-language-server}/bin/typescript-language-server";
				args = [ "--stdio" ];
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
			mouse = false;
			line-number = "relative";
			bufferline = "multiple";
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
		keys.normal = {
			esc = ["collapse_selection" "keep_primary_selection"];
			A-t = {
				g = ":toggle-option file-picker.git-ignore";
				h = ":toggle-option file-picker.hidden";
			};
		};
	};
}
