{ lib, ... }:

{
  services.openssh.enable = lib.mkDefault true;
  services.openssh.openFirewall = lib.mkDefault true;
  services.openssh.settings = {
    PasswordAuthentication = false;
  };

  users.users.nixos = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPG8dpG+gfvMJCjw92U9uewjaZA+0QGeRi/ir19RFDK9 fx@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzBvauAQglStcoos5RaFC6ITuOavBYksmuNtbOW2R+o xps15@feliciousx.com"
    ];
  };
}
