{ config, lib, user, ... }:

{
  users.users.nixremote = {
    isNormalUser = true;

    openssh.authorizedKeys.keys =
      [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJao7dzj4D0cG7W3mehI5slhFo/fMyU7cpNr9HAhRAXB root@tabantha"
      ];
  };
}
