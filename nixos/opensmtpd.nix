{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      mailutils
    ];

    etc."smtpd/aliases" = {
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
      listen on 0.0.0.0
      table aliases file:/etc/smtpd/aliases
      action "local" maildir alias <aliases>
      action "relay" relay
      match for local action "local"
      match from local for any action "relay"
      match from any for any action "relay"
    '';
  };
}
