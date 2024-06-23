{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      z = "zellij"; # TODO: check if zellij is enabled before setting abbr
      zenucompose = "docker compose -f docker-compose.yml -f docker-compose.zenu.yml";
      dc = "docker compose";
      ga = "git add";
      gb = "git branch";
      gc = "git commit -v";
      gcp = "git cherry-pick";
      gcpa = "git cherry-pick --abort";
      gd = "git diff";
      gds = "git diff --staged";
      gf = "git fetch --prune";
      gl = "git log";
      glo = "git log";
      glog = "git log --oneline";
      gll = "git log --graph --topo-order --decorate --all --boundary --date=short --abbrev-commit --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
      glll = "git log --graph --topo-order --boundary --decorate --all --date=iso8601-strict --no-abbrev-commit --abbrev=40 --pretty=format:'␟%ad␟%h␟%s␟%cn <%ce>␟%G?' | git name-rev --stdin --always --name-only | awk 'BEGIN { FS=\"␟\"; OFS=\"␟\"; } { $4 = substr($4, 1, 50); print $0; }' | column -s'␟' -t";
      gm = "git merge";
      gma = "git merge --abort";
      grb = "git rebase";
      grba = "git rebase --abort";
      grs = "git restore";
      gre = "git reset";
      gst = "git status";
      gsw = "git switch";
    };
    functions = {
      extract = builtins.readFile ./extract.fish;
      fingerprintssh = "ssh-keygen -l -f {$argv[1]}";
      jira = "xdg-open https://zenusoftware.atlassian.net/browse/{$argv[1]}";
    };
  };
}
