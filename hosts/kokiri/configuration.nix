let
  hostName = "kokiri";
in
{ user, pkgs, lib, ... }:

{
  imports = [
    ./ssh.nix
    ./distributed-build.nix
  ];

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Disable ZFS on kernel 6
  boot.supportedFilesystems = lib.mkForce [
    "vfat"
    "xfs"
    "cifs"
    "ntfs"
  ];

  # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
  boot.kernelParams = [ "cma=256M" ];

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  networking.hostName = hostName;

  # disable sound
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # systemPackages
  environment.systemPackages = with pkgs; [
    curl
    iptables
    vim
    #wget
    inetutils
  ];

  # Some sample service.
  # Use dnsmasq as internal LAN DNS resolver.
  services.dnsmasq = {
    enable = false;
    settings.servers = [ "1.1.1.1" ];
  };

  programs.fish = {
    enable = true;
  };

  networking.firewall.enable = false;

  hardware = {
    enableRedistributableFirmware = true;
  };

  # ########## #
  # Networking #
  # ########## #

  /**
    networking = {
    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.31.111";
        prefixLength = 24;
      }];
      };
    };
  **/

  networking.domain = "local";
  networking.networkmanager.enable = false;
  networking.wireless.enable = false;

  # forwarding
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv4.tcp_ecn" = true;
  };

  users.defaultUserShell = pkgs.fish;
  users.mutableUsers = false;
  users.groups.${user} = {
    gid = 1000;
    name = user;
  };
  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/${user}";
    name = user;
    group = user;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "23.05";
}
