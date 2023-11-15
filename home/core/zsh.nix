{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    initExtra = ''
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

      set -o vi
      echo -e "\n$(fortune -s)"
    '';
    shellAliases = {
      ls = "eza --header --git --icons --long";
      cp = "nocorrect cp -i";
      rm = "nocorrect rm -i";
      mv = "nocorrect mv -i";
      df = "df -h";
      dmesg = "dmesg -HT";
      du = "du -hsc";
      gti = "git";
      mkdir = "nocorrect mkdir";
      whatsmyip = "dig -4 +short myip.opendns.com @resolver1.opendns.com";
      whatsmyip2 = "curl -4 -s https://ifconfig.co";
      k = "kubectl";
      kgp = "kubectl get pods";
      kgi = "kubectl get ingress";
      kdp = "kubectl describe pod";
      kdi = "kubectl describe ingress";
      kns = "kubens";
      kctx = "kubectx";
      kingtail = "kubectl logs -f -n default daemonsets.apps/nginx-ingress-nginx-controller";
      lwdc = "docker-compose -f docker-compose.yml -f docker-compose.override.yml";
      lwdctail = "lwdc logs --no-log-prefix --no-color -f";
    };
  };
}
