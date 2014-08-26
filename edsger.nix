{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_3_15;

  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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

  networking.hostName = "edsger";
  time.timeZone = "Europe/London";

  systemd.extraConfig = "";

  hardware.cpu.intel.updateMicrocode = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.s3tcSupport = true;
  services.xserver.useGlamor = true;

  services.printing.enable = true;

  services.xserver.wacom.enable = true;
  services.xserver.synaptics = {
    enable = true;
    buttonsMap = [ 1 3 2 ];
    palmDetect = true;
    tapButtons = true;
    twoFingerScroll = true;
  };

  nix.maxJobs = 4;
}
