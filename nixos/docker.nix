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

  # Unmanaged isn't enough for Chrome: it watches netlink itself, and the IPv6
  # link-local address the kernel gives every host-side veth on link up counts
  # as an IP change, so each container start/stop fails in-flight requests with
  # ERR_NETWORK_CHANGED. The bridge port only switches frames, so it needs no
  # IPv6 of its own; containers keep theirs. DAD holds the address back ~1s,
  # which leaves udev time to drop it before it is ever announced.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="veth*", RUN+="${pkgs.procps}/bin/sysctl -q -w net.ipv6.conf.%k.disable_ipv6=1"
  '';

  environment = {
    systemPackages = with pkgs; [
      ctop
    ];
  };
}
