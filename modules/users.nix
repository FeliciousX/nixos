{ config, lib, pkgs, ... }: {
  # TODO make this a generic users.nix
  users.users.fx = {
    initialHashedPassword = "";
    isNormalUser = true;
    description = "Churchill Lee";
    extraGroups = [ "wheel" ] ++ lib.optionals config.programs.adb.enable [ "adbusers" ]
      ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ]
      ++ lib.optionals config.oscereal.programs.devops.enable [ "docker" ];
  };
}
