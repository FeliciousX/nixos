{ lib, user, ... }:

{
  services.openssh.enable = lib.mkDefault true;
  services.openssh.openFirewall = lib.mkDefault true;
  services.openssh.settings = {
    PasswordAuthentication = false;
  };

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPG8dpG+gfvMJCjw92U9uewjaZA+0QGeRi/ir19RFDK9 fx@nixos"
    ];
  };
}
