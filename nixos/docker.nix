{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    liveRestore = false;
    package = pkgs.docker.override {
      buildGoModule = pkgs.buildGo123Module;
    };
  };

  users.users.manolis.extraGroups = ["docker"];

  environment = {
    systemPackages = with pkgs; [
      ctop
    ];
  };
}
