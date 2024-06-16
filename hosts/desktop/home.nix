{ pkgs, user, ... }@args:

{
  # ####### #
  # Theming #
  # ####### #

  gtk.enable = true;
  gtk.theme = {
    # Cursor is declared under home.pointerCursor
    name = "Dracula";
    package = pkgs.dracula-theme;
  };
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  gtk.font = {
    name = "Hack Font Mono Medium";
  };

  programs = import ./programs.nix args;

  # TODO: look at this
  # Tray.target can not be found when xsession is not enabled. This fixes the issue.
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    # This will set cursor system-wide so applications can not choose their own
    pointerCursor = {
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };

    # Steam proton installation path #
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    packages = with pkgs; [
      # tui apps
      graph-easy
      nmap
      slides

      # nice to have gui apps
      chromium
      darktable
      dbeaver
      mangohud
      mysql-workbench
      protonup
      protonvpn-gui
      telegram-desktop
      vscode

      # version control
      gh

      # Dependencies
      jdk11
      maven
      mariadb

      # Terminal
      bat
      bitwarden-cli
      bottom
      btop # Resource Manager
      curlie
      delta
      dia
      direnv
      du-dust
      eza
      fd
      fzf
      fzy
      gping
      gum
      hyperfine
      jq
      marksman
      neofetch
      procs
      pv
      ripgrep
      tldr # Helper

      # Video/Audio
      exiftool
      ffmpeg-full
      vlc # Media Player
      spotify

      # Apps
      firefox # Browser
      #google-chrome     # Browser

      # File Management
      okular # PDF Viewer
      #p7zip             # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      syncthing # File Sync
      unrar # Rar Files
      unzip # Zip Files
      zip # Zip

      # General configuration
      git # Repositories
      ipfs # protocol
      pciutils # Computer Utility Info
      pipewire # Sound
      #usbutils         # USB Utility Info
      wget # Downloader

      # General home-manager
      dunst # Notifications
      libnotify # Dependency for Dunst
      yubikey-agent
      yubikey-manager
      yubioath-flutter
      #
      # Xorg configuration
      xclip # Console Clipboard
      #
      # Wayland configuration
      grim # Image Grabber
      swappy # Screenshot Editor
      wl-clipboard # Console Clipboard
      #
      # Wayland home-manager
      #
      # Desktop
      bitwarden
      deluge # Torrents
      #discord          # Chat
      #ffmpeg           # Video Support (dslr)
      gimp
      obsidian # journaling
      orca # Screen Reader
      simple-scan # Scanning

      libreoffice # Office Tools
      #
      # Flatpak
      obs-studio # Recording/Live Streaming
    ];

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
