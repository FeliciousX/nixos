{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = import ./themes.nix;
    languages = {
      language-server = {
        typescript-language-server = with pkgs.nodePackages; {
          command = "${typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
        };

        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          file-types = [ "nix" ];
          formatter = {
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
          language-servers = [ "nil" ];
        }
        {
          name = "erb";
          auto-format = true;
          file-types = [ "cfm" ];
          indent = {
            tab-width = 2;
            unit = "\t";
          };
        }
        {
          name = "java";
          file-types = [ "cfc" ];
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
      theme = "dracula-transparent";

      editor.mouse = true;
      editor.line-number = "relative";
      editor.bufferline = "multiple";
      editor.soft-wrap.enable = true;
      editor.lsp.display-messages = true;

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      editor.whitespace = {
        render = "all";
        characters = { newline = "¬"; };
      };

      # insert mode
      keys.insert.j.k = "normal_mode";

      # normal mode
      keys.normal.esc = [ "collapse_selection" "keep_primary_selection" ];
      keys.normal.A-t.g = ":toggle-option file-picker.git-ignore";
      keys.normal.A-t.h = ":toggle-option file-picker.hidden";


    };
  };
}
