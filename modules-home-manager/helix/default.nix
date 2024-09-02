{ inputs, system, lib, pkgs, unstable, ... }:
let
  scls = inputs.simple-completion-language-server.defaultPackage.${system};
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = unstable.helix;
    themes = import ./themes.nix;
    languages = {
      language-server = {
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

        scls = {
          # TODO: add meta.mainProgram attribute to the flake to allow usage of `lib.getExe`
          command = "${scls}/bin/simple-completion-language-server";
          config = {
            max_completion_items = 20; # set max completion results len for each group: words, snippets, unicode-input
            snippets_first = true; # completions will return before snippets by default
            feature_words = true; # enable completion by word
            feature_snippets = true; # enable snippets
            feature_unicode_input = true; # enable "unicode input"
            feature_paths = true; # enable path completion
          };
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
          language-servers = [ "scls" ];
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
          language-servers = [ "scls" ];
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
