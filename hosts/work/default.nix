{ pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(modulesPath + "/installer/scan/not-detected.nix")] ++
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/desktop/gnome/default.nix)] ++ # Window Manager
    (import ../../modules/desktop/virtualisation) ++      # Virtual Machines & VNC
    (import ../../modules/hardware) ++                    # Hardware devices
    (import ../../modules/hardware/work);                 # Hardware specific quirks

  boot = {                                      # Boot options
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

  programs = {                                  # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;
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
    # samba = {                                   # File Sharing over local network
    #   enable = true;                            # Don't forget to set a password:  $ smbpasswd -a <user>
    #   shares = {
    #     share = {
    #       "path" = "/home/${user}";
    #       "guest ok" = "yes";
    #       "read only" = "no";
    #     };
    #   };
    #   openFirewall = true;
    # };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}