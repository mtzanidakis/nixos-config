{ config, pkgs, ... }:

{

  home.sessionVariables = {
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=60";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "docker-compose"
        "git"
        "golang"
        "kubectl"
        "nmap"
        "ripgrep"
        "sudo"
        "vi-mode"
      ];
    };

    initExtra = ''
      # run nix-index first to generate index
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      function kwide {
        kubectl $@ -o wide
      }

      function ktail {
        local _app=$1; shift
        kubectl logs --prefix -f -l app=''${_app} $@ | \
          grep -E -v 'health|metrics'
      }

      function weather {
        local _city=Cholargos
        [[ "$1" ]] && _city="$1"
        curl -s "https://wttr.in/''${_city}?format=3"
      }

      function rsb {
        local _rsb=$HOME/.rsbackup
        if [[ -z "$1" ]]; then
          echo "available options: $(cd ''${_rsb}; echo *)"
          return 2
        fi
        cd "''${_rsb}/$1"
      }

      echo -e "\n$(fortune -s)"
    '';

    shellAliases = {
      ls = "eza --header --git --icons --long";
      l = "ls";
      la = "ls -a";
      cp = "nocorrect cp -i";
      rm = "nocorrect rm -i";
      mv = "nocorrect mv -i";
      df = "df -h";
      dmesg = "dmesg -HT";
      dpss = "docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}'";
      du = "du -hsc";
      gti = "git";
      gdet = "git deltag";
      gret = "git retag";
      mkdir = "nocorrect mkdir";
      whatsmyip = "dig -4 +short myip.opendns.com @resolver1.opendns.com";
      whatsmyip-curl = "curl -4 -s https://ifconfig.co";
      kns = "kubens";
      kctx = "kubectx";
      kingtail = "kubectl logs -f -n default daemonsets.apps/nginx-ingress-nginx-controller";
      lwdc = "docker-compose -f docker-compose.yml -f docker-compose.override.yml";
      lwdctail = "lwdc logs --no-log-prefix --no-color -f";
    };
  };
}
