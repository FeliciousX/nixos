{
  inputs = {
    # packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware }:
    let
      # this should be temporary (famous last words)
      nixFlakes = { pkgs, ... }: {
        nix = {
          package = pkgs.nixUnstable;
          extraOptions = ''
            experimental-features = nix-command flakes
          '';
        };
      };
    in {
      nixosConfigurations.urbosa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # enable nix flakes
          nixFlakes

          # hardware
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-ssd

          ./modules/urbosa.nix
          ./modules/bluetooth.nix
          ./modules/users.nix
          ./modules/firmware.nix
          ./modules/gnome.nix
          ./modules/localisation.nix
          ./modules/nixos.nix
          ./modules/pipewire.nix
          ./modules/programs.nix
          ./modules/ssh.nix
          ./modules/systemd-boot.nix
          ./modules/yubikey.nix
        ];
      };
    };
}
