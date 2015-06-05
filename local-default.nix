{ config, pkgs, ... }:

{
  # boot.loader.gummiboot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/disk/by-id/usb-Generic_Power_Saving_USB_000000000260-0:0";
  };

  boot.kernelPackages = pkgs.linuxPackages_testing;

  boot.initrd.availableKernelModules = [ "xhci_hcd" "ahci" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # nixpkgs.config.packageOverrides = pkgs: {
  #   linux_testing = pkgs.linux_testing.override {
  #     extraConfig = ''
  #       X86_MSR y
  #     '';
  #   };
  # };

  fileSystems."/" =
    { label = "Root";
      fsType = "ext4";
      # options = "compress=lzo,discard";
    };

  fileSystems."/boot" =
    { label = "Boot";
      fsType = "ext4";
    };

  swapDevices = [];

  networking.hostName = "misandry";
  time.timeZone = "Europe/London";
}
