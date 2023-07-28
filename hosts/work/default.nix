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
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}