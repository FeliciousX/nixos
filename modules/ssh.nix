{ ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.permitRootLogin = "no";
  services.openssh.settings.passwordAuthentication = false;

  # enable fail2ban
  services.fail2ban.enable = true;
  services.fail2ban.maxretry = 1;
  services.fail2ban.bantime-increment.enable = true;
}
