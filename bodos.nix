{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # essentials
    tmux htop wget ponysay psmisc gptfdisk gnupg

    # build essentials
    binutils gcc gnumake pkgconfig python ruby

    # desktop components
    dmenu xlibs.xbacklight xscreensaver unclutter compton
    networkmanagerapplet volumeicon pavucontrol feh
    xlibs.xrandr liberation_ttf pavucontrol
    libnotify gnome3.gnome_themes_standard
    gnome3.adwaita-icon-theme gnome3.gsettings_desktop_schemas
    acpi dunst jq i3status i3lock i3blocks

    # desktop apps
    chromium firefox-bin evince
  ];

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.slim.enable = true;
    desktopManager.xterm.enable = false;
    startGnuPGAgent = true;
  };

  services.udisks2.enable = true;
  services.gnome3.at-spi2-core.enable = true;

  programs.ssh.startAgent = false;

  environment.variables.GTK_DATA_PREFIX = "${pkgs.gnome3.gnome_themes_standard}";

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Adwaita
    gtk-icon-theme-name=gnome
    gtk-font-name=Droid Sans 20
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
        <edit name="family" mode="assign"><string>Droid Sans</string></edit>
      </match>

      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Droid Sans</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>Droid Serif</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>PragmataPro</family>
        </prefer>
      </alias>

    </fontconfig>
  '';
}
