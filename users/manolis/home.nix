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
    bat
    bitwarden
    fortune
    htop
    ncdu
    neofetch
    nmap
    pwgen
    ripgrep

    jetbrains-mono
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
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g status-style fg=yellow,bg=black
      set-window-option -g window-status-style fg=brightblue,bg=default
      set-window-option -g window-status-current-style fg=brightred,bg=default
      set-option -g pane-border-style fg=black
      set-option -g pane-active-border-style fg=brightgreen
      set-option -g message-style fg=brightred,bg=black
      set-option -g display-panes-active-colour blue
      set-option -g display-panes-colour brightred
      set-window-option -g clock-mode-colour green
      set-window-option -g window-status-bell-style fg=black,bg=red
    '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    initExtra = ''
      set -o vi
      echo -e "\n$(fortune -s)\n"
    '';
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.alacritty = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    coc.enable = true;
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      fzf-vim
      nerdcommenter
      vim-airline
      vim-airline-themes
      vim-sleuth
      vim-solarized8
      vim-surround
      {
         plugin = undotree;
         config = ''
           nnoremap <F5> :UndotreeToggle<CR>
           if has("persistent_undo")
             let target_path = expand('~/.local/nvim-undo')
             if !isdirectory(target_path)
               call mkdir(target_path, "p", 0700)
             endif
             let &undodir=target_path
             set undofile
           endif
         '';
      }
    ];
    extraConfig = ''
      filetype off
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set wildmode=list:longest
      set visualbell
      set backspace=indent,eol,start
      set laststatus=2
      set number
      set history=1000
      set title
      set ignorecase
      set smartcase
      set gdefault
      set incsearch
      set showmatch
      set hlsearch

      let mapleader = ","
      nmap <silent> <leader><space> :silent :nohlsearch<CR>

      set wrap
      set textwidth=0
      set list
      set listchars=tab:▸\ ,eol:¬
      set mousehide
      set mouse=a
      set cursorline
      set cursorcolumn

      au VimResized * exe "normal! \<c-w>="

      augroup vimrc_autocmd
        autocmd!

        " jump to the last position when reopening a file
        autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
      augroup END

      syn on
      set background=dark
      colorscheme solarized8_flat
      set termguicolors
    '';
  };
}
