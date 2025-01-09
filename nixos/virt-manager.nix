{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.manolis.extraGroups = ["libvirtd"];
}
