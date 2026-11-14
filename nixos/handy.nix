{pkgs, ...}: {
  # handy pastes through the clipboard and sends Shift+Insert with dotool -- see
  # pkgs/handy. Settings: Paste Method "Shift+Insert", Typing Tool "auto".
  environment.systemPackages = [
    (pkgs.callPackage ../pkgs/handy {})
  ];

  # dotool needs /dev/uinput. uaccess hands it to whoever owns the active seat,
  # without a uinput group that every process of the user would carry. The steam
  # and logitech rules already do the same, but only by accident; this keeps
  # handy working if either goes. The tag has to be set before 73-seat-late
  # applies it, so this is a 70- rule rather than services.udev.extraRules,
  # which lands in 99-local.
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "uinput-uaccess-udev-rules";
      destination = "/etc/udev/rules.d/70-uinput-uaccess.rules";
      text = ''
        KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
      '';
    })
  ];
}
