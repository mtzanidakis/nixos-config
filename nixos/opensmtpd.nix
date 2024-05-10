{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      mailutils
    ];

    etc.aliases = {
      text = ''
        root: manolis@netriin.net
        abuse: root
        noc: root
        security: root
        postmaster: root
        hostmaster: root
        webmaster: root
        www: webmaster
        ftp: root
      '';
      mode = "0644";
    };
  };

  services.opensmtpd = {
    enable = true;
    serverConfiguration = ''
      table aliases file:/etc/aliases

      listen on lo
      listen on docker0

      action "local" maildir alias <aliases>
      action "relay" relay

      match for local action "local"
      match from local for any action "relay"
      match from any for any action "relay"
    '';
  };
}
