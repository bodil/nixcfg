{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];


  systemd.extraConfig = "";
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    LidSwitchIgnoreInhibited=yes
  '';
  services.xserver.displayManager.desktopManagerHandlesLidAndPower = false;

  # hardware.cpu.intel.updateMicrocode = true;
  # hardware.pulseaudio.enable = true;
  hardware.opengl.s3tcSupport = true;
  services.xserver.useGlamor = true;

  # services.printing.enable = true;

  # services.xserver.wacom.enable = true;
  services.xserver.synaptics = {
    enable = true;
    buttonsMap = [ 1 2 3 ];
    palmDetect = true;
    tapButtons = true;
    twoFingerScroll = true;
  };

  nix.maxJobs = 4;
}
