{
  description = "Personal NixOS System Flake Config";
  inputs = {
    # packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    simple-completion-language-server = {
      url = "github:estin/simple-completion-language-server/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, lix-module, home-manager, ... }:
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
          "unrar"
          "vivaldi"
          "vscode"
          "zoom"
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
          lix-module.nixosModules.default

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
      devShells.${system}.default = pkgs.mkShell {

        packages = pkgs.lib.attrVals [
          "just"
          "fish"
        ]
          pkgs;

        shellHook = ''
          exec fish
        '';
      };
    };
}
