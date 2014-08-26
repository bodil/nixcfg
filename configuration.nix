{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./bodos.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernel.sysctl = {};

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_GB.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:nocaps,eurosign:e";
  };

  nix.useChroot = true;

  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true; # :((( this is because of btsync
  environment.systemPackages = with pkgs; [
    emacs zsh joe git nodejs ponysay bittorrentSync
  ];

  environment.shells = [ "/run/current-system/sw/bin/zsh" ];
  environment.variables.EDITOR = pkgs.lib.mkForce "joe";

  networking.extraHosts = "127.0.0.1 news.ycombinator.com";
  networking.interfaceMonitor = { enable = true; beep = true; };
  networking.tcpcrypt.enable = true;

  # users.mutableUsers = false;
  users.extraUsers.bodil = {
    name = "bodil";
    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" ];
    uid = 1000;
    createHome = true;
    home = "/home/bodil";
    shell = "/run/current-system/sw/bin/zsh";
  };

}
