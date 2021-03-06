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
Bundle 'Shougo/vimproc.vim'
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
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/diffchar.vim'
Bundle 'szw/vim-tags'
Bundle 'tsukkee/unite-tag'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplete'
Bundle 'markcornick/vim-terraform'
"Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'Shougo/neomru.vim'
Bundle 'tmsanrinsha/yaml.vim'
Bundle 'mxw/vim-jsx'
Bundle 'tpope/vim-abolish'
Bundle 'pangloss/vim-javascript'
Bundle 'bigbrozer/vim-nagios'
Bundle 'nikvdp/ejs-syntax'
Bundle 'ryym/vim-riot'
Bundle 'nicklasos/vim-jsx-riot'
if v:version >= 800
  Bundle 'dense-analysis/ale'
endif
"Bundle 'fatih/vim-go'
Bundle 'prabirshrestha/async.vim'
Bundle 'prabirshrestha/asyncomplete.vim'
Bundle 'prabirshrestha/asyncomplete-lsp.vim'
Bundle 'prabirshrestha/vim-lsp'
Bundle 'mattn/vim-lsp-settings'
Bundle 'mattn/vim-goimports'
Bundle 'benmills/vimux'
Bundle 'sebdah/vim-delve'
Bundle 'mhinz/vim-startify'
Bundle 'posva/vim-vue'
Bundle 'obcat/vim-sclow'

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
au BufNewFile,BufRead fluent.conf set ft=fluentd
au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
let g:vim_markdown_folding_disabled=1

"set expandtab tabstop=2 shiftwidth=2 noautoindent nosmarttab wildmode=longest,list
set expandtab tabstop=2 shiftwidth=2 wildmode=longest,list
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c(0x%02B)%8P
set laststatus=2
if v:version >= 800
  "set breakindent
endif
set mouse=

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

let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitOutPathName=0

noremap [unite] <Nop>
nmap <Space>u [unite]

let g:unite_source_history_yank_enable = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_enable_start_insert = 1

nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file file/new<CR>
nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]n :<C-u>Unite file/new<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>
vnoremap /g y:Unite grep:::<C-R>=escape(@", '\\\?.*$^[]')<CR><CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

set statusline+=%#warningmsg#
if v:version >= 800
  "set statusline+=%{ALEGetStatusLine()}
  let g:ale_sign_error = '⨉'
  let g:ale_sign_warning = '⚠'
  let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_text_changed = 'always'
endif
set statusline+=%*

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
augroup END

autocmd FileType vue syntax sync fromstart

let g:startify_change_to_dir = 0

augroup XML
  autocmd!
  autocmd FileType xml setlocal foldmethod=indent " foldlevelstart=999 foldminlines=0
augroup END

highlight link SclowSbar PmenuSel

se belloff=all

"let g:go_debug = ['shell-commands']
"let g:go_def_mode = 'godef'

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
autocmd FileType go nmap <silent> <C-]> :LspDefinition<CR>
autocmd FileType go nmap <silent> <f2> :LspRename<CR>
autocmd FileType go nmap <silent> <Leader>d :LspTypeDefinition<CR>
autocmd FileType go nmap <silent> <Leader>r :LspReferences<CR>
autocmd FileType go nmap <silent> <Leader>i :LspImplementation<CR>
autocmd FileType go nmap <silent> ;b :DlvToggleBreakpoint<CR>
autocmd FileType go nmap <silent> ;d :DlvDebug
autocmd FileType go nmap <silent> ;t :DlvTest<CR>
autocmd FileType go let g:lsp_diagnostics_enabled = 1
autocmd FileType go let g:lsp_diagnostics_echo_cursor = 1
autocmd FileType go let g:delve_use_vimux = 1
let g:VimuxHeight = "40"


