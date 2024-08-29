{ pkgs, user, ... }:

let
  session = "${pkgs.hyprland}/bin/Hyprland";
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  # when tuigreet supports theme, add this
  # theme = "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red;";
in
{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        inherit user;
        command = session;
      };
      default_session = {
        command = "${tuigreet} --greeting 'CAUTION: FINAL ATTEMPT' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };
}
