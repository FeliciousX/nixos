{ user, pkgs, ... }:

{
  # Android Debug Bridge
  programs.adb.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  users.users.${user} = {
    extraGroups = [ "adbusers" ];
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      apksigner
      ;
  };
}
