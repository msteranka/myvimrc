" -------------------------------------------------- 
" KEY POINTS ##
" -------------------------------------------------- 
" <F1> - Save
" <F2> - Save and quit
" Ctrl + d - Save, compile, and run program
" @c - Comment line in C
" @u - Uncomment line in C
" @p - Debug printf in C
" @i - Put #include in C

" -------------------------------------------------- 
" ENABLED OPTIONS ##
" -------------------------------------------------- 

" utf8 as standard encoding
set encoding=utf8

" Enable syntax coloring
syntax enable

" Set hybrid line numbers
set number relativenumber
set nu rnu

" Auto and smart indent
set autoindent
set smartindent

" Show matching brackets
set showmatch

" Use spaces instead of tabs
set expandtab
set smarttab

" Set tab to 4 spaces
set shiftwidth=4
set tabstop=4

" Show current position
set ruler

" Highlight search results
" set hlsearch

" Ignore case when searching
set ignorecase

" Be smart about case when searching
set smartcase

" Enable new pane to be opened on right
set splitright

" Disable annoying bell sounds
set noerrorbells
set novisualbell

" Set dark background
set background=dark

" Enable 256 coloring on gnome-terminal
if $COLORTERM == 'gnome-terminal'
		set t_Co=256
endif

" -------------------------------------------------- 
" MAPPINGS ##
" -------------------------------------------------- 

" Quick window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save and quit
nnoremap <F1> :w<Enter>
nnoremap <F2> :wqa<Enter>

" Map <Space> to / and <C-Space> to ?
map <Space> /
map <C-Space> ?

" Remap 0 to first non-blank character
nnoremap 0 ^
nnoremap ^ 0

" Press <Enter> to turn off highlighting
" nnoremap <CR> :nohlsearch<CR><CR>

" Save file with :W if requires root permission
command W w !sudo tee % > /dev/null

" Use :Man command to view man pages
" Can also use \K to view man page for word under cursor
runtime! ftplugin/man.vim

" -------------------------------------------------- 
" FILE SETTINGS ##
" --------------------------------------------------

" C file settings
autocmd FileType c call s:c_settings()
function! s:c_settings()
	" Save, compile, and run
	" nnoremap <C-d> :w<CR> :!clear && echo -e 'Compilation: \n' && make && make clean && echo -e '\nOutput: \n' && ./%< <CR>
    nnoremap <C-d> :w<CR> :!clear && gcc % && ./a.out<CR>
    " nnoremap <C-d> :w<CR> :!clear && gcc achievement.c crew.c main.c record.c ship.c stat.c && ./a.out<CR>

	" Autocomplete
	inoremap (<Tab> ()<Left>
	inoremap {<CR> {}<Left><CR><CR><Up><Tab>

    " Autogen creates the hello world program
    command! Autogen :r !cat ~/C/template.c

    " Start up NERDTree and move to editing window
    " autocmd VimEnter * NERDTree
    " autocmd VimEnter * wincmd p
    
    " Comment macro
    let @c="^i//\<Esc>j"

    " Uncomment macro
    let @u="^2xj"

    " Debug with puts()
    let @p="oputs(\"Hello, World!\");\<Esc>"

    " Remove all debug lines - WILL DELETE ALL PUTS()
    command! NoDebug :g/puts("Hello, World!");/d

    " Finish include
    let @i="i#include\<Space><\<Esc>A.h>\<Esc>j0"
endfunction

function s:asm_settings()
    nnoremap <C-d> :w<CR> :!clear && nasm -f elf64 % && ld %<.o && gcc %<.o && ./a.out<CR>
endfunction

" LaTeX file settings
autocmd FileType tex call s:tex_settings()
function s:tex_settings()
	nnoremap <C-d> :w<CR> :!pdflatex % <CR><CR>
endfunction

" HTML file settings
autocmd FileType html call s:html_settings()
function s:html_settings()
 	" Autocomplete
 	" inoremap p<Tab> <p></p><left><left><left><left>
 	" inoremap html<Tab> <html></html><left><left><left><left>
 	" inoremap h1<Tab> <h1></h1><left><left><left><left>
 	" inoremap body<Tab> <body></body><left><left><left><left>
 	" inoremap head<Tab> <head></head><left><left><left><left>

    " Start up NERDTree and move to editing window
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd p
    " autocmd VimEnter * hi Search guibg=LightBlue
    
    " Macro for finishing link tags
    let @a="i<a>\<Esc>A</a>\<Esc>\<CR>0"
endfunction

" .sh file settings
autocmd FileType sh call s:sh_settings()
function s:sh_settings()
    nnoremap <C-d> :w<CR> :!clear && ./% && cat ~/Scripts/hosts
endfunction

" nnoremap <C-d> :w<CR> :!clear && rustc % && ./%<<CR>
" autocmd FileType rs call s:rs_settings()
" function s:rs_settings()
" endfunction

" -------------------------------------------------- 
" PLUGINS ##
" -------------------------------------------------- 

" Enable pathogen
execute pathogen#infect()

" Enable filetype plugins
filetype plugin indent on
filetype indent on

" -------------------------------------------------- 
" TESTING ##
" -------------------------------------------------- 

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Hit tab to "find by partial match
" Use * to make it fuzzy
" :b lets you autocomplete any buffer

" Create the 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R

" Use ^] to jump to tag under cursor
" Use g^] for ambigious tags
" Use ^t to jump back up the tag stack
" This doesn't help if you want a visual list of tags

" execute "echo 'hello'"
" command! Smiley :echo "=)"
" function! Foo()
"     return "Hello there!"
" endfunction
