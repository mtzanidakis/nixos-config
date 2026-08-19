{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    liveRestore = false;
  };

  users.users.manolis.extraGroups = ["docker"];

  # Docker recreates a veth pair (and possibly a br-* bridge) on every container
  # start/stop. Keep the host's network stack away from those interfaces: the
  # stock dhcpcd deny list only knows Xen/libvirt names, so it kept tracking
  # docker veths and segfaulted in ipv6nd_expire when a container restart loop
  # tore them down under it, taking the network and tailscaled with it.
  networking = {
    dhcpcd.denyInterfaces = ["veth*" "docker*" "br-*"];

    networkmanager.unmanaged = [
      "interface-name:veth*"
      "interface-name:docker*"
      "interface-name:br-*"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      ctop
    ];
  };
}
