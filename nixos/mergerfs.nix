{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mergerfs
  ];
}
