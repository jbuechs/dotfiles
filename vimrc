" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'vim-scripts/textobj-user'
Plugin 'tpope/vim-bundler.git'
Plugin 'tpope/vim-rake.git'
Plugin 'tpope/vim-unimpaired'
Plugin 'airblade/vim-gitgutter'
Plugin 'roman/golden-ratio'
Plugin 'slim-template/vim-slim.git'
Plugin 'thoughtbot/vim-rspec'
Plugin 'mattn/emmet-vim'
Plugin 'marijnh/tern_for_vim'
"Plugin 'valloric/youcompleteme'
Plugin 'raimondi/delimitmate'
Plugin 'pangloss/vim-javascript'
Plugin 'helino/vim-json'
Plugin 'scrooloose/syntastic'
Plugin 'jshint/jshint'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rking/ag.vim'

call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on
" Put your non-Plugin stuff after this line

" Pull in contents of the .vim/rspec configuration file
source ~/.vim/rspec

" 0 at beginning of line
nmap 0 ^

" Map Ctrl-s to write the file
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>

" Map jk and kj to escape
imap jk <esc>
imap kj <esc>

" Scrolling through wrapped lines
nmap k gk
nmap j gj

" User enter to add new line before or after current line
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Fixing common typos
command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e
command! W w
command! Wq wq

" Leader
let mapleader = "\<Space>"

" remap ack
nnoremap <Leader>A :!ag
nnoremap <Leader>a :Ag!

" clear the highlighting of previous search pattern matches
nmap <leader>h :nohlsearch<CR>
" indent whole file
map <Leader>i mmgg=G`m<CR>
" paste code with correct indentation
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Vim-rspec key mappings
" run the most recently run spec
nnoremap <Leader>l :call RunLastSpec()<CR>
" run the nearest spec
nnoremap <Leader>s :call RunNearestSpec()<CR>
" Run current spec file
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>

" Pre-populate a split command with the current directory
nmap <leader>v :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Quickly open/reload vim
nnoremap <leader>ev :split $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>

" Open filename under cursor in new tab
nnoremap <leader>gf <C-W>gf
vnoremap <leader>gf <C-W>gf

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set hlsearch      " Highlight all matches after entering a search pattern
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set ignorecase    " Case insensitive pattern matching
set smartcase     " Overrides ignorecase if pattern includes upcase
set smartindent
set autoindent

" [buffer number] followed by filename:
set statusline=[%n]\ %t
" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" show line#:column# on the right hand side
set statusline+=%=%l:%c

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces


set textwidth=0
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Save with control S
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
      \ {"regex": "possibly useless use of a variable in void context"}

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

runtime macros/matchit.vim

" Configure textobj-rubyblock
set nocompatible
if has("autocmd")
  filetype indent plugin on
endif


" Absolute and relative line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
