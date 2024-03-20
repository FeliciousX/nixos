{
	enable = true;
	shellAbbrs = {
		z = "zellij"; # TODO: check if zellij is enabled before setting abbr
	};
	functions = {
		jira = "xdg-open https://zenusoftware.atlassian.net/browse/{$argv[1]}";
	};
}
