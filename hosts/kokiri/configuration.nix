let
  hostName = "kokiri";
  timeZone = "Australia/Melbourne";
in
{ pkgs, lib, ... }:

{
  imports = [
    ./ssh.nix
    ./distributed-build.nix
    ./adguardhome.nix
    #./blocky.nix
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

  time.timeZone = timeZone;

  # disable sound
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # systemPackages
  environment.systemPackages = with pkgs; [
    curl
    iptables
    vim
    wget
    inetutils
  ];

  programs.bash.enableCompletion = true;

  networking.firewall.enable = false;

  hardware = {
    enableRedistributableFirmware = true;
  };

  # ########## #
  # Networking #
  # ########## #

  networking = {
    interfaces.enu1u1 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.31.111";
        prefixLength = 24;
      }];
    };
  };

  networking.domain = "local";
  networking.networkmanager.enable = false;
  networking.wireless.enable = false;

  # forwarding
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv4.tcp_ecn" = true;
  };

  users.defaultUserShell = pkgs.bash;
  users.mutableUsers = false;
  users.users.nixos = {
    shell = pkgs.bash;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "23.05";
}
