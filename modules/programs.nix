{ config, pkgs, ... }: {
  packages = with pkgs; [
    # lib-kinda stuff
    ntfs3g
    unzip

    # classic *nix
    curl
    wget
    htop
    btop

    # editor
    kakoune
    kakoune-cr
    kak-lsp
    neovim
    helix

    # cli apps
    ngrok
    #magic-wormhole
    tmux
    tmuxp
    # clip apps that only make sense on gui systems
    trash-cli
    wl-clipboard
    xclip
    orca

    # gui apps i always need
    logseq
    keepassxc

    # essential extras
    ibm-plex
    chezmoi
    syncthing

    # modern *nix
    bat
    bottom
    dog
    duf
    du-dust
    exa
    fd
    fzf
    fzy
    gping
    gum
    hyperfine
    jq
    nnn
    procs
    pv
    ripgrep
    tz

    # cli apps
    niv
    taskwarrior
    exiftool
    ffmpeg-full
    youtube-dl
    # nice to have gui apps
    # fractal is broken, comment for now
    #fractal 
    gimp
    vlc
    alacritty
    bitwarden
    discord
    tdesktop
    dbeaver
    tor-browser-bundle-bin
    tilix
    transmission-gtk
    transmission-qt
    # to use with lorri
    direnv

    # version control
    delta
    git
    gh

    # protocols
    ipfs

    # essential programming languages
    nodejs
    python3

    # linting & other useful tools
    nixfmt
    nodePackages.eslint
    pipenv
  ];
}
