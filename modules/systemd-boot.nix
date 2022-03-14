{ ... }: {
  # TODO assert that the system actually uses EFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  # boot.loader.efi.efiSysMountPoint = "/boot/EFI";
}
