# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./neovim.nix
    ];

  # LUKS config
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p1";
      preLVM = true;
    }
  ];

  # Kernel setting
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  networking.hostName = "revali";
  networking.networkmanager.enable = true;

  networking.interfaces.enp3s0f0.useDHCP = true;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  time.timeZone = "Asia/Kuala_Lumpur";

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.git
    pkgs.gitAndTools.hub
    pkgs.zsh
    pkgs.ripgrep
    pkgs.du-dust
    pkgs.exa
    pkgs.fzy
    pkgs.exa
    pkgs.oh-my-zsh
    pkgs.tlp
    pkgs.tmux
    pkgs.tmuxp
    pkgs.which
    pkgs.htop
    pkgs.wget
    pkgs.ipfs
    pkgs.xorg.xhost
    pkgs.firefox
    pkgs.chromium
    pkgs.peek
    pkgs.tdesktop
    pkgs.vscode
    pkgs.alacritty
    pkgs.tilix
    pkgs.syncthing
    pkgs.docker
    pkgs.docker-compose
    pkgs.keepass
    pkgs.xdotool # for autotyping. keepass needs it
    pkgs.spotify
    pkgs.google-cloud-sdk
    pkgs.nodejs-12_x
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
    };
    enableCompletion = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
      custom = "$HOME/projects/dotfiles/oh-my-zsh";
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #services.ipfs.enable = true;
  services.tlp.enable = true;
  services.syncthing.enable = true;

  # dbus
  services.dbus.enable = true;
  services.dbus.socketActivated = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;

  users.users.fx = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "networkmanager" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

