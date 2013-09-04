" Objective-C
autocmd! BufNewFile,BufRead *.m set filetype=objc

" Objective-C++
autocmd! BufNewFile,BufRead *.mm set filetype=objc

"Added by Pitt Mak
autocmd! BufNewFile,BufRead *.h set filetype=objc

"ActionScript
autocmd! BufNewFile,BufRead *.as set filetype=actionscript
autocmd! BufNewFile,BufRead *.mxml set filetype=mxml

" SCSS
autocmd! BufNewFile,BufRead *.scss set filetype=scss.css

" eRuby
autocmd! BufNewFile,BufRead *.erb set filetype=eruby.html

" JSON
autocmd! BufNewFile,BufRead *.json set filetype=javascript

" GitIgnore
autocmd! BufNewFile,BufRead *.gitignore set filetype=gitignore

" ZSH
autocmd! BufNewFile,BufRead *.zsh-theme set filetype=zsh

" Nginx Config
autocmd! BufNewFile,BufRead nginx.conf set filetype=nginx

" Erb
autocmd! FileType eruby setl indentexpr=XmlIndentGet(v:lnum,1)

" Javascript
autocmd! BufNewFile,BufRead *.js set filetype=javascript

autocmd FileType python call Tabs4()

autocmd FileType ruby call Tabs2()

autocmd FileType html call Tabs2()

" For markdown, i prefer to set cols and rows with a limited number
autocmd! BufNewFile,BufRead *.md call LimitedWindow()

function LimitedWindow()
  set lines=40 columns=85
endfunction

function Tabs2()
  set tabstop=2
  set expandtab
  set softtabstop=2
  set shiftwidth=2
  retab
endfunction

function Tabs4()
  set tabstop=4
  set expandtab
  set softtabstop=4
  set shiftwidth=4
  retab
endfunction

