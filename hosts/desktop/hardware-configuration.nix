# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # ##########.#
  # Bootloader.#
  # ##########.#

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-bcd5bc8e-b885-4115-b190-07c3d9e7e0f6".device = "/dev/disk/by-uuid/bcd5bc8e-b885-4115-b190-07c3d9e7e0f6";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # ########## #
  # Partitions #
  # ########## #

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c535ef35-740d-4893-a5eb-266d7cf34d23";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-e04009c1-eec5-4a2f-9ba6-f19562d8fda6".device = "/dev/disk/by-uuid/e04009c1-eec5-4a2f-9ba6-f19562d8fda6";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C0F6-1F22";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b38607d3-580e-4b0e-9512-1fdb816e10c9"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # ######## #
  # Hardware #
  # ######## #

  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.pulseaudio.enable = lib.mkDefault false;
  hardware.opengl.enable = lib.Mkdefault true;
  hardware.opengl.driSupport = lib.Mkdefault true;
  hardware.opengl.driSupport32Bit = lib.Mkdefault true;

}
