{ pkgs, ... }: {
  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ uniemoji libpinyin ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nerdfonts ];
}
