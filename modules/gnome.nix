{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.lightdm.greeters.pantheon.enable = true;
  #services.xserver.desktopManager.pantheon.enable = true;

  #services.xserver.dpi = 282;
  #services.gnome.core-developer-tools.enable = true;

  # important non-default applications
  #environment.systemPackages = with pkgs; [
    # enable heif support for eog & nautilus
    #libheif

    # additional apps
    #gnome.gnome-tweaks
    #gnome.gnome-boxes
  #];

  # TODO: enable gnome extension
  # nixpkgs.config.firefox.enableGnomeExtensions = true;
}
