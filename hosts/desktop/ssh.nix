{ config, lib, user, ... }:

{
  services.openssh.enable = lib.mkDefault true;
  services.openssh.openFirewall = lib.mkDefault true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  users.users.${user} = {
    openssh.authorizedKeys.keys =
      if config.services.openssh.enable then [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzBvauAQglStcoos5RaFC6ITuOavBYksmuNtbOW2R+o xps15@feliciousx.com"
      ] else [ ];
  };
}
