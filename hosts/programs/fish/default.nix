{
	enable = true;
	shellAbbrs = {
		z = "zellij"; # TODO: check if zellij is enabled before setting abbr
		zenucompose = "docker compose -f docker-compose.yml -f docker-compose-zenu.yml";
	};
	functions = {
		extract = builtins.readFile ./extract.fish;
		fingerprintssh = "ssh-keygen -l -f {$argv[1]}";
		jira = "xdg-open https://zenusoftware.atlassian.net/browse/{$argv[1]}";
	};
}
