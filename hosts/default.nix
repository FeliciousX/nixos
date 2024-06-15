{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
  };
in
{
  work = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit unstable inputs user;
    };
    modules = [
      ./work
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./work/home.nix)];
        };
      }
    ];
  };

  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit unstable inputs user;
    };
    modules = [
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit unstable user;
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
    ];
  };
}
