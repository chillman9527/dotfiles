" My .vimrc based on Fisa-vim-config

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Better file browser
Plug 'scrooloose/nerdtree'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Class/module browser
Plug 'majutsushi/tagbar'
" Zen coding
Plug 'mattn/emmet-vim'
" Tab list panel
Plug 'kien/tabman.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'somini/vim-autoclose'
" Git integration
Plug 'tpope/vim-fugitive'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" The ultimate solution for snippets
Plug 'SirVer/ultisnips'
" default snippets
Plug 'honza/vim-snippets'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Window chooser
Plug 't9md/vim-choosewin'
" Python autocompletion, go to definition.
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Python and other languages code checker
Plug 'scrooloose/syntastic'
" Format code with one button press
Plug 'chiel92/vim-autoformat'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
Plug 'vim-scripts/matchit.zip'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set nu

" file encoding setting
set fileencodings=utf8,big5,gbk,latin1

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" save as sudo
ca w!! w !sudo tee "%"

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
    colorscheme fisa
else
    colorscheme delek
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3
" No wrap
set nowrap

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Quickly Compile & Run

map <F5> :call CompileRun()<CR>

func! CompileRun()
    exec "w"
    if (&filetype == 'c')
        exec '!gcc % -o %< && time ./%<'
    elseif (&filetype == 'cpp')
        exec '!g++ % -o %< && time ./%<'
    elseif (&filetype == 'python')
        exec '!time python %'
    elseif (&filetype == 'sh')
        exec '!time bash %'
    endif
endfunc

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don't show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" TabMan ------------------------------

" mappings to toggle display, and to focus on it
map <F2> :TMToggle<CR>
let g:tabman_focus  = 'tf'

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
l
" Ultismips ------------------------------

let g:UltiSnipsExpandTrigger="<tab>"et g:airline#extensions#whitespace#enabled = 0

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Jedi-vim ------------------------------

" Completion trigger
let g:jedi#completions_command = '<c-n>'

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'

" Auto-format ------------------------------

au BufWrite * :Autoformat
let g:formatdef_yuyu = '"astyle --style=attach --pad-oper"'
let g:formatters_cpp = ['yuyu']
let g:formatters_c = ['yuyu']
let g:formatter_yapf_style = 'pep8'

" Yank Ring ------------------------------

nmap <silent> <F10> :YRShow<CR>
