deploy:
	nh os switch

debug:
	nh os switch --verbose

up:
	nix flake update

repl:
	nix repl -f flake:nixpkgs

clean:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 15d

gc:
	sudo nix-collect-garbace --delete-old


