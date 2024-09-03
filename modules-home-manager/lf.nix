{ pkgs, lib, ... }:
let
  hx = lib.getExe pkgs.helix;
  fzf = lib.getExe pkgs.fzf;
  rg = lib.getExe pkgs.ripgrep;
  zoxide = lib.getExe pkgs.zoxide;
in
{
  programs.lf = {
    enable = true;
    keybindings = {
      J = "move-parent down";
      K = "move-parent up";
      p = ":paste; clear";
      f = "\$${hx} $(${fzf})";
      "<c-f>" = ":fzf_jump";
      gs = ":fzf_search";
      z = "push :z<space>";
    };
    commands = {
      move-parent = ''''${{
        dironly="setlocal '$(dirname "$PWD")' dironly"
        lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
      }}'';
      fzf_jump = ''''${{
        res="$(find . -maxdepth 1 | ${fzf} --reverse --header='Jump to location')"
            if [ -n "$res" ]; then
                if [ -d "$res" ]; then
                    cmd="cd"
                else
                    cmd="select"
                fi
                res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
                lf -remote "send $id $cmd \"$res\""
            fi
      }}'';
      fzf_search = ''''${{
        RG_PREFIX="${rg} --column --line-number --no-heading --color=always --smart-case "
        res="$(
          FZF_DEFAULT_COMMAND="$RG_PREFIX ''''''" \
            ${fzf} --bind "change:reload:$RG_PREFIX {q} || true" \
            --ansi --layout=reverse --header 'Search in files' \
            | cut -d':' -f1 | sed 's/\\/\\\\/g;s/"/\\"/g'
        )"
        [ -n "$res" ] && lf -remote "send $id select \"$res\""
      }}'';
      z = ''''${{
        result="$(${zoxide} query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
      }}'';
      zi = ''''${{
        result="$(${zoxide} query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
        lf -remote "send $id cd \"$result\""
      }}'';
      on-cd = ''''${{
        ${zoxide} add "$PWD"
      }}'';
      on-select = ''&{{
        lf -remote "send $id set statfmt \"$(eza -ld --color=always "$f" | sed 's/\\/\\\\/g;s/"/\\"/g')\""
      }}'';
    };
  };
}
