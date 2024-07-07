{ inputs, pkgs, unstable, lib, user, ... }:

let
  hostName = "tabantha";
  timeZone = "Australia/Melbourne";
in
{
  imports = [
    ./hardware-configuration.nix
    ./language.nix
    ./networking.nix
    ./yubikey.nix
    ./bluetooth.nix
    ./ssh.nix
    ./distributed-build.nix
  ];

  networking.hostName = hostName;
  time.timeZone = timeZone;

  system.stateVersion = "23.11"; # NOTE: read docs on `system.stateVersion` in `man configuration.nix` before changing

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
    ibm-plex
  ];

  fonts.fontconfig = { antialias = lib.mkDefault true; };

  # ###### #
  # docker #
  # ###### #

  virtualisation.docker = {
    enable = true;
    package = unstable.pkgs.docker;
  };

  services.printing.enable = true;

  networking.domain = "local";

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

  # ########## #
  # Encryption #
  # ########## #

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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

  # ################ #
  # Power Management #
  # ################ #

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.auto-cpufreq.enable = true;

  # ##### #
  # Shell #
  # ##### #

  programs.fish.enable = true;

  # #### #
  # User #
  # #### #

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
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
