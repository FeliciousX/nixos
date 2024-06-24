{
  programs.lf = {
    enable = true;
    keybindings = {
      J = "move-parent down";
      K = "move-parent up";
      p = ":paste; clear";
      f = "$hx $(fzf)";
      "<c-f>" = ":fzf_jump";
    };
    commands = {
      move-parent = ''''${{
        dironly="setlocal '$(dirname "$PWD")' dironly"
        lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
      }}'';
      fzf_jump = ''''${{
        res="$(find . -maxdepth 1 | fzf --reverse --header='Jump to location')"
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
    };
  };
}
