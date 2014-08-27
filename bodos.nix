{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # essentials
    tmux htop wget ponysay psmisc gptfdisk

    # build essentials
    binutils gcc gnumake pkgconfig python

    # desktop components
    dmenu xlibs.xbacklight xscreensaver unclutter compton networkmanagerapplet
    feh xlibs.xrandr i3status liberation_ttf pavucontrol
    gnome3.gnome_themes_standard gnome3.gnome_icon_theme

    # desktop apps
    firefox-bin thunderbird-bin evince

    # all this just to build evilvte
    gnome.vte glib pango gnome.gtk cairo gdk_pixbuf atk freetype xlibs.libX11
    xlibs.xproto xlibs.kbproto xlibs.libXext xlibs.xextproto
  ];

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xterm.enable = false;
    startGnuPGAgent = true;
  };

  programs.ssh.startAgent = false;

  # Can this be any more fragile pls?
  environment.variables.GTK_DATA_PREFIX = "/nix/store/q8iaqz63ms1algsfr96hz6dnq4r9d7q5-gnome-themes-standard-3.12.0";

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Adwaita
    gtk-icon-theme-name=gnome
    gtk-font-name=Liberation Sans 13
    gtk-cursor-theme-name=Adwaita
    gtk-cursor-theme-size=0
    gtk-toolbar-style=GTK_TOOLBAR_BOTH
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=1
    gtk-menu-images=1
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintslight
    gtk-xft-rgba=rgb
  '';

  environment.etc."fonts/local.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>

      <match target="font">
        <edit name="antialias" mode="assign">
          <bool>true</bool>
        </edit>
      </match>
      <match target="font">
        <edit name="hinting" mode="assign">
          <bool>true</bool>
        </edit>
      </match>
       <match target="font">
        <edit name="hintstyle" mode="assign">
          <const>hintslight</const>
        </edit>
      </match>
      <match target="font">
        <edit name="rgba" mode="assign">
          <const>rgb</const>
        </edit>
      </match>
      <match target="font">
        <edit mode="assign" name="lcdfilter">
          <const>lcddefault</const>
        </edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Helvetica</string></test>
        <edit name="family" mode="assign"><string>Liberation Sans</string></edit>
      </match>

      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Liberation Sans</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>Liberation Serif</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Liberation Mono</family>
        </prefer>
      </alias>

    </fontconfig>
  '';
}
