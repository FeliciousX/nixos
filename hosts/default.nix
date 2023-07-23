{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  work = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit unstable inputs user;
      host = {
        hostname = "work";
      };
    };
    modules = [
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstsable user;
          host = {
            hostName = "work";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./work/home.nix)];
        };
      }
    ];
  };
}