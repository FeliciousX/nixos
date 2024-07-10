{ ... }:

{
  services.blocky.enable = false;

  services.blocky.settings = {
    ports = {
      dns = 53;
      tls = 853;
      https = 443;
      http = 4000;
    };
    upstreams.groups.default = [
      "tcp+udp:1.1.1.1"
      "https://1.1.1.1/dns-query"
    ];

    log = {
      level = "info";
    };

    # For initially solving DoH/DoT Requests when no system Resolver is available.
    bootstrapDns = [
      "tcp+udp:1.1.1.1"
      "https://1.1.1.1/dns-query"
    ];

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
