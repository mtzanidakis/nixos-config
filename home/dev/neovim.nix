{ config, pkgs, ... }:

{
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
      vim-go
      vim-sleuth
      vim-colors-solarized
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
      colorscheme solarized
    '';
  };
}
