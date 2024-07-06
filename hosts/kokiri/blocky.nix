{ lib, ... }:

{
  services.blocky.enable = lib.mkDefault true;

  services.blocky.settings = {
    ports.dns = 53;
    upstreams.groups.default = [
      "https://cloudflare-dns.com/dns-query"
    ];

    # For initially solving DoH/DoT Requests when no system Resolver is available.
    bootstrapDns = {
      upstream = "https://cloudflare-dns.com/dns-query";
      ips = [ "1.1.1.1" "1.0.0.1" ];
    };

    #Enable Blocking of certian domains.
    blocking = {
      blackLists = {
        #Adblocking
        ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        #You can add additional categories
      };
      #Configure what block categories are used
      clientGroupsBlock = {
        default = [ "ads" ];
        kids-ipad = [ "ads" "adult" ];
      };
    };
  };
}
