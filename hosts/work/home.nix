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

  # ####### #
  # Applets #
  # ####### #

  services.blueman-applet.enable = true;         # Bluetooth
  services.flameshot.enable = true;              # Screenshot

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

    packages = with pkgs; [
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
      nil
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
      #alacritty         # Terminal Emulator
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
      libreoffice      # Office Tools
      #light            # Display Brightness
      #simple-scan      # Scanning
      #
      # Flatpak
      obs-studio       # Recording/Live Streaming

      # tui apps
      graph-easy
      nmap
      slides

      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      chromium
      darktable
      dbeaver
      mysql-workbench
      protonvpn-gui
      telegram-desktop
      vscode

      # version control
      gh

      blueman          # Bluetooth

      # Dependencies
      jdk11
      maven
      mariadb
    ];

    stateVersion = "23.05"; # NOTE: read docs on `home.stateVersion` in `man home-configuration.nix` before changing
  };
}
