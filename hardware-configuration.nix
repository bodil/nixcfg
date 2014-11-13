{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_3_17;

  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  nixpkgs.config.packageOverrides = pkgs: {
    linux_3_17 = pkgs.linux_3_17.override {
      extraConfig = ''
        X86_MSR y
      '';
    };
  };

  fileSystems."/" =
    { label = "Root";
      fsType = "btrfs";
      options = "compress=lzo,discard";
    };

  fileSystems."/boot" =
    { label = "EFI";
      fsType = "vfat";
    };

  swapDevices =[ { label = "Swap"; } ];

  systemd.extraConfig = "";
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    LidSwitchIgnoreInhibited=yes
  '';
  services.xserver.displayManager.desktopManagerHandlesLidAndPower = false;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.s3tcSupport = true;
  services.xserver.useGlamor = true;

  services.printing.enable = true;

  services.xserver.wacom.enable = true;
  services.xserver.synaptics = {
    enable = true;
    buttonsMap = [ 1 2 3 ];
    palmDetect = true;
    tapButtons = true;
    twoFingerScroll = true;
  };

  nix.maxJobs = 4;
}
