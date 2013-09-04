set guioptions=ce
set antialias
colorscheme slate
set linespace=2
set fenc=utf-8
set expandtab
set tabstop=4
syntax on
set laststatus=0
set nocursorline
set nonu
set foldmethod=indent

if has("gui_macvim")
  "set guifont=courier:h12
  "set guifont=monaco:h12
  set guifont=consolas:h13
elseif has("gui_gtk")
  set guifont=Monospace\ 14
else
  set guifont=Monaco:h17
end

if has("gui_macvim")
  set transparency=0

  " disable IM while leaving insert mode
  autocmd InsertEnter * set noimdisable
  autocmd InsertLeave * set imdisable

  " move a line of text using ALT+[jk] or Comamnd+[jk] on mac
  nmap <D-j> mz:m+<cr>`z
  nmap <D-k> mz:m-2<cr>`z
  vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

  " disable default menu hot key
  macmenu &File.New\ Window key=<nop>
  macmenu &File.Close key=<nop>

  " remap cmd + w to close tab
  map <D-w> :tabclose<CR>

  " remap cmd + n to new tab
  map <D-n> :tabnew<CR>

  " map cmd + enter to switch to full screen
  map <D-Enter> :set invfu<CR>

  " map cmd+1~9 to switch tab 1~9
  for i in range(1, 9)
    exec "nnoremap <D-".i."> ".i."gt"
  endfor

endif

" Vim width and height
set lines=40 columns=160

hi CursorLine guibg=#262626
"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
"autocmd VimEnter * wincmd q
let g:user_zen_expandabbr_key = '<c-e>'

noremap <Leader>l :ListMethods <CR>

" When switching to script-coding mode, this varaible will be used!
" Example: so $PittMakFile
let $tabs_2 = $HOME.'/.vim/2tabs.vim'
let $tabs_4 = $HOME.'/.vim/4tabs.vim'

" so $PittMakFile
"
let filename = expand('%')
let extensions = expand('%:e')
if extensions != 'h' && extensions != 'cc' && extensions != 'm' && extensions != 'mm' && extensions != 'c'
    so $tabs_2
else
  so $tabs_4
  " tab stop
  " added by Pitt Mak
  " cause set tabstop=4 in .vimrc had no effects, so i put it here
  ""autocmd VimEnter * set tabstop=4
  ""autocmd VimEnter * retab
endif

