" My currently working version Vimrc
" I kept all other settings in plugins/settings directory
"
" Eddie Kao
" http://blog.eddie.com.tw
" eddie@digik.com.tw

runtime bundle/vim-pathogen/autoload/pathogen.vim
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
call pathogen#infect()
call pathogen#helptags()

" hit enter to cancel searched highlight
"noremap <CR> :nohlsearch<CR>

" select ALL
map <C-A> ggVG

" indent selection repeatly
vnoremap < <gv
vnoremap > >gv

let g:clang_use_library=0
""let g:clang_library_path="/Users/Pitt/eddie-vim/bundle/clang_complete/plugin/clang"

"let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"

let g:clang_user_options='|| exit 0'
let g:clang_complete_auto = 0
let g:clang_complete_copen =0
let g:clang_auto_select = 2
let g:clang_trailing_placeholder = 1
let g:clang_hl_errors = 0 "should be 0
let g:clang_conceal_snippets = 1
let g:clang_close_preview = 0
let NERDTreeShowHidden = 1

set tags=/Users/Pitt/Apps/ericjohnson-canabalt-ios-ef43b7d/tags
let tlist_objc_settings = 'objc;i:interface;c:class;m:method;p:property'

map <C-G> :call g:OCSCOPE_ListTags()<CR>
let g:ocTagFile="/Users/Pitt/Apps/ericjohnson-canabalt-ios-ef43b7d/ocTags"
let g:callTagFile="/Users/Pitt/Apps/ericjohnson-canabalt-ios-ef43b7d/callTags"
"let g:ocTagFile="/Users/Pitt/Desktop/Super-Weak-Boy/ocTags"
