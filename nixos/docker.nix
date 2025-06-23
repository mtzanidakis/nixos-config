{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    liveRestore = false;
  };

  users.users.manolis.extraGroups = ["docker"];

  environment = {
    systemPackages = with pkgs; [
      ctop
    ];
  };
}
