{ config, inputs, pkgs, unstable, lib, user, ... }:

{
  imports = [(import ./hardware-configuration.nix)]; 

  networking.hostName = "tabantha";

  time.timeZone = "Australia/Melbourne";

  system.stateVersion = "23.11"; # NOTE: read docs on `system.stateVersion` in `man configuration.nix` before changing

  # ######## #
  # Language #
  # ######## #

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ uniemoji libpinyin ];
  i18n.extraLocaleSettings = {
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

  # ####### #
  # Console #
  # ####### #

  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  # ##### #
  # Fonts #
  # ##### #

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    nerdfonts
    hack-font
  ];

  fonts.fontconfig = { antialias = lib.mkDefault true; };

  # ###### #
  # docker #
  # ###### #

  virtualisation.docker = {
    enable = true;
    package = unstable.pkgs.docker;
  };

  # ########## #
  # Networking #
  # ########## #

  # LAN communication
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking.domain = "local";
  networking.networkmanager.enable = true;
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

  # ######## #
  # Security #
  # ######## #

  security.polkit.enable = true;

  networking.firewall.enable = true;

  services.fail2ban = {
    enable = true;
    maxretry = 1;
    bantime-increment.enable = true;
    ignoreIP = [
      "192.168.31.0/24" # TODO: divide my network subnets for homelab
    ];
  };

  # ### #
  # SSH #
  # ### #

  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  # PCSC-Lite daemon, to access smart cards using SCard API (PC/SC)
  services.pcscd.enable = true;

  services.printing.enable = true;

  # ##### #
  # Media #
  # ##### #

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ##### #
  # Gnome #
  # ##### #

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # ##### #
  # Shell #
  # ##### #

  programs.fish.enable = true;

  # ########## #
  # Encryption #
  # ########## #

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # ################ #
  # Power Management #
  # ################ #

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.auto-cpufreq.enable = true;

  # #### #
  # User #
  # #### #

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = if config.services.openssh.enable then [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPG8dpG+gfvMJCjw92U9uewjaZA+0QGeRi/ir19RFDK9 fx@nixos"
    ] else [];
  };

  # ############ #
  # Nix settings #
  # #############

  nix.settings = {
    auto-optimise-store = true; # Optimise syslinks
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
}
