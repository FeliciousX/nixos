{
  # Original Author : Sebastian Zivota <loewenheim@mailbox.org>
  # transparent dracula theme for helix
  dracula-transparent =
    let
      background = "#282a36";
      background_dark = "#21222c";
      primary_highlight = "#800049";
      secondary_highlight = "#4d4f66";
      subtle = "#424450";
      foreground = "#f8f8f2";
      comment = "#6272a4";
      red = "#ff5555";
      orange = "#ffb86c";
      yellow = "#f1fa8c";
      green = "#50fa7b";
      purple = "#bd93f9";
      cyan = "#8be9fd";
      pink = "#ff79c6";
    in
    {
      "comment" = { fg = comment; };
      "constant" = { fg = purple; };
      "constant.character.escape" = { fg = pink; };
      "function" = { fg = green; };
      "keyword" = { fg = pink; };
      "operator" = { fg = pink; };
      "punctuation" = { fg = foreground; };
      "string" = { fg = yellow; };
      "string.regexp" = { fg = red; };
      "tag" = { fg = pink; };
      "type" = { fg = cyan; modifiers = [ "italic" ]; };
      "type.enum.variant" = { fg = foreground; modifiers = [ "italic" ]; };
      "variable" = { fg = foreground; };
      "variable.builtin" = { fg = cyan; modifiers = [ "italic" ]; };
      "variable.parameter" = { fg = orange; modifiers = [ "italic" ]; };

      "diff.plus" = { fg = green; };
      "diff.delta" = { fg = orange; };
      "diff.minus" = { fg = red; };

      "ui.background" = { fg = foreground; };
      "ui.cursor" = { fg = background; bg = orange; modifiers = [ "dim" ]; };
      "ui.cursor.match" = { fg = green; modifiers = [ "underlined" ]; };
      "ui.cursor.primary" = { fg = background; bg = cyan; modifiers = [ "dim" ]; };
      "ui.cursorline.primary" = { bg = background_dark; };
      "ui.help" = { fg = foreground; bg = background_dark; };
      "ui.linenr" = { fg = comment; };
      "ui.linenr.selected" = { fg = foreground; };
      "ui.menu" = { fg = foreground; bg = background_dark; };
      "ui.menu.selected" = { fg = cyan; bg = background_dark; };
      "ui.popup" = { fg = foreground; bg = background_dark; };
      "ui.selection" = { bg = secondary_highlight; };
      "ui.selection.primary" = { bg = primary_highlight; };
      "ui.statusline" = { fg = foreground; bg = background_dark; };
      "ui.statusline.inactive" = { fg = comment; bg = background_dark; };
      "ui.statusline.normal" = { fg = background_dark; bg = cyan; };
      "ui.statusline.insert" = { fg = background_dark; bg = green; };
      "ui.statusline.select" = { fg = background_dark; bg = purple; };
      "ui.text" = { fg = foreground; };
      "ui.text.focus" = { fg = cyan; };
      "ui.window" = { fg = foreground; };
      "ui.virtual.whitespace" = { fg = subtle; };
      "ui.virtual.ruler" = { bg = background_dark; };

      "error" = { fg = red; };
      "warning" = { fg = cyan; };

      "markup.heading" = { fg = purple; modifiers = [ "bold" ]; };
      "markup.list" = cyan;
      "markup.bold" = { fg = orange; modifiers = [ "bold" ]; };
      "markup.italic" = { fg = yellow; modifiers = [ "italic" ]; };
      "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };
      "markup.link.url" = cyan;
      "markup.link.text" = pink;
      "markup.quote" = { fg = yellow; modifiers = [ "italic" ]; };
      "markup.raw" = { fg = foreground; };

      "diagnostic.warning" = { underline = { color = orange; style = "curl"; }; };
      "diagnostic.error" = { underline = { color = red; style = "curl"; }; };
    };

}
