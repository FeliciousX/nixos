{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [
      # lib-kinda stuff
      unzip

      # classic *nix
      curl
      wget
      htop
      btop

      # editor
      neovim
      helix

      # cli apps
      #ngrok
      #magic-wormhole
      tmux
      tmuxp
      # clip apps that only make sense on gui systems
      trash-cli
      wl-clipboard
      xclip


      # modern *nix
      bat
      bottom
      duf
      du-dust
      exa
      fd
      fzf
      fzy
      gum
      hyperfine
      jq
      nnn
      procs
      pv
      ripgrep

      # cli apps
      niv
      taskwarrior
      ffmpeg-full
      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      alacritty
      tilix
      # to use with lorri
      direnv

      # version control
      delta
      git
      gh

      # Applications

      # Dependencies
      jdk11
      maven
      mariadb
    ];
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
    cbatticon = {
      enable = true;
      criticalLevelPercent = 10;
      commandCriticalLevel = ''notify-send "battery critical!"'';
      lowLevelPercent = 30;
      iconType = "standard";
    };
  };
}