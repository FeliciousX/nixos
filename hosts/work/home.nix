{ pkgs, ... }:

{
  home = {
 
     packages = with pkgs; [

      # tui apps
      graph-easy
      nmap
      slides

      # nice to have gui apps
      # fractal is broken, comment for now
      #fractal 
      chromium
      darktable
      dbeaver
      firefox
      mysql-workbench
      protonvpn-gui
      telegram-desktop
      vscode

      # version control
      gh

      blueman          # Bluetooth

      # Dependencies
      jdk11
      maven
      mariadb
    ];

    file.".ssh/authorized_keys" = {
      enable = true;
      text = ''
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkKqanh7Sv2R87JCioUgwFxydgrJXkMwyaw1Xck5EqWl3z6FKzvteiPAJkE7sk5KvIEB01fxUgPYrsrWpYFslsk+kWgSB6l02+ehmbliKR1DxW6XEaFaflir/vbsKUMYMtihkM3IO83C5CyvUXqCpl3llBO4ZEsuKoKtz3RZVwZYLlh5Z1gUzqb7SiwrjFupfOs0NZdlqtJyyGFF5botMjAQ5nCSeDD8W02iKVAZboBK7/1Z/Ms9PVC7AhsceG8LRTU73KWt5H28rcIMNZ4sQ7+fe2we94XyE8Pil7V46mCJUGfs31XjNLpGCSBDUZiPsvzCWm9MeuoPSEbJgyRK6AbosZ9CLesEWP9lhwOE6Qfp+yrCNdi0wJ7UP9X7Fp+fb2/OvGCeJpV9ipimixpm8aeO2+pfvlGDtvHhwHUyeiwZXQZuvOWyKKhLvSuA7KhyYfVishXyCwPypkFD5X6mNpABUODHLsAJdDjWj5H3xKPLqEKrKcLEESFht47ZYadJM= #! feliciousx
      '';
      target = ".ssh/authorized_keys";
    };
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
    flameshot.enable = true;              # Screenshot
  };
}
