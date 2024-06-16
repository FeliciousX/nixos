{
  enable = true;
  userName = "FeliciousX";
  userEmail = "hello@feliciousx.dev";
  signing = {
    key = "6983E79E35A1E9BF2DDD415447AA4884B840A95F";
  };
  includes = [
    { path = "~/.gitconfig"; }
    {
      path = "~/workspaces/valetservice/.gitconfig";
      condition = "gitdir:~/workspaces/valetservice";
    }
  ];
  aliases = {
    pushf = "push --force-with-lease";
    # git wip
    wip = "commit --no-verify --no-gpg-sign -m \"--wip-- [skip ci]\"";
    unwip = "!\"git log -n 1 | grep -q -c wip && git reset HEAD~1\"";
    # git add
    aa = "add --all";
    ap = "add --patch";
    au = "add --update";
    # git branch
    b = "branch";
    bc = "branch --contains";
    bm = "branch --merged";
    bnm = "branch --no-merged";
    bd = "branch --delete";
    bdf = "banch --delete --force";
    # git commit
    c = "commit --verbose";
    ca = "commit --amend";
    cam = "commit --amend --message";
    cm = "commit --message";
    # git checkout
    co = "checkout";
    # git cherry-pick
    cp = "cherry-pick";
    cpa = "cherry-pick --abort";
    cpc = "cherry-pick --continue";
    # git diff
    d = "diff";
    dd = "diff --check --dirstat --find-copies --find-renames --histogram --color";
    dc = "diff --cached";
    ds = "diff --staged";
    dwd = "diff --word-diff";
    # git fetch
    f = "fetch";
    fp = "fetch --prune";
    # git grep
    g = "grep";
    gg = "grep --break --heading --line-number --color";
    gn = "grep --line-number";
    # git log
    l = "log";
    ll = "log " +
      "--graph " +
      "--topo-order " +
      "--decorate " +
      "--all " +
      "--boundary " +
      "--date=short " +
      "--abbrev-commit " +
      "--pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
    lll = "log " +
      "--graph " +
      "--topo-order " +
      "--boundary " +
      "--decorate " +
      "--all " +
      "--date=iso8601-strict " +
      "--no-abbrev-commit " +
      "--abbrev=40 " +
      "--pretty=format:' %ad %h %s %cn <%ce> %G?' | " +
      "git name-rev --stdin --always --name-only | " +
      ''awk 'BEGIN { FS=" "; OFS=" "; } { ''$4 = substr(''$4, 1, 50); print ''$0; }' | '' +
      "column -s' ' -t";
    lg = "log --graph";
    lo = "log --oneline";
    ls = "list-files";
    lsd = "list-files --debug";
    lsfn = "list-files --full-name";
    lsio = "ls-files --ignored --others --exclude-standard";
    # git merge
    m = "merge";
    ma = "merge --abort";
    mc = "merge --continue";
    # git pull
    pf = "pull --ff-only";
    pr = "pull --rebase";
    prp = "pull --rebase=preserve";
    # git rebase
    rb = "rebase";
    rba = "rebase --abort";
    rbc = "rebase --continue";
    rbs = "rebase --skip";
    rbi = "rebase --interactive";
    rbiu = "rebase --interactive @{upstream}";
    # git reflog
    rl = "reflog";
    # git remote
    rr = "remote";
    rrs = "remote show";
    rru = "remote update";
    rrp = "remote prune";
    # git restore
    rs = "restore";
    rss = "restore --staged";
    # git revert
    rv = "revert";
    rvnc = "revert --no-commit";
    # git status
    s = "status";
    ss = "status --short";
    ssb = "status --short --branch";
    # git switch
    sw = "switch";
    swc = "switch --create";
    swd = "switch --detach";
    # git whatchanged
    w = "whatchanged";
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
    core = {
      editor = "hx";
      excludesfile = "~/.gitignore";
    };
    push = {
      default = "current";
    };
    init = {
      defaultBranch = "main";
    };
    rebase = {
      updateRefs = true;
    };
  };
}
