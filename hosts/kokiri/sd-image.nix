{ nixpkgs, ... }:

{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-armv7l-multiplatform-installer.nix"
  ];

  sdImage.compressImage = false;

  nixpkgs.hostPlatform.system = "armv7l-linux";
  nixpkgs.buildPlatform.system = "x86_64-linux";
}
