{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.lightdm.greeters.pantheon.enable = true;
  #services.xserver.desktopManager.pantheon.enable = true;

  #services.xserver.dpi = 282;
  #services.gnome.core-developer-tools.enable = true;

  # TODO: enable gnome extension
  # nixpkgs.config.firefox.enableGnomeExtensions = true;
}
