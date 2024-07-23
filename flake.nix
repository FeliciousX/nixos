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

    simple-completion-language-server = {
      url = "github:estin/simple-completion-language-server/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      user = "fx";
      system = "x86_64-linux";
      config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "discord"
          "nvidia-persistenced"
          "nvidia-settings"
          "nvidia-x11"
          "obsidian"
          "spotify"
          "steam"
          "steam-original"
          "steam-run"
          "unrar"
          "vivaldi"
          "vscode"
        ];
        permittedInsecurePackages = lib.optional (pkgs.obsidian.version == "1.4.16") "electron-25.9.0";
      };
      pkgs = import nixpkgs {
        inherit system;
        inherit config;
      };
      unstable = import nixpkgs-unstable { inherit system; };
      lib = nixpkgs.lib;

      hyrule = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit user system pkgs unstable inputs;
        };
        modules = [
          ./hosts/hyrule/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit user system pkgs unstable inputs;
            };
            home-manager.users.${user} = import ./hosts/hyrule/home;
          }
        ];
      };

      tabantha = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit user system pkgs unstable inputs;
        };
        modules = [
          ./hosts/tabantha/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit user system pkgs unstable inputs;
            };
            home-manager.users.${user} = import ./hosts/tabantha/home;
          }
        ];
      };

      kokiri = lib.nixosSystem {
        system = "armv7l-linux";
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          ./hosts/kokiri/sd-image.nix
          ./hosts/kokiri/configuration.nix
        ];
      };
    in
    rec {
      nixosConfigurations = {
        inherit hyrule;
        inherit tabantha;
        inherit kokiri;
      };
      nixosConfigurations.images = {
        kokiri = nixosConfigurations.kokiri.config.system.build.sdImage;
      };
    };
}
