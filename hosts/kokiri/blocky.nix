{ lib, ... }:

{
  services.blocky.enable = lib.mkDefault true;

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
        ads = [
          "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://adaway.org/hosts.txt"
          "https://v.firebog.net/hosts/AdguardDNS.txt"
        ];
        suspicious = [
          "https://v.firebog.net/hosts/static/w3kbl.txt"
        ];
        tracking = [
          "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
          "https://v.firebog.net/hosts/Easyprivacy.txt"
          "https://v.firebog.net/hosts/Prigent-Ads.txt"
          "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"
          "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt"
          "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"
        ];
        malicious = [
          "http://phishing.mailscanner.info/phishing.bad.sites.conf"
          "https://v.firebog.net/hosts/Prigent-Crypto.txt"
        ];
      };
      #Configure what block categories are used
      clientGroupsBlock = {
        default = [
          "ads"
          "suspicious"
          "tracking"
          "malicious"
        ];
      };
    };

    hostsFile = {
      filePath = "/etc/hosts";
    };
  };
}
