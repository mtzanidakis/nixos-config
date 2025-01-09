{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd = {
    enable = true;
  };

  security.pam.services.login.fprintAuth = false;
}
