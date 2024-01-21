{ config, pkgs, lib, inputs, user, ... }: {

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "obsidian"
    "vivaldi"
    "vscode"
  ];

  nixpkgs.config.permittedInsecurePackages =
    lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0";

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ uniemoji libpinyin ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  networking.firewall.enable = true;

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
    };

    fail2ban = {
      enable = true;
      maxretry = 1;
      bantime-increment.enable = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
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
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable; # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = { stateVersion = "23.05"; };
}
