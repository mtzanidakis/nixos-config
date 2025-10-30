{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      (
        (vim-full.override {}).customize {
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
