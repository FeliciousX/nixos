{ config, lib, user, ... }:

{
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "desktop";
      systems = [ "x86_64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }
  ];
}
