# `vim-full` is a gtk3 gvim build (`guiSupport ? "gtk3"`, `waylandSupport ? true`
# in nixpkgs' full.nix), so it drags gtk+3 and wayland into the closure -- 550MB,
# and on the headless hosts nothing else references them. Overriding those two
# flags works but loses the binary cache and rebuilds vim from source, so use the
# plain `vim` attribute instead: a separate top-level package, "huge version
# without GUI", substitutable, closure ncurses/bash/gawk.
#
# What it drops beyond the GUI: the python/lua/ruby interpreters (no plugin here
# needs one) and `+clipboard`, which requires X -- so no `"+y` from a terminal
# vim. The desktops run neovim as their editor anyway.
{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      (
        vim.customize {
          name = "vim";
          vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
            start = [
              catppuccin-vim
              nerdcommenter
              vim-airline
              vim-airline-themes
              vim-colors-solarized
              vim-sleuth
              vim-surround
              undotree
            ];
            opt = [];
          };
          vimrcConfig.customRC = ''
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

            set backupdir=~/.local/vim/backup
            set directory=~/.local/vim/swap
            set undodir=~/.local/vim/undo

            for _dir in ["backup", "swap", "undo"]
              let target_path = expand("~/.local/vim/" . _dir)
              if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
              endif
            endfor

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
            colorscheme catppuccin_macchiato

            nnoremap <F5> :UndotreeToggle<CR>
            if has("persistent_undo")
              set undofile
            endif
          '';
        }
      )
    ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };
}
