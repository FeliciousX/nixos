{ config, lib, pkgs, modulesPath, ... }: {
  # urbosa hardware
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  # TODO: setup luks
  # boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/ba89bde6-f915-4cfa-bcf0-8183610e2042";
  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-label/NIXLUKS";
    preLVM = true;
  };
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/503740f9-fe89-4463-b675-ebb5a6117b9c"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

  # urbosa VM options
  # TODO: try it, might be broken: https://github.com/NixOS/nixpkgs/issues/59219
  # virtualisation.cores = 4;
  # virtualisation.diskSize = 8192;
  # virtualisation.memorySize = 4096;

  # urbosa system
  networking.hostName = "urbosa";
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp59s0.useDHCP = true;

  # urbosa-only programs
  environment.systemPackages = with pkgs; [
    # browsers
    vivaldi
    vivaldi-widevine
    vivaldi-ffmpeg-codecs
    chromium
    firefox-wayland

    # almost browsers
    spotify
    vscode
  ];

  # special programs
  programs.steam.enable = true;
  programs.gnupg.agent.enable = true;

  # enable oscereal extras
  oscereal.programs.fish.enable = true;
  oscereal.programs.base.enable = true;
  oscereal.programs.extras.enable = true;
  oscereal.programs.programming.enable = true;
  oscereal.programs.devops.enable = true;
  oscereal.programs.hacking.enable = true;
  oscereal.programs.android.enable = false;
  oscereal.programs.office.enable = true;
  oscereal.programs.work.enable = true;
}
