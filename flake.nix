{
  description = "Personal NixOS System Flake Config";
  inputs = {
    # packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      user = "fx";
      system = "x86_64-linux";
      config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "discord"
          "obsidian"
          "spotify"
          "steam"
          "steam-original"
          "steam-run"
          "vivaldi"
          "vscode"
          "unrar"
        ];
        permittedInsecurePackages = lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0";
      };
      pkgs = import nixpkgs {
        inherit system;
        inherit config;
      };
      unstable = import nixpkgs-unstable { inherit system; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit user system pkgs unstable inputs;
          };
          modules = [
            ./hosts/desktop/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user system pkgs unstable inputs;
              };
              home-manager.users.${user} = import ./hosts/desktop/home;
            }
          ];
        };

        work = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit unstable inputs user;
          };
          modules = [
            ./hosts/work/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user system pkgs unstable inputs;
              };
              home-manager.users.${user} = import ./hosts/work/home;
            }
          ];
        };

      };
    };
}
