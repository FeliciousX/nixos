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

  # zenu related
  # TODO: check if work?
  networking.extraHosts = 
    ''
      127.0.0.1 search-dashboards.local
      127.0.0.1 zenu.dv
      127.0.0.1 www.zenu.dv
      127.0.0.1 zone.zenu.dv
      127.0.0.1 db.zenu.dv
      127.0.0.1 replica.db.zenu.dv
      127.0.0.1 search.zenu.dv
      127.0.0.1 memcached.zenu.dv
      127.0.0.1 redis.zenu.dv
      127.0.0.1 tunnel.zenu.dv
      127.0.0.1 s3.zenu.dv
      127.0.0.1 zenu.test
      127.0.0.1 www.zenu.test
      127.0.0.1 subzero.dv
      127.0.0.1 www.subzero.dv
      127.0.0.1 subzero.test
      127.0.0.1 www.subzero.test
      127.0.0.1 e2e.subzero.test
      127.0.0.1 dev.zenu.com.au
      127.0.0.1 local-zenu.ap-southeast-2.es.amazonaws.com
      127.0.0.1 db.westeros.dv
      127.0.0.1 search.braavos.dv
      127.0.0.1 search.westeros.dv
      127.0.0.1 memcached.westeros.dv
      127.0.0.1 westeros.dv
      127.0.0.1 www.westeros.dv
      127.0.0.1 www.westeros.test
      127.0.0.1 admin.westeros.dv
      127.0.0.1 braavos.dv
      127.0.0.1 www.braavos.dv
      127.0.0.1 www.braavos.test
      127.0.0.1 business.braavos.dv
      127.0.0.1 www.business.braavos.dv
      127.0.0.1 holiday.braavos.dv
      127.0.0.1 www.holiday.braavos.dv
      127.0.0.1 rural.braavos.dv
      127.0.0.1 www.rural.braavos.dv
      127.0.0.1 www.bytey.dv
      127.0.0.1 dev.developerrealestateview.com.au
    '';

  # urbosa-only programs
  environment.systemPackages = with pkgs; [
    # browsers
    vivaldi
    widevine-cdm
    vivaldi-ffmpeg-codecs
    chromium
    firefox-wayland

    # almost browsers
    spotify
    vscode
  ];

  # special programs
  programs.steam.enable = true;

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
