" ActionScript
autocmd BufRead,BufNewFile *.as map <F5> :silent !$FLEX_HOME/bin/mxmlc % \| iconv -f big5 -t utf-8<CR>:redraw!<CR>:echon "Done!"<CR>
autocmd BufRead,BufNewFile *.mxml map <F5> :silent !$FLEX_HOME/bin/mxmlc % \| iconv -f big5 -t utf-8<CR>:redraw!<CR>:echon "Done!"<CR>

" CoffeeScript
"autocmd BufRead,BufNewFile *.coffee map <F5> :silent CoffeeMake!<CR>:redraw!<CR>
autocmd BufRead,BufNewFile *.coffee map <F5> :CoffeeRun<CR>

" Javascript
autocmd BufRead,BufNewFile *.js map <F5> :!node %<CR>

" PHP
autocmd BufRead,BufNewFile *.php map <F5> :% w !php<CR>

" Python
autocmd BufRead,BufNewFile *.py map <F5> :!python %<CR>

" Ruby
autocmd BufRead,BufNewFile *.rb map <F5> :!ruby %<CR>

"autocmd BufRead,BufNewFile *.rb map <F5> :% w !ruby -w<CR>
"VimScript
autocmd BufRead,BufNewFile *.vim map <F5> :source %<CR>:echon "script reloaded!"<CR>

" Scala
autocmd BufRead,BufNewFile *.scala map <F5> :% w !scala %<CR>

" Objective-C
autocmd BufRead,BufNewFile *.m map <F5> :!gcc % -o test -lobjc -framework Cocoa <CR>


" Made by Pitt Mak
" Functionality: execute all text in current buffer as vim script by press F6
function g:selectAllText()
    execute "normal ggVGy"
endfunction

function g:executeVimScript()
    call g:selectAllText()
    execute ':@""'
endfunction
noremap <F6> :call g:executeVimScript() <CR>
