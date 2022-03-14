{ ... }: {
  hardware.bluetooth.enable = true;

  # TODO: figure out bluetooth settings for XPS 15 7590
  # hardware.bluetooth.settings = {
  #   General = { ControllerMode = "bredr"; }; # for compatibility with airpods
  #   Policy = { AutoEnable = "true"; };
  # };
}
