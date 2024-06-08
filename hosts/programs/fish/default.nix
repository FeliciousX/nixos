{
	enable = true;
	shellAbbrs = {
		ga = "git add";
		gb = "git branch";
		gbD  = "git branch -D";
		gc = "git commit -v";
		gco = "git checkout";
		gcp = "git cherry-pick";
		gcpa = "git cherry-pick --abort";
		gcpc = "git cherry-pick --continue";
		gd = "git diff";
		gds = "git diff --staged";
		gf = "git fetch";
		glgo = "git log --graph --oneline";
		glog = "git log";
		gm = "git merge";
		grb = "git rebase";
		grba = "git rebase --abort";
		grbc = "git rebase --continue";
		grbi = "git rebase --interactive";
		grst = "git restore";
		grsts = "git restore --staged";
		gst = "git status";
		gsw = "git switch";
		z = "zellij"; # TODO: check if zellij is enabled before setting abbr
		zenucompose = "docker compose -f docker-compose.yml -f docker-compose-zenu.yml {$argv}";
	};
	functions = {
		extract = builtins.readFile ./extract.fish;
		fingerprintssh = "ssh-keygen -l -f {$argv[1]}";
		jira = "xdg-open https://zenusoftware.atlassian.net/browse/{$argv[1]}";
	};
}
