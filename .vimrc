filetype plugin indent on

let mapleader=","

syntax enable " enable syntax highlighting

set backspace=indent,eol,start "make sure backspace works properly

set number relativenumber " show line numbers, relatively

set showcmd " shows current command in bottom right

" set cursorline " highlight current line

set wildmenu " visual autocomplete for command menu

set lazyredraw " only redraw when we need to for performance

set noshowmatch " no highlight matching [{()}]

set incsearch " search as characters are entered 

set nohlsearch " don't highlight search results

set visualbell " sets the bell to be 'visual' instead of making a sound (visual bell does nothing in windows bash)
set t_vb= " turn off flashing on screen clear

set laststatus=2 "sets the status line to be drawn always
set noshowmode "disables the default insert dialogue in favor of the status line status

set timeoutlen=1000 "sets timeouts for custom keymappings to be 1s/1000ms
set ttimeoutlen=0   "completely disables timeouts for key mappings (avoid the annoying delay for a second after leaving insert mode)

augroup run "run currently edited program with <leader> + r
	autocmd!
	autocmd FileType python nnoremap <buffer> <leader>r :w<CR>:!clear;python %<CR>
	autocmd FileType c nnoremap <buffer> <leader>r :w<CR>:!clear;gcc % -std=c99 -Wall -lpthread -lm -O2 -o %:r_vimcompiled;./%:r_vimcompiled;rm %:r_vimcompiled<CR>
	autocmd FileType cpp nnoremap <buffer> <leader>r :w<CR>:!clear;g++ % -std=c++11 -Wall -lm -o %:r_vimcompiled;./%:r_vimcompiled;rm %:r_vimcompiled<CR>
	autocmd FileType lisp nnoremap <buffer> <leader>r :w<CR>:!clear;clisp -i %<CR>
	autocmd FileType javascript nnoremap <buffer> <leader>r :w<CR>:!clear;node %<CR>
	autocmd FileType asm nnoremap <buffer> <leader>r :w<CR>:!clear;nasm % -f elf64 -o %:r_vimcompiled.bin; ld %:r_vimcompiled.bin -o %:r_vimcompiled; ./%:r_vimcompiled; rm %:r_vimcompiled.bin %:r_vimcompiled<CR>
	autocmd FileType java nnoremap <buffer> <leader>r :w<CR>:!clear;javac %; java %:r<CR>
	autocmd FileType sh nnoremap <buffer> <leader>r :w<CR>:!clear;bash %<CR>
	autocmd FileType rust nnoremap <buffer> <leader>r :w<CR>:!clear;cargo run<CR>

augroup END

augroup numbertoggle  "Toggles relative line numbering. Relative line numbering should be on in normal mode when window has focus. Off otherwise.
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" maps Y to yank to end of line, instead of yank entire line
nnoremap Y y$

" when pasting text over other text, don't replace default buffer with pasted over text
xnoremap p pgvy

" use <leader> + w to write file (,w)
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" user <leader> + W to write file as root (,W)
nnoremap <leader>W :w !sudo tee % > /dev/null<CR>

if empty(glob('~/.vim/autoload/plug.vim')) " install vim-plug if it doesn't already exist
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | q | source ~/.vimrc "install plugins, setting color scheme to a bearable one first
endif


call plug#begin('~/.vim/plugged')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif

Plug 'itchyny/lightline.vim' "status bar

Plug 'tpope/vim-surround' "enables vim shortcuts for surrounding text

Plug 'mattn/emmet-vim' "shortcuts for developing in HTML

Plug 'nanotech/jellybeans.vim' "color scheme :)

Plug 'editorconfig/editorconfig-vim' "by-filetype configs

Plug 'easymotion/vim-easymotion'

" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --rust-completer --java-completer' }
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_confirm_extra_conf = 0

call plug#end()

"ycm goto
nnoremap <leader>gt :YcmCompleter GoTo<CR> 

"ycm get doc
nnoremap <leader>gd :YcmCompleter GetDoc<CR>

inoremap jk <esc>

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set background=dark "set background to dark
silent! colorscheme ron "set colorscheme to jellybeans, ignoring errors
let g:lightline = {'colorscheme': 'jellybeans'} "update lightline to use this color scheme
