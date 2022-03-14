{ config, lib, pkgs, ... }: {
  options.oscereal.programs = {
    fish.enable = lib.mkEnableOption "use fish globally";
    base.enable = lib.mkEnableOption "essential system apps";
    extras.enable = lib.mkEnableOption "fancy cli & gui apps";
    programming.enable = lib.mkEnableOption "common programming tools";
    devops.enable = lib.mkEnableOption "things like docker and k8s";
    hacking.enable = lib.mkEnableOption "hacking thingies i occasionally need";
    android.enable = lib.mkEnableOption "enable android development tools";
    office.enable = lib.mkEnableOption "office suite stuff";
    work.enable = lib.mkEnableOption "stuff needed for work";
  };

  config = lib.mkMerge [
    (lib.mkIf config.oscereal.programs.fish.enable {
      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;
      environment.systemPackages = with pkgs; [ starship ];
    })
    (lib.mkIf config.oscereal.programs.base.enable {
      environment.systemPackages = with pkgs;
        [
          # lib-kinda stuff
          ntfs3g

          # classic *nix
          curl
          wget
          htop

          # cli apps
          kakoune
          magic-wormhole
          neovim
          tmux
          tmuxp
        ] ++ lib.optionals config.services.xserver.enable [
          # clip apps that only make sense on gui systems
          trash-cli
          wl-clipboard
          xclip

          # gui apps i always need
          keepassxc
        ];
    })
    (lib.mkIf config.oscereal.programs.extras.enable {
      environment.systemPackages = with pkgs;
        [
          # essential extras
          chezmoi
          syncthing

          # modern *nix
          bat
          dog
          duf
          dust
          exa
          fd
          fzy
          httpie
          hyperfine
          jq
          nnn
          procs
          ripgrep
          tz

          # cli apps
          exiftool
          ffmpeg-full
          youtube-dl
        ] ++ lib.optionals config.services.xserver.enable [
          # nice to have gui apps
          fractal
          gimp
          vlc
          alacritty
          bitwarden
        ] ++ lib.optionals config.services.xserver.desktopManager.gnome.enable [ tilix transmission-gtk ]
        ++ lib.optionals config.services.xserver.desktopManager.plasma5.enable [ transmission-qt ];
    })
    (lib.mkIf config.oscereal.programs.programming.enable {
      services.lorri.enable = true;
      environment.systemPackages = with pkgs; [
        # to use with lorri
        direnv

        # version control
        delta
        git
        gh

        # protocols
        ipfs

        # essential programming languages
        nodejs
        python3

        # linting & other useful tools
        nixfmt
        nodePackages.eslint
        pipenv
      ];
    })
    (lib.mkIf config.oscereal.programs.devops.enable {
      virtualisation.docker.enable = true;
      environment.systemPackages = with pkgs; [ docker-compose ];
    })
    (lib.mkIf config.oscereal.programs.hacking.enable {
      networking.firewall.allowedTCPPorts = [ 8080 ];
      environment.systemPackages = with pkgs; [ arp-scan nmap mitmproxy ];
    })
    (lib.mkIf config.oscereal.programs.android.enable {
      programs.adb.enable = true;
      environment.systemPackages = with pkgs; [ jdk11 android-studio ];
    })
    (lib.mkIf config.oscereal.programs.office.enable {
      environment.systemPackages = let defaultLocale = config.i18n.defaultLocale;
      in with pkgs;
      [ libreoffice-fresh ]
      ++ lib.optionals (defaultLocale == "en_US.UTF-8") [ (hunspellWithDicts [ hunspellDicts.en_US-large ]) ]
      ++ lib.optionals (defaultLocale == "en_GB.UTF-8") [ (hunspellWithDicts [ hunspellDicts.en_GB-large ]) ];
    })
    (lib.mkIf config.oscereal.programs.work.enable {
      environment.systemPackages = with pkgs; [ teams ];
    })
  ];
}
