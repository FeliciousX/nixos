{ ... }: {
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # enable fail2ban
  services.fail2ban.enable = true;
  services.fail2ban.maxretry = 1;
  services.fail2ban.bantime-increment.enable = true;
}
