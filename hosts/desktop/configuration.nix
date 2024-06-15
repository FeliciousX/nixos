# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, unstable, user, ... }:
let
  lib = pkgs.lib;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-bcd5bc8e-b885-4115-b190-07c3d9e7e0f6".device = "/dev/disk/by-uuid/bcd5bc8e-b885-4115-b190-07c3d9e7e0f6";

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzBvauAQglStcoos5RaFC6ITuOavBYksmuNtbOW2R+o xps15@feliciousx.com" ];

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
      # 
      libreoffice      # Office Tools
      #
      # Flatpak
      obs-studio       # Recording/Live Streaming
    ];
  };

  virtualisation.docker = {
    enable = true;
    package = unstable.pkgs.docker;
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # gaming
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ uniemoji libpinyin ];
    };
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  networking.extraHosts = 
    ''
      127.0.0.1 search-dashboards.local
      127.0.0.1 mockserver.zenu.dv
      127.0.0.1 zenu.dv
      127.0.0.1 www.zenu.dv
      127.0.0.1 zone.zenu.dv
      127.0.0.1 db.zenu.dv
      127.0.0.1 replica.db.zenu.dv
      127.0.0.1 search.zenu.dv
      127.0.0.1 memcached.zenu.dv
      127.0.0.1 redis.zenu.dv
      127.0.0.1 tunnel.zenu.dv
      127.0.0.1 s3.zenu.dv
      127.0.0.1 zenu.test
      127.0.0.1 www.zenu.test
      127.0.0.1 subzero.dv
      127.0.0.1 www.subzero.dv
      127.0.0.1 subzero.test
      127.0.0.1 www.subzero.test
      127.0.0.1 e2e.subzero.test
      127.0.0.1 dev.zenu.com.au
      127.0.0.1 db.westeros.dv
      127.0.0.1 search.braavos.dv
      127.0.0.1 search.westeros.dv
      127.0.0.1 memcached.westeros.dv
      127.0.0.1 westeros.dv
      127.0.0.1 www.westeros.dv
      127.0.0.1 www.westeros.test
      127.0.0.1 admin.westeros.dv
      127.0.0.1 braavos.dv
      127.0.0.1 www.braavos.dv
      127.0.0.1 www.braavos.test
      127.0.0.1 business.braavos.dv
      127.0.0.1 www.business.braavos.dv
      127.0.0.1 holiday.braavos.dv
      127.0.0.1 www.holiday.braavos.dv
      127.0.0.1 rural.braavos.dv
      127.0.0.1 www.rural.braavos.dv
      127.0.0.1 dev.developerrealestateview.com.au
    '';

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      nerdfonts
      hack-font
    ];

    fontconfig = { antialias = lib.mkDefault true; };
  };

  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    fail2ban = {
      enable = true;
      maxretry = 1;
      bantime-increment.enable = true;
      ignoreIP = [
        "192.168.31.0/24" # TODO: divide my network subnets for homelab
      ];
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # Needed to use Yubikey Smartcard Mode
    pcscd.enable = true;

    printing = {
      enable = true;
    };
  };

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nix = { # Nix Package Manager settings
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = { # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
