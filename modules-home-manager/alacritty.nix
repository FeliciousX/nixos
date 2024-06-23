{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
        decorations = "none";
        startup_mode = "Maximized";
      };

      font = {
        normal = {
          family = "Hack";
          style = "Regular";
        };
        bold = {
          family = "Hack";
          style = "Bold";
        };
        italic = {
          family = "Hack";
          style = "Italic";
        };
        bold_italic = {
          family = "Hack";
          style = "Bold Italic";
        };
      };
    };
  };
}
