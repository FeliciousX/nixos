{
  description = "Personal NixOS System Flake Config";
  inputs = {
    # packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland = {
      #url = "github:vaxerski/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    #}
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      user = "fx";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager user;
        }
      );
    };
}
