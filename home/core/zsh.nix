{pkgs, ...}: {
  home.sessionVariables = {
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=60";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
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
        "vi-mode"
      ];
    };

    initContent = ''
      # run getnixindexdb first
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      function getnixindexdb {
        local _index="index-$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | tr A-Z a-z)"
        local _cache=~/.cache/nix-index
        local _file=''${_cache}/files
        test -d ''${_cache} || mkdir -p ''${_cache}
        curl -s -L -R -o ''${_file} -z ''${_file} \
          "https://github.com/Mic92/nix-index-database/releases/latest/download/''${_index}"
      }

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
      dmesg = "sudo dmesg -HTP";
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
      lwdc = "docker-compose -f docker-compose.yml -f extra/adminer.yml -f extra/website.yml -f extra/marketplace.yml -f extra/cameraman.yml -f extra/pubsub-emulator.yml -f extra/cloner.yml -f extra/lwdemomaker.yml -f extra/iplocate.yml -f extra/mailpit.yml -f docker-compose.override.yml";
      lwdctail = "lwdc logs --no-log-prefix --no-color -f";
    };
  };
}
