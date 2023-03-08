{ config, lib, pkgs, ... }: {
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs;
    lib.optionals config.services.xserver.enable [ yubioath-flutter yubikey-manager ];
}
