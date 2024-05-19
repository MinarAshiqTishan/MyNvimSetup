" Vim with all enhancements
" source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
" source $VIMRUNTIME/mswin.vim




call plug#begin(stdpath('data').'/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'luochen1990/rainbow'
Plug 'gregsexton/MatchTag'
Plug 'mhinz/vim-startify'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
Plug 'terryma/vim-smooth-scroll'
Plug 'iamcco/markdown-preview.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'simrat39/rust-tools.nvim'
Plug 'stevearc/oil.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()


set number
set relativenumber

"Installed powerfonts from   https://github.com/powerline/fonts : Needed for Airline
set guifont=DejaVuSansM_Nerd_Font_Mono:h11
set termguicolors
set splitright
set splitbelow
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set ambiwidth=single
set encoding=utf-8
set incsearch ignorecase smartcase hlsearch
set title
"set acd


colorscheme catppuccin-mocha

let g:airline_theme = 'catppuccin'


let $BAT_THEME='base16' "so the sytax highlighting is visible

let $FZF_DEFAULT_OPTS = "--no-mouse --no-height --color=bg+:#6a6a6a,gutter:-1 --ansi "

let $FZF_DEFAULT_COMMAND = "fd --type f --color=always --exclude .git --ignore-file ~/.gitignore"


let g:fzf_layout = { 'down':'~40%' }

"" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }



let g:rainbow_active = 1

" custom bannerlocal harpoon = require("harpoon")
let g:startify_custom_header = [
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣶⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⣈⣿⣿⣿⠀⠀⣤⡶⠃⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⢸⣧⠀⠀⣀⠀⠀⣾⡿⢿⣿⣿⣶⣿⡟⠁⠀⠀⠀⡀⠀⣼⡟⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⢠⣿⡟⠀⣠⣿⠀⠀⣿⣧⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀⣷⡄⢻⣿⡄⠀⠀⠀ ',
 \'             	⢢⣤⣄⣿⣿⠁⢰⣿⠃⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⢹⣿⠀⢻⣿⣠⣤⡶ ',
 \'             	⠀⠘⣿⣿⣿⡆⢸⣿⠀⠀⠀⢀⣙⣿⣿⣧⣴⣿⣿⣿⡄⠀⠀⢸⣿⣷⣻⣿⣿⠃⠀ ',
 \'             	⠀⠀⠹⣿⣿⡇⠘⣿⣿⠆⠀⠈⢽⠝⡿⣿⣿⣿⣿⣓⠂⠀⢲⣿⡿⢹⣿⣿⡏⠀⠀ ',
 \'             	⠀⠀⢠⣬⣭⣷⡆⠙⣿⣦⣄⠀⠀⠙⠙⠛⣷⠙⠉⠀⢀⣤⣼⡟⢫⣾⣭⣥⡄⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⣰⣿⣿⣤⣨⠛⠛⣿⣿⣷⣼⣷⣾⣿⣿⠋⠋⢠⣼⣽⣷⣄⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⣸⣿⡿⠋⣿⣿⣷⣤⣤⣍⡀⣙⠋⠙⣡⣤⣤⣴⣿⣿⠿⢿⣿⡀⠀⠀⠀ ',
 \'             	⠀⠀⠀⢀⣿⠿⠁⠀⠀⠻⠿⢯⡻⣿⠛⣿⣿⣿⢹⣿⠹⠟⠛⠁⠀⠘⠻⢧⡀⠀⠀ ',
 \'             	⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⢹⣿⣿⠸⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 \'             	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ '
 \]






"fzf :files command
" ------------------
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(
			\ 	<q-args>, fzf#vim#with_preview(
			\		{'options': ['--preview', 'bat --decoration=always --color=always {} --style=numbers,grid' ]}),
			\ 	<bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options' : ['--delimiter', ':', '--preview' , 'bat --decoration=always --color=always {1} --highlight-line {2} --style=numbers'] }), <bang>0)


" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'line:'
let g:airline_symbols.colnr = ' col:'
let g:airline_symbols.maxlinenr = ' '


au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['linenr','colnr'])

let g:airline#extensions#fzf#enabled = 1


let g:grepper = {
    \ 'tools': ['rg', 'git'],
    \ }




" ======================== Commands ============================= "{{{

au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
au FileType help wincmd L                               " open help in vertical split
au BufWritePre * :%s/\s\+$//e                           " remove trailing whitespaces before saving


" enable spell only if file type is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'liquid', 'rst']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif


" startify if no passed argument or all buffers are closed
augroup noargs
    " startify when there is no open buffer left
    autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

    " open startify on start if no argument was passed
    autocmd VimEnter * if argc() == 0 | Startify | endif
augroup END

function! s:update_highlights()
    hi VertSplit ctermbg=none guibg=Black
endfunction

autocmd User AirlineAfterTheme call s:update_highlights()




"keymap
"----------

nnoremap <SPACE> <Nop>

let mapleader = " "

nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>bd :bd<CR>

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>

nmap <leader>v :vsplit<CR>
nmap <leader>s :split<CR>


"" FZF
" nnoremap <silent> <leader>f :Files<CR>
" nmap <leader>b :Buffers<CR>
" nmap <leader>c :Commands<CR>
" nmap <leader>t :BTags<CR>
" nmap <leader>/ :Rg<CR>
" nmap <leader>gc :Commits<CR>
" nmap <leader>gs :GFiles?<CR>
" nmap <leader>sh :History/<CR>

"open file under cursor right vertical window
nmap <leader>gf <C-W>vgf

nmap gd <C-W>d

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>rg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>tt <cmd>Telescope help_tags<cr>

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" switch between splits using ctrl + {h,j,k,l}
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
noremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
noremap <C-l> <C-w>l


noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2, 5, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2, 5, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll, 10, 2)<CR>


" markdown preview
au FileType markdown nmap <leader>m :MarkdownPreview<CR>



lua require('plugin_config')





