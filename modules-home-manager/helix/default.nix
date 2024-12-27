{ lib, pkgs, unstable, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = unstable.helix;
    themes = import ./themes.nix;
    languages = {
      language-server = {
        efm-lsp-prettier = {
          command = pkgs.efm-langserver;
          config = {
            documentFormatting = true;
            languages = {
              typescript = [
                {
                  formatCommand = "prettier --stdin-filepath \$\{INPUT\}";
                  formatStdin = true;
                }
              ];
            };
          };
        };

        typescript-language-server = {
          command = lib.getExe pkgs.nodePackages.typescript-language-server;
          args = [ "--stdio" ];
        };

        nil = {
          command = "${pkgs.nil}/bin/nil";
        };

        markdown-oxide = {
          command = lib.getExe unstable.markdown-oxide;
        };

      };
      language = [
        {
          name = "nix";
          auto-format = true;
          file-types = [ "nix" ];
          formatter = {
            command = lib.getExe pkgs.nixpkgs-fmt;
          };
          language-servers = [ "nil" ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            { name = "efm-lsp-prettier"; only-features = [ "diagnostics" "format" ]; }
            { name = "typescript-language-server"; except-features = [ "format" ]; }
          ];
        }
        {
          name = "tsx";
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "markdown-oxide" ];
        }
        {
          name = "coldfusion";
          scope = "source.cfc";
          injection-regex = "cfc";
          file-types = [ "cfc" ];
          roots = [ "box.json" ];
          grammar = "java";
          indent = {
            tab-width = 2;
            unit = "\t";
          };
        }
        {
          name = "cfml";
          scope = "text.cfml";
          injection-regex = "cfml";
          file-types = [ "cfm" ];
          roots = [ "index.cfm" ];
          grammar = "embedded-template";
          indent = {
            tab-width = 2;
            unit = "\t";
          };
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

      keys.insert = {
        left = "no_op";
        right = "no_op";
        up = "no_op";
        down = "no_op";
      };

    };
  };
}
