{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      ((vim_configurable.override {  }).customize{
        name = "vim";
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [
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
          colorscheme solarized

          nnoremap <F5> :UndotreeToggle<CR>
          if has("persistent_undo")
            let target_path = expand('~/.local/vim-undo')
            if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
            endif
            let &undodir=target_path
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
