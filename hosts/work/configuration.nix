{ inputs, pkgs, unstable, lib, user, ... }:

{
  imports = [(import ./hardware-configuration.nix)]; 

  boot = {                                      # Boot options
    initrd.luks.devices.root = {
      device = "/dev/disk/by-label/NIXLUKS";
      preLVM = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {                                  # EFI Boot
      efi = {
        canTouchEfiVariables = false;
        # efiSysMountPoint = "/boot/efi";
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;                 # Limit the amount of configurations
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  services = {
    fwupd.enable = true;
    power-profiles-daemon.enable = false;
    tlp.enable = true;                          # TLP and auto-cpufreq for power management
    auto-cpufreq.enable = true;
    blueman.enable = true;                      # Bluetooth
    avahi = {                                   # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = {                               # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    xserver.enable = true;
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;

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

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPG8dpG+gfvMJCjw92U9uewjaZA+0QGeRi/ir19RFDK9 fx@nixos" ];
  };

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

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

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

  virtualisation.docker = {
    enable = true;
    package = unstable.pkgs.docker;
  };

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

  systemd.services.NetworkManager-wait-online.enable = false;

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
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
