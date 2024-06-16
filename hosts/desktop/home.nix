{ pkgs, lib, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
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
      btop              # Resource Manager
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
      tldr              # Helper

      # Video/Audio
      exiftool
      ffmpeg-full
      vlc               # Media Player
      spotify

      # Apps
      firefox           # Browser
      #google-chrome     # Browser

      # File Management
      okular            # PDF Viewer
      #p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      syncthing         # File Sync
      unrar             # Rar Files
      unzip             # Zip Files
      zip               # Zip

      # General configuration
      git              # Repositories
      ipfs              # protocol
      pciutils         # Computer Utility Info
      pipewire         # Sound
      #usbutils         # USB Utility Info
      wget             # Downloader

      # General home-manager
      dunst             # Notifications
      libnotify         # Dependency for Dunst
      yubikey-agent
      yubikey-manager
      yubioath-flutter
      #
      # Xorg configuration
      xclip             # Console Clipboard
      #
      # Wayland configuration
      grim             # Image Grabber
      swappy           # Screenshot Editor
      wl-clipboard     # Console Clipboard
      #
      # Wayland home-manager
      #
      # Desktop
      bitwarden
      deluge           # Torrents
      #discord          # Chat
      #ffmpeg           # Video Support (dslr)
      gimp
      obsidian          # journaling
      orca              # Screen Reader
      simple-scan      # Scanning

      libreoffice      # Office Tools
      #
      # Flatpak
      obs-studio       # Recording/Live Streaming
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man home-configuration.nix).
    stateVersion = "23.05";
  };

  programs = import ../programs { pkgs = pkgs; };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
  
}
