{ config, pkgs, lib, user, ... }: {

  users.users.${user} = {
    initialHashedPassword = "";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ uniemoji libpinyin ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  fonts = {
    fonts = with pkgs; [
       noto-fonts
       noto-fonts-cjk
       noto-fonts-emoji
       noto-fonts-extra
       nerdfonts
       hack-font
    ];

    fontconfig = {
      antialias = lib.mkDefault true;
    };
  };
    
  services = {
    openssh = {
      enable = true;
    };

    fail2ban = {
      enable = true;
      maxretry = 1;
      bantime-increment.enable = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
