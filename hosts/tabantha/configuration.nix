{ inputs, pkgs, unstable, lib, user, ... }:

let
  hostName = "tabantha";
  timeZone = "Australia/Melbourne";
in
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./language.nix
    ./console.nix
    ./networking.nix
    ./yubikey.nix
    ./bluetooth.nix
    ./ssh.nix
    ./android.nix
    ./distributed-build.nix
  ];

  networking.hostName = hostName;
  time.timeZone = timeZone;

  system.stateVersion = "23.11"; # NOTE: read docs on `system.stateVersion` in `man configuration.nix` before changing

  # ##### #
  # Fonts #
  # ##### #

  fonts.packages = builtins.attrValues {
    inherit (pkgs)
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      nerdfonts
      hack-font
      ibm-plex
      ;
  };

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

  # syncthing ports
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  # /syncthing ports

  services.fail2ban = {
    enable = true;
    maxretry = 1;
    bantime-increment.enable = true;
    ignoreIP = [
      "192.168.0.0/24"
      "192.168.10.0/24"
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
  specialisation = {
    gnome.configuration = {
      services.xserver.enable = true;
      services.xserver.xkb.layout = "us";
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
      services.xserver.desktopManager.gnome.debug = true;
    };
  };

  # ######## #
  # Hyprland #
  # ######## #
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # ################ #
  # Power Management #
  # ################ #

  services.power-profiles-daemon.enable = false;

  services.tlp.enable = false;
  services.auto-cpufreq.enable = true;

  # ############### #
  # System Packages #
  # ############### #

  environment.systemPackages = builtins.attrValues
    {
      inherit (unstable)
        nh
        nix-output-monitor
        helix
        scrcpy# temporarily here until 2.4 is in stable
        ;
      inherit (pkgs)
        apacheHttpd
        cifs-utils
        dig
        inetutils
        sshfs
        wireguard-tools
        eww
        dunst# notification daemon
        libnotify# dunst dep
        wofi
        ;
    } ++ [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
  ];

  # TODO: use a variable
  environment.variables.FLAKE = "/etc/nixos";

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

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs          = true
    keep-derivations      = true
  '';
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
}
