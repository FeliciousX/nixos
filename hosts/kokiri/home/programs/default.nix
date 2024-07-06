{ pkgs, ... }: {
  imports = [
    ../../../../modules-home-manager/fish
    ../../../../modules-home-manager/git.nix
    ../../../../modules-home-manager/helix
    ../../../../modules-home-manager/lf.nix
  ];

  home.packages = with pkgs; [
    btop # Resource Manager
    gping
    neofetch

    rsync # Syncer - $ rsync -r dir1/ dir2/
    unrar # Rar Files
    unzip # Zip Files
    zip # Zip

    # General configuration
    ipfs # protocol
    pciutils # Computer Utility Info
    usbutils # USB Utility Info
  ];
}
