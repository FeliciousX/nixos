{ lib, ... }:

{
  services.adguardhome.enable = lib.mkDefault true;
  services.adguardhome.openFirewall = true;

  services.adguardhome.settings = {
    auth_attemptes = 0;
    block_auth_min = 0;
  };
}
