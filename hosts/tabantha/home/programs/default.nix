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
    ../../../../modules-home-manager/zoxide.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      ashpd-demo
      # tui apps
      graph-easy
      lazydocker
      nmap
      slides

      # nice to have gui apps
      bruno
      #scrcpy# android screen mirror
      chromium
      darktable
      dbeaver
      mangohud
      mysql-workbench
      protonup
      protonvpn-gui
      telegram-desktop
      vscode

      # Terminal
      bat
      bitwarden-cli
      bottom
      btop# Resource Manager
      curlie
      csview
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
      neofetch
      procs
      pv
      ripgrep
      ripdrag
      tldr
      openvpn
      shadowsocks-libev
      usql

      # Video/Audio
      exiftool
      ffmpeg-full
      vlc
      spotify

      # Apps
      firefox
      #google-chrome

      # File Management
      # PDF Viewwer
      okular
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
      usbutils# USB Utility Info
      wget# Downloader

      # General home-manager
      dunst# Notifications
      libnotify# Dependency for Dunst
      wofi# app launcher
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
      slurp
      eww
      wl-clipboard# Console Clipboard
      #
      # Wayland home-manager
      #
      # Desktop
      bitwarden
      deluge# Torrents
      discord# Chat
      dolphin
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
  };
}
