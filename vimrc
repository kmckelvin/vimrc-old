set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'rking/ag.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-bundler'
Bundle 'Raimondi/delimitMate'
Bundle 'adamlowe/vim-slurper'
Bundle 'kien/ctrlp.vim'
Bundle 'slim-template/vim-slim'
Bundle 'ervandew/supertab'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ddollar/nerdcommenter'
Bundle 'tpope/vim-endwise'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'jwhitley/vim-matchit'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'thoughtbot/vim-rspec'
Bundle 'jgdavey/tslime.vim'
Bundle 'csexton/trailertrash.vim'
Bundle 'textobj-user'
Bundle 'textobj-rubyblock'
Bundle 'jnwhiteh/vim-golang'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'heartsentwined/vim-emblem'
" Bundle 'dsawardekar/portkey'
" Bundle 'dsawardekar/ember.vim'

" autoindent with two spaces, always expand tabs
autocmd BufNewFile,BufReadPost * set ai ts=2 sw=2 sts=2 et

" check for external file changes
autocmd CursorHold,CursorMoved,BufEnter * checktime

autocmd BufRead,BufNewFile *.embl set syntax=emblem

syntax on
let g:Powerline_symbols = 'fancy'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let g:nerdtree_tabs_open_on_console_startup = 1
let g:ctrlp_max_height = 25

" always use the vim pwd as the root for CtrlP
let g:ctrlp_working_path_mode = ''
let g:syntastic_check_on_open=0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_html_checkers=['']
" let g:rspec_command = 'call SendToTmux(" (test -e .zeus.sock && zeus test {spec}) || (test -e .env && test ! -e .zeus.sock && nocorrect foreman run bundle exec rspec {spec}) || (test ! -e .zeus.sock && test ! -e .env && nocorrect bundle exec rspec {spec})\n")'
let g:rspec_command = 'call SendToTmux(" rspec {spec}\n")'
let NERDTreeShowHidden=1

filetype plugin indent on

set t_Co=256
colorscheme grb256
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0

set splitright
set splitbelow

if has('mouse_sgr')
  set ttymouse=sgr
endif

if $TMUX != ""
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" line highlighting
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=233

set incsearch
set hlsearch
noh " clear the initial highlight after sourcing
set ignorecase smartcase
set number
set relativenumber
set scrolloff=5
set mouse=a
set laststatus=2 " always show the status bar
set nocompatible
set noswapfile
set nobackup
set nowritebackup
set nowrap
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" set clipboard=unnamed

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

set showmatch

set wildmenu
set wildmode=longest,list

let mapleader=" "
inoremap <c-s> <esc>:w<CR>
map <c-s> <c-c>:w<CR>
cmap w!! %!sudo tee > /dev/null %
map Q :<CR>

" navigate panes with <c-hhkl>
" nmap <silent> <c-k> :wincmd k<CR>
" nmap <silent> <c-j> :wincmd j<CR>
" nmap <silent> <c-h> :wincmd h<CR>
" nmap <silent> <c-l> :wincmd l<CR>

map <leader><leader> <C-^>

map <leader>. :noh<CR>
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>ff :NERDTreeFind<CR>

" xmpfilter
map <F10> <Plug>(xmpfilter-run)
map <F9> <Plug>(xmpfilter-mark)

" paste, fix indentation and clear the mark by default
nnoremap p p=`]`<esc>

if $TMUX != ""
  " nmap <leader>ggf :call SendToTmux("ggf && ggmc\n")<CR>
  nmap <leader>gp :call SendToTmux("gpoc\n")<CR>
  map <leader>bi :call SendToTmux("bundle\n")<CR>
  map <leader>rz :!tmux send-keys -tzeus C-c zeus space start enter<CR><CR>
  nmap <leader>tc :!tmux send-keys -tvim.1 C-c<CR><CR>:echo "Sent C-c to tmux"<CR>
  nmap <leader>dbm :call SendToTmux("zeus rake db:migrate\n")<CR>
  nmap <leader>dbr :call SendToTmux("zeus rake db:rollback\n")<CR>
  nmap <leader>dbn :call SendToTmux("zeus rake db:rollback && zeus rake db:migrate\n")<CR>
  nmap <leader>dbt :call SendToTmux("zeus rake db:test:prepare\n")<CR>
else
  map <leader>bi :!bundle<CR>
  nmap <leader>gp :exec ':Git push origin ' . fugitive#head()<CR>
  map <leader>dbm :!zeus rake db:migrate<CR>
  map <leader>dbr :!zeus rake db:rollback<CR>
  nmap <leader>dbt :!zeus rake db:test:prepare<CR>
endif

map <leader>bu :!bundle update<space>

nmap <leader>bx :!bundle exec<space>
nmap <leader>zx :!zeus<space>
map <leader>vbi :BundleInstall<CR>
map <leader>vbu :BundleUpdate<CR>


map <leader>vi :tabe ~/.vimrc<CR>
map <leader>vt :tabe ~/.tmux.conf<CR>
map <leader>td :tabe ~/Dropbox/todo.txt<CR>
map <leader>tb :tabe ~/Dropbox/blog.txt<CR>
map <leader>vs :source ~/.vimrc<CR>

map <silent> <leader>gs :Gstatus<CR>/not staged<CR>/modified<CR>
map <leader>gc :Gcommit<CR>
map <leader>gpr :call SendToTmux("gpr\n")<CR><CR>

map <leader>gr :edit config/routes.rb<CR>
map <leader>gg :edit Gemfile<CR>

map <leader>gj :CtrlP app/assets/javascripts/<CR>
map <leader>ga :CtrlP app<CR>
map <leader>gt :CtrlP spec<CR>

map <leader>tp :tabp<CR>
map <leader>tn :tabn<CR>

map <leader>= <C-w>=

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" tab for equals
map <leader>te :Tab/^[^=]*\zs/l0l1<CR>
" tab for hash/json syntax
map <leader>th :Tab/^[^:]*\zs/l0l1<CR>

map <leader>rm <Plug>SetTmuxVars
map <leader>ta :w<CR>:call RunAllSpecs()<CR>
map <leader>tt :w<CR>:call RunCurrentSpecFile()<CR>
map <leader>tl :w<CR>:call RunNearestSpec()<CR>
map <leader>tc :!open coverage/index.html<CR><CR>:echo "Opening Test Coverage report"<CR>
map <leader>rrt :call RunCurrentTestNoZeus()<CR>
map <leader>rrl :call RunCurrentLineInTestNoZeus()<CR>
map <leader>rj :!~/Code/chrome-reload<CR><CR>

map <leader>sm :RSmodel<space>
map <leader>vc :RVcontroller<CR>
map <leader>vm :RVmodel<space>
map <leader>vv :RVview<CR>
map <leader>zv :Rview<CR>
map <leader>zc :Rcontroller<CR>
map <leader>zm :Rmodel<space>

" pane management
map <leader>mh :wincmd H<CR>
map <leader>mj :wincmd J<CR>
map <leader>mk :wincmd K<CR>
map <leader>ml :wincmd L<CR>

" flip left and right panes
map <leader>mm :NERDTreeTabsClose<CR>:wincmd l<CR>:wincmd H<CR>:NERDTreeTabsOpen<CR>:wincmd l<CR><C-W>=

" restart pow
map <leader>rp :!touch tmp/restart.txt<CR><CR>:echo "Restarted server"<CR>

" select the current method in ruby (or it block in rspec)
map <leader>sm /end<CR>?\<def\>\\|\<it\><CR>:noh<CR>V%
map <leader>sf :CtrlP spec/factories/<CR>

" j and k navigate through wrapped lines
nmap k gk
nmap j gj

command! Q q " Bind :Q to :q
command! Qall qall

command! W w
command! Wa wall
command! Wq wq

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Source: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

if has("autocmd")
  " Also load indent files, to automatically do language-dependent indenting.

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Never wrap slim files
  autocmd FileType slim setlocal textwidth=0

  autocmd BufWritePre * :%s/\s\+$//e

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")
