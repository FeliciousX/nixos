{ ... }:

{
  nix.settings.trusted-users = [ "nixremote" ];

  users.users.nixremote = {
    isNormalUser = true;

    openssh.authorizedKeys.keys =
      [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJao7dzj4D0cG7W3mehI5slhFo/fMyU7cpNr9HAhRAXB root@tabantha"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsUh9qG8190umG1Y3pMqu3YSFig+WS5stDpFOjWj/zA root@nixos"
      ];
  };
}
