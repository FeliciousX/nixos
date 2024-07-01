{ ... }:

{
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "hyrule.local";
      systems = [ "x86_64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }
  ];

  programs.ssh.extraConfig = ''
    Host hyrule.local
      HostName hyrule.local
      User nixremote
      IdentitiesOnly yes
      IdentityFile /root/.ssh/nixremote
  '';
}
