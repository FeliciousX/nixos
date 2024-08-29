{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    extraPackages = builtins.attrValues {
      inherit (pkgs)
        gtksourceview
        webkitgtk
        accountsservice
        ;
    };
  };
}
