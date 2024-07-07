{ config, lib, ... }: {
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    open = lib.mkDefault false;
    nvidiaSettings = true;
    nvidiaPersistenced = lib.mkDefault false;
    powerManagement.enable = false;
  };
}
