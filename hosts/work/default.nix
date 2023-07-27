{ pkgs, lib, user, ... }:

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

  services = {
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
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.bluetooth.enable = true;
  services.fwupd.enable = true;
  hardware.enableRedistributableFirmware = true;
}