" vimrc - Configuration for vim.
"
" Author: Chris Barry <chris@barry.im>
"
" License: Public domain.

set encoding=utf-8
set autoindent
syntax on

if exists("+relativenumber")
	set relativenumber
	autocmd InsertEnter * :set number
	autocmd InsertLeave * :set relativenumber
else
	set number
endif

set background=dark
set t_Co=256

" Tab spacing
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab
set sw=4

" Auto-save if focus is lost
au FocusLost * silent! wa

" Java / C / C++ folding
"set foldmethod=marker
"set foldmarker={,}

" :w!! Runs sudo
cmap w!! %!sudo tee > /dev/null %

" Open markdown files with proper syntax higlighting
au BufRead,BufNewFile *.md set filetype=markdown

"Toggle Spell check
map <F4> :set spell!<cr>
map <F5> :make<cr>

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
 au!

 " First make sure nothing is written to ~/.viminfo while editing
 " an encrypted file.
 autocmd BufReadPre,FileReadPre *.gpg set viminfo=
 " We don't want a swap file, as it writes unencrypted data to disk
 autocmd BufReadPre,FileReadPre *.gpg set noswapfile

 " Switch to binary mode to read the encrypted file
 autocmd BufReadPre,FileReadPre *.gpg set bin
 autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
 " (If you use tcsh, you may need to alter this line.)
 autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

 " Switch to normal mode for editing
 autocmd BufReadPost,FileReadPost *.gpg set nobin
 autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
 autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

 " Convert all text to encrypted text before writing
 " (If you use tcsh, you may need to alter this line.)
 autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
 " Undo the encryption so we are back in the normal text, directly
 " after the file has been written.
 autocmd BufWritePost,FileWritePost *.gpg u
augroup END

