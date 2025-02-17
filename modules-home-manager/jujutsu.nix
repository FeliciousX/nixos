{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.jujutsu
  ];

  programs.jujutsu.enable = lib.mkDefault true;

  programs.jujutsu.settings = {
    user.name = "FeliciousX";
    user.email = "hello@feliciousx.dev";
    signing = {
      sign-all = true;
      key = "6983E79E35A1E9BF2DDD415447AA4884B840A95F";
      backend = "gpg";
    };
  };

}
