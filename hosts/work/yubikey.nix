{ pkgs, ... }:

{
  security.pam.u2f.enable = true;
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # PCSC-Lite daemon, to access smart cards using SCard API (PC/SC)
  services.pcscd.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
