{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "manolis";
  home.homeDirectory = "/home/manolis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alacritty
    bitwarden
    fortune
    htop
    ncdu
    neofetch
    nmap
    pwgen
    ripgrep

    jellyfin-media-player
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/manolis/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Manolis Tzanidakis";
    userEmail = "mtzanidakis@gmail.com";
    aliases = {
      retag = "!f() { git tag -f -a \"$1\" -m \"$1\" && git push origin \"$1\" -f; }; f";
      deltag = "!f() { git tag -d \"$1\" && git push --delete origin \"$1\"; }; f";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      diff = {
        colorMoved = "zebra";
        tool = "nvim -d";
      };
      fetch = {
        prune = true;
      };
      log = {
        date = "iso8601";
      };
      merge = {
        tool = "nvimdiff";
      };
      pull = {
        rebase = false;
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    historyLimit = 5000;
    mouse = true;
    terminal = "screen-256color";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    initExtra = "set -o vi\necho -e \"\n$(fortune -s)\n\"";
    oh-my-zsh = {
      enable = true;
      theme = "fox";
      plugins = [
        "docker"
        "docker-compose"
        "git"
        "golang"
        "ripgrep"
        "sudo"
      ];
    };
    shellAliases = {
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

  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --no-ignore-vcs --hidden";
  };

  programs.keychain = {
    enable = true;
    agents = [
      "ssh"
    ];
    keys = [
      "github_ed25519"
      "id_ed25519"
      "id_rsa"
    ];
    extraFlags = [
      "--quiet"
      "--timeout 120"
    ];
  };
}
