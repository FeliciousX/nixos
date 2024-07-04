{ pkgs, ... }: {
  imports = [
    ../../../../modules-home-manager/alacritty.nix
    ../../../../modules-home-manager/fish
    ../../../../modules-home-manager/git.nix
    ../../../../modules-home-manager/helix
    ../../../../modules-home-manager/lf.nix
    ../../../../modules-home-manager/nix-index.nix
    ../../../../modules-home-manager/starship.nix
    ../../../../modules-home-manager/zellij.nix
  ];

  home.packages = with pkgs; [
    # tui apps
    graph-easy
    nmap

    # Terminal
    bat
    bitwarden-cli
    btop # Resource Manager
    delta
    du-dust
    eza
    fd
    fzf
    fzy
    gping
    jq
    neofetch
    procs
    pv
    ripgrep

    rsync # Syncer - $ rsync -r dir1/ dir2/
    syncthing # File Sync
    unrar # Rar Files
    unzip # Zip Files
    zip # Zip

    # General configuration
    ipfs # protocol
    pciutils # Computer Utility Info
    usbutils # USB Utility Info
    wget # Downloader
  ];
}
