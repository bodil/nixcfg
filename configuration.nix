{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./bodos.nix
      ./local.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "1048576";
  };

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
    emacs zsh joe git nodejs-unstable ponysay bittorrentSync evilvte mu powertop
    file inetutils lftp offlineimap unzip xlibs.xev duply rsync
  ];

  environment.shells = [ "/run/current-system/sw/bin/zsh" ];
  environment.variables.EDITOR = pkgs.lib.mkForce "joe";

  networking.extraHosts = "127.0.0.1 news.ycombinator.com www.reddit.com";
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

  nixpkgs.config.evilvte.config = ''
    #define BACKGROUND_SATURATION 0.15
    #define BACKGROUND_OPACITY TRUE
    #define COLOR_STYLE ZENBURN_DARK
    #define COMMAND_AT_ROOT_WINDOW TRUE
    #define COMMAND_DOCK_MODE TRUE
    #define COMMAND_EXEC_PROGRAM TRUE
    #define COMMAND_FULLSCREEN TRUE
    #define COMMAND_FONT TRUE
    #define COMMAND_GEOMETRY TRUE
    #define COMMAND_LOGIN_SHELL TRUE
    #define COMMAND_SET_TITLE TRUE
    #define COMMAND_SHOW_HELP TRUE
    #define COMMAND_SHOW_OPTIONS TRUE
    #define COMMAND_SHOW_VERSION TRUE
    #define COMMAND_TAB_NUMBERS TRUE
    #define FONT "Pragmata Pro 15"
    #define FONT_ANTI_ALIAS TRUE
    #define FONT_ENABLE_BOLD_TEXT TRUE
    #define MOUSE_CTRL_SATURATION TRUE
    #define SCROLL_LINES 100000
    #define SCROLLBAR OFF_R
    #define SHOW_WINDOW_BORDER FALSE
    #define SHOW_WINDOW_DECORATED TRUE
    #define SHOW_WINDOW_ICON TRUE
    #define WORD_CHARS "-A-Za-z0-9_$.+!*(),;:@&=?/~#%"
    #define TAB TRUE
    #define TAB_NEW_PATH_EQUAL_OLD TRUE
    #define TAB_SHOW_INFO_AT_TITLE TRUE
    #define TABBAR FALSE
    #define HOTKEY TRUE
    #define HOTKEY_COPY ALT(GDK_C) || ALT(GDK_c)
    #define HOTKEY_PASTE ALT(GDK_V) || ALT(GDK_v)
    #define HOTKEY_FONT_BIGGER ALT(GDK_plus)
    #define HOTKEY_FONT_SMALLER ALT(GDK_minus)
    #define HOTKEY_FONT_DEFAULT_SIZE ALT(GDK_0)
    #define HOTKEY_TAB_ADD CTRL_SHIFT(GDK_T) || CTRL_SHIFT(GDK_t)
    #define HOTKEY_TAB_REMOVE CTRL_SHIFT(GDK_W) || CTRL_SHIFT(GDK_w)
    #define HOTKEY_TAB_PREVIOUS CTRL_ALT(GDK_Page_Up)
    #define HOTKEY_TAB_NEXT CTRL_ALT(GDK_Page_Down)
  '';
}
