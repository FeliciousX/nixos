{ ... }:

{
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  networking.networkmanager.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # TODO: setup local dev dns
  networking.extraHosts =
    ''
      127.0.0.1 dashboards.search.zenu.com.au
      127.0.0.1 mockserver.zenu.dv
      127.0.0.1 zenu.dv
      127.0.0.1 www.zenu.dv
      127.0.0.1 zone.zenu.dv
      127.0.0.1 db.zenu.dv
      127.0.0.1 replica.db.zenu.dv
      127.0.0.1 search.zenu.dv
      127.0.0.1 memcached.zenu.dv
      127.0.0.1 redis.zenu.dv
      127.0.0.1 localstack.zenu.dv
      127.0.0.1 rev-dev.s3.localstack.zenu.dv
      127.0.0.1 rev-images-dev.s3.localstack.zenu.dv
      127.0.0.1 tunnel.zenu.dv
      127.0.0.1 zenu.test
      127.0.0.1 www.zenu.test
      127.0.0.1 subzero.dv
      127.0.0.1 www.subzero.dv
      127.0.0.1 subzero.test
      127.0.0.1 www.subzero.test
      127.0.0.1 e2e.subzero.test
      127.0.0.1 dev.zenu.com.au
      127.0.0.1 db.westeros.dv
      127.0.0.1 search.braavos.dv
      127.0.0.1 search.westeros.dv
      127.0.0.1 memcached.westeros.dv
      127.0.0.1 westeros.dv
      127.0.0.1 www.westeros.dv
      127.0.0.1 www.westeros.test
      127.0.0.1 admin.westeros.dv
      127.0.0.1 braavos.dv
      127.0.0.1 www.braavos.dv
      127.0.0.1 www.braavos.test
      127.0.0.1 business.braavos.dv
      127.0.0.1 www.business.braavos.dv
      127.0.0.1 holiday.braavos.dv
      127.0.0.1 www.holiday.braavos.dv
      127.0.0.1 rural.braavos.dv
      127.0.0.1 www.rural.braavos.dv
      127.0.0.1 dev.developerrealestateview.com.au
      127.0.0.1 ftp.xml-imports.westeros.dv
      127.0.0.1 sqs.ap-southeast-2.localstack.zenu.dv
    '';
}
