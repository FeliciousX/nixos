{ pkgs, ... }: {
  gtk.enable = true;
  gtk.theme = {
    # Cursor is declared under home.pointerCursor
    name = "Dracula";
    package = pkgs.dracula-theme;
  };
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  gtk.font = {
    name = "Hack Font Mono Medium";
  };

  home = {
    # This will set cursor system-wide so applications can not choose their own
    pointerCursor = {
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
  };
}
