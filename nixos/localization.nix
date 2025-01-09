{
  # locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "el_GR.UTF-8";
      LC_MONETARY = "el_GR.UTF-8";
      LC_ADDRESS = "el_GR.UTF-8";
      LC_TELEPHONE = "el_GR.UTF-8";
      LC_MEASUREMENT = "el_GR.UTF-8";
    };
  };

  # console font and keyboard layout
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # X11 keyboard layout
  services.xserver.xkb = {
    layout = "us,gr";
    options = "grp:alt_shift_toggle,ctrl:nocaps,grp_led:caps,terminate:ctrl_alt_bksp";
  };
}
