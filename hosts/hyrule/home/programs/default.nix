{ pkgs, ... }: {
  imports = [
    ../../../../modules-home-manager/alacritty.nix
    ../../../../modules-home-manager/atuin.nix
    ../../../../modules-home-manager/fish
    ../../../../modules-home-manager/git.nix
    ../../../../modules-home-manager/helix
    ../../../../modules-home-manager/lazygit.nix
    ../../../../modules-home-manager/lf.nix
    ../../../../modules-home-manager/nix-index.nix
    ../../../../modules-home-manager/nnn.nix
    ../../../../modules-home-manager/starship.nix
    ../../../../modules-home-manager/zellij.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      ashpd-demo
      # tui apps
      graph-easy
      nmap
      slides

      # nice to have gui apps
      chromium
      darktable
      dbeaver-bin
      mangohud
      mysql-workbench
      protonup
      protonvpn-gui
      telegram-desktop
      vscode
      yubikey-manager-qt

      # Terminal
      bat
      bitwarden-cli
      bottom
      btop# Resource Manager
      curlie
      delta
      dia
      direnv
      du-dust
      doctl# digital ocean cli
      eza
      fd
      fzf
      fzy
      glow
      gping
      hyperfine
      jq
      lazydocker
      neofetch
      procs
      pv
      ripgrep
      ripdrag
      tldr# Helper

      # Video/Audio
      exiftool
      ffmpeg-full
      vlc# Media Player
      spotify

      # Apps
      firefox# Browser
      #google-chrome     # Browser

      # File Management
      okular# PDF Viewer
      zathura
      #p7zip             # Zip Encryption
      rsync# Syncer - $ rsync -r dir1/ dir2/
      syncthing# File Sync
      unrar# Rar Files
      unzip# Zip Files
      zip# Zip

      # General configuration
      ipfs# protocol
      pciutils# Computer Utility Info
      pipewire# Sound
      #usbutils         # USB Utility Info
      wget# Downloader

      # General home-manager
      dunst# Notifications
      libnotify# Dependency for Dunst
      yubikey-agent
      yubikey-manager
      yubioath-flutter
      #
      # Xorg configuration
      xclip# Console Clipboard
      #
      # Wayland configuration
      grim# Image Grabber
      swappy# Screenshot Editor
      wl-clipboard# Console Clipboard
      #
      # Wayland home-manager
      #
      # Desktop
      bitwarden
      deluge# Torrents
      discord# Chat
      #ffmpeg           # Video Support (dslr)
      gimp
      obsidian# journaling
      orca# Screen Reader
      simple-scan# Scanning

      libreoffice# Office Tools
      #
      # Flatpak
      obs-studio# Recording/Live Streaming
      ;

    inherit (pkgs.kdePackages) kdeconnect-kde;
  };
}
