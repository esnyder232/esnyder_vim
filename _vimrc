vim9script

# --- file searching ---
set path+=**

# --- editing general ---
set number						# Sets line numbers
set tabstop=4					# Number of spaces = tab
set scrolloff=20				# Offset scrolling amount when moving cursor
#set list						# Reveals tabs in buffer (Replaced with ^I)
set ignorecase 					# Defaults search results with / to ignore case
set smartindent shiftwidth=4	# Helps indentation for vimscripts
set backspace=indent,eol,start	# Allow backspace to delete anything (and for some reason, required for backspace to work at all in MS)

# --- font/colors/syntax ---
syntax enable 
colorscheme industry			# Color scheme
set guifont=consolas:h14	
set hls							# Highlight color on

# --- command autocomplete ---
set wildmode=full				# Completion mode
set wildmenu					# Creates a horizontal menu with completion results (only usable with wildmode=full)
set wildoptions=pum				# Converts wildmenu into a vertical popup style for completion results (only usable with wildmode=full and wildmenu)
set wildignore=*.obj,log/		# Tells command autocomplete to ignore files/directories/anything with these patterns
set wildignorecase				# Case is ignored when completing file names and directories.

# --- other ---
#set mouse=a						# Enables mouse
set showcmd						# Shows commands in bottom right
set whichwrap=b,s 				# Allows backspace and space to wrap lines
set splitbelow					# New horizontal split windows appear BELOW the current window.
set splitright					# New vertical split windows appear to the RIGHT of the current window.
set makeprg=mingw32-make
set grepprg=grep\ -irn\ --include=*.c\ --include=*.h\ $*\ .

set undodir=~/undo-dir
set undofile


# --- remap leader ---
nnoremap <SPACE> <Nop>
g:mapleader = " "

# --- custom commands ---
# Grep: runs grep silently, and opens up the quickfix list
command! -nargs=+ Grep execute 'silent grep <args>' | botright copen | redraw!

# Make: runs make silently, and opens up the quickfix list
command! -nargs=* MakeCmd execute 'silent make <args>' | botright copen | redraw!

# Ctags: runs ctags silently
command! -nargs=+ Ctags execute 'silent !ctags <args>' | redraw!

# Quick fix: opens/closes the window
def g:Togglemyqf()
	var wins = filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
	if len(wins) == 1
		cclose
	else
		botright copen
	endif
enddef


# --- bindings ---
# Switches focus to the left window with ctrl + h
nnoremap <C-h> <c-w>h
# Switches focus to the right window with ctrl + l
nnoremap <C-l> <c-w>l
# Switches focus to the lower window with ctrl + j
nnoremap <C-j> <c-w>j
# Switches focus to the upper window with ctrl + k
nnoremap <C-k> <c-w>k

# Saves
nnoremap <C-s> :s<CR>

# F3 to toggle search highlighting
nnoremap <F2> :set hls!<CR>

# Quick fix: go to previous/next location
nnoremap <S-F3> :cprev<CR>
nnoremap <F3> :cnext<CR>

# Quick fix: Opens/closes the window
nnoremap <F4> :call Togglemyqf()<CR>

# Runs make/make clean and opens up quickfix list
nnoremap <F5> :MakeCmd<CR>
nnoremap <S-F5> :MakeCmd clean<bar>MakeCmd<CR>
nnoremap <F6> :MakeCmd test<CR>


# calls Grep to find strings globally only in certain filetypes. Puts command line cursor in betwen double quotes.
nnoremap <c-F> :Grep 

# Runs ctags
nnoremap <Leader>t :Ctags --kinds-c=+p -R .<CR>

#--- investigate ---
#sessionoptions
#mksession vimbook.vim
#source vimbook.vim
#vim -S vimbook.vim

#vertical split ~/		# opens up netrt file explorer plugin


