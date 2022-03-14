{ config, lib, ... }: {
  # make sure these options are set to false, along with assertions
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  assertions = [
    {
      assertion = !config.sound.enable;
      message = "Enabling `sound.enable` conflicts with Pipewire";
    }
    {
      assertion = !config.hardware.pulseaudio.enable;
      message = "Enabling `hardware.pulseaudio.enable` conflicts with Pipewire";
    }
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
