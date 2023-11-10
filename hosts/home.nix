{ config, lib, pkgs, unstable, user, ... }:

{ 
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      bat
      bitwarden-cli
      bottom
      btop              # Resource Manager
      delta
      direnv
      du-dust
      exa
      fd
      fzf
      fzy
      gping
      gum
      hyperfine
      jq
      marksman
      neofetch
      nnn
      procs
      pv
      ripgrep
      tldr              # Helper
      tmux
      tmuxp

      # Video/Audio
      exiftool
      ffmpeg-full
      vlc               # Media Player

      # Apps
      firefox           # Browser
      vivaldi
      vivaldi-ffmpeg-codecs
      #google-chrome     # Browser

      # File Management
      #gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      #p7zip             # Zip Encryption
      #pcmanfm           # File Manager
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      syncthing         # File Sync
      #unrar             # Rar Files
      unzip             # Zip Files
      zip               # Zip

      # General configuration
      git              # Repositories
      ipfs              # protocol
      #killall          # Stop Applications
      pciutils         # Computer Utility Info
      pipewire         # Sound
      #usbutils         # USB Utility Info
      #wacomtablet      # Wacom Tablet
      wget             # Downloader
      #zsh              # Shell

      # General home-manager
      alacritty         # Terminal Emulator
      #doom emacs       # Text Editor
      dunst             # Notifications
      #helix             # Text Editor
      libnotify         # Dependency for Dunst
      #neovim           # Text Editor
      neovim            # Text Editor
      #rofi             # Menu
      #rofi-power-menu  # Power Menu
      #udiskie          # Auto Mounting
      yubikey-agent
      yubikey-manager
      yubioath-flutter
      #
      # Xorg configuration
      xclip             # Console Clipboard
      #xorg.xev         # Input Viewer
      #xorg.xkill       # Kill Applications
      #xorg.xrandr      # Screen Settings
      #xterm            # Terminal
      #
      # Xorg home-manager
      flameshot        # Screenshot
      #picom            # Compositer
      #sxhkd            # Shortcuts
      #
      # Wayland configuration
      #autotiling       # Tiling Script
      grim             # Image Grabber
      #slurp            # Region Selector
      swappy           # Screenshot Editor
      #swayidle         # Idle Management Daemon
      #wev              # Input Viewer
      wl-clipboard     # Console Clipboard
      #wlr-randr        # Screen Settings
      #xwayland         # X for Wayland
      #
      # Wayland home-manager
      #mpvpaper         # Video Wallpaper
      #pamixer          # Pulse Audio Mixer
      #swaybg           # Background
      #swaylock-fancy   # Screen Locker
      #waybar           # Bar
      #
      # Desktop
      #ansible          # Automation
      bitwarden
      #blueman          # Bluetooth
      deluge           # Torrents
      discord          # Chat
      #ffmpeg           # Video Support (dslr)
      gimp
      #gmtp             # Mount MTP (GoPro)
      #gphoto2          # Digital Photography
      #handbrake        # Encoder
      #heroic           # Game Launcher
      #hugo             # Static Website Builder
      #lutris           # Game Launcher
      #mkvtoolnix       # Matroska Tool
      #nvtop            # Videocard Top
      obsidian          # journaling
      orca              # Screen Reader
      #plex-media-player# Media Player
      #prismlauncher    # MC Launcher
      simple-scan      # Scanning
      #sshpass          # Ansible dependency
      #steam            # Games
      # 
      # Laptop
      blueman          # Bluetooth
      #cbatticon        # Battery Notifications
      libreoffice      # Office Tools
      #light            # Display Brightness
      #simple-scan      # Scanning
      #
      # Flatpak
      obs-studio       # Recording/Live Streaming
    ];
    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    stateVersion = "23.05";
  };

  programs = import ./programs { pkgs = pkgs; };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Hack Font Mono Medium";
    };                                        # Cursor is declared under home.pointerCursor
  };

  systemd.user.targets.tray = {               # Tray.target can not be found when xsession is not enabled. This fixes the issue.
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}