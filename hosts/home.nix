{ config, lib, pkgs, unstable, user, ... }:

{ 
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      bat
      direnv
      bottom
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
      tldr              # Helper
      tmux
      tmuxp

      # Video/Audio
      vlc               # Media Player
      ffmpeg-full

      # Apps
      vivaldi
      vivaldi-ffmpeg-codecs
      firefox           # Browser
      #google-chrome     # Browser

      # File Management
      #gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      #pcmanfm           # File Manager
      #p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      #unrar             # Rar Files
      zip               # Zip

      # General configuration
      git              # Repositories
      #killall          # Stop Applications
      #nano             # Text Editor
      pciutils         # Computer Utility Info
      pipewire         # Sound
      #usbutils         # USB Utility Info
      #wacomtablet      # Wacom Tablet
      wget             # Downloader
      #zsh              # Shell
      #
      # General home-manager
      alacritty        # Terminal Emulator
      dunst            # Notifications
      #doom emacs       # Text Editor
      libnotify        # Dependency for Dunst
      #neovim           # Text Editor
      #rofi             # Menu
      #rofi-power-menu  # Power Menu
      #udiskie          # Auto Mounting
      neovim              # Text Editor
      helix
      yubikey-agent
      yubikey-manager
      yubioauth-flutter
      #
      # Xorg configuration
      xclip            # Console Clipboard
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
      #blueman          # Bluetooth
      bitwarden
      deluge           # Torrents
      discord          # Chat
      #ffmpeg           # Video Support (dslr)
      #gmtp             # Mount MTP (GoPro)
      #gphoto2          # Digital Photography
      #handbrake        # Encoder
      #heroic           # Game Launcher
      #hugo             # Static Website Builder
      #lutris           # Game Launcher
      #mkvtoolnix       # Matroska Tool
      #nvtop            # Videocard Top
      #plex-media-player# Media Player
      #prismlauncher    # MC Launcher
      #steam            # Games
      simple-scan      # Scanning
      #sshpass          # Ansible dependency
      # 
      # Laptop
      #cbatticon        # Battery Notifications
      blueman          # Bluetooth
      #light            # Display Brightness
      libreoffice      # Office Tools
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

  programs = {
    home-manager.enable = true;
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      #name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-gtk.override {
      #  accents = ["mauve"];
      #  size = "compact";
      #  variant = "mocha";
      #};
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