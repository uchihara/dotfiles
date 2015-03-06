syntax on
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'vim-ruby/vim-ruby'
"Bundle 'vim-scripts/ruby-matchit'
Bundle 'tpope/vim-endwise'
Bundle 'Shougo/unite.vim'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-cucumber'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'slim-template/vim-slim.git'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'elzr/vim-json'
Bundle 'plasticboy/vim-markdown'
Bundle 'tomtom/tcomment_vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'desert256.vim'
Bundle 'yoppi/fluentd.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/diffchar.vim'
Bundle 'szw/vim-tags'
Bundle 'markcornick/vim-terraform'

"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'

" ...

filetype plugin indent on     " required!
"filetype plugin on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.jbuilder set ft=ruby
let g:vim_markdown_folding_disabled=1

"set expandtab tabstop=2 shiftwidth=2 noautoindent nosmarttab wildmode=longest,list
set expandtab tabstop=2 shiftwidth=2 wildmode=longest,list

autocmd QuickFixCmdPost *grep* cwindow
colorscheme default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
set background=light
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=254
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=253

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif
""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1
let g:vim_tags_auto_generate = 1

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

nnoremap <Leader>q" ciw""<Esc>Pb
nnoremap <Leader>q' ciw''<Esc>Pb
nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>Pb

nnoremap <C-]> g<C-]>
