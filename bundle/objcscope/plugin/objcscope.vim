" File: objcscope
" Author: Pitt Mak (Skeleton.MAK.Jr [at] gmail [dot] com)

function g:reduceMessage(s)
    let len = strlen(a:s)
    let res = ''
    let c = 0
    let ignoreChar = 0
    let i = 0
    while i <= len
      if (a:s[i] == '@' || a:s[i] == '"') && ignoreChar == 0
        let c = c + 1
        let i = i + 1
        continue
      endif

      if c == 2 && ignoreChar == 0
        let ignoreChar = 1
        let i = i + 1
        continue
      endif

      if i > 0 && a:s[i] == '"' && a:s[i] !=  "\\" && ignoreChar == 1
        let ignoreChar = 0
        let c = 0
        let i = i + 1
        continue
      endif

      if ignoreChar == 0
        let res = res.a:s[i]
      endif
      let i = i + 1
    endwhile
    return res
endfunction

function g:OpenFile()
  " show a dialog
  call inputsave()
  let filename = input('Enter File Name:')
  call inputrestore()

  if filename == "q"
    return
  endif

  " run objcscope command line
  let stdout = system("objcscope -f ".g:ocTagFile." \"".filename."\"")
  let path = stdout

  if matchstr(path, "File Not Found") != ""
  else
    exe "e ".escape(path,' ')
  endif
endfunction

function g:ListCallTags()
  let cur_line = line('.')
  let text = ''
  let line_text = getline(cur_line)
  let text = text.line_text." "

  let back_ward_line = cur_line
  let fore_ward_line = cur_line
  " add lines foreward
  while matchstr(line_text,';\|{') == ""
    let fore_ward_line = fore_ward_line + 1
    let line_text = getline(fore_ward_line)
    let text = text.line_text." "
  endwhile

  if matchstr(text, '\[\|\]') != ""
    let cur_col = col(".")
    let text = GetCloseBrackets(text, cur_col)
  endif

  let text = g:reduceMessage(text)
  " command line wants \" to escape
  let text = escape(text, '"')

  "execute objcscope
  let cmd = "objcscope -L ".g:callTagFile." \"".text."\""
  let stdout = system(cmd)

  let list = split(stdout,"&&")
  if len(list) <= 0
    return
  endif
  let dict = {}
  for ele in list
    let l = split(ele,"|")
    if l != []
      let dict[l[1]] = l[0]
    endif
  endfor

  " if there is only one item, we don't want to show a menu but just jump
  " to definition
  ""let keys = keys(dict)
  ""if len(keys) == 1
  ""  exe 'e' escape(keys[0],' ')
  ""endif
  " go through all items
  let format = "[Objcscope Author: Pitt Mak eMail: Skeleton.MAK.Jr@gmail.com]\n"
  let format = format."    Index     Line      FileName\n"
  let keys = keys(dict)
  let end = len(keys)
  for i in range(0, end - 1)
    let f = pathshorten(dict[keys[i]])
    let keys[i] = substitute(keys[i],"\\n","","")
    let format = format."    ".GetPrettyFormat(i.'', 10).GetPrettyFormat(keys[i].'', 10).f."\n"
  endfor

  let idx = g:Dialog(format)
  if idx == 'q'
      return
  endif
  let idx = str2nr(idx)

  " open file
  let keys = keys(dict) " refresh keys, coz we modify it above
  exe "e! ".escape(dict[keys[idx]],' ')
  exe "".keys[idx]

endfunction


function g:OCSCOPE_ListTags()
  let cur_line = line('.')
  let text = ''
  let line_text = getline(cur_line)
  let text = text.line_text." "

  let back_ward_line = cur_line
  let fore_ward_line = cur_line
  " add lines foreward
  while matchstr(line_text,';\|{') == ""
    let fore_ward_line = fore_ward_line + 1
    let line_text = getline(fore_ward_line)
    let text = text.line_text." "
  endwhile

  if matchstr(text, '\[\|\]') != ""
    let cur_col = col(".")
    let text = GetCloseBrackets(text, cur_col)
  endif

  let text = g:reduceMessage(text)

  " command line wants \" to escape
  let text = escape(text, "\"")

  "execute objcscope
  let stdout = system("objcscope -S ".g:ocTagFile." \"".text."\"")
  let list = split(stdout,"&&")
  if len(list) <= 0
    return
  endif
  let dict = {}
  for ele in list
    let l = split(ele,"|")
    if l != []
      let dict[l[1]] = l[0]
    endif
  endfor

  " if there is only one item, we don't want to show a menu but just jump
  " to definition
  ""let keys = keys(dict)
  ""if len(keys) == 1
  ""  exe 'e' escape(keys[0],' ')
  ""endif
  " go through all items
  let format = "[Objcscope Author: Pitt Mak eMail: Skeleton.MAK.Jr@gmail.com]\n"
  let format = format."    Index     Line      FileName\n"
  let keys = keys(dict)
  let end = len(keys)
  for i in range(0, end - 1)
    let f = pathshorten(dict[keys[i]])
    let keys[i] = substitute(keys[i],"\\n","","")
    let format = format."    ".GetPrettyFormat(i.'', 10).GetPrettyFormat(keys[i].'', 10).f."\n"
  endfor

  let idx = g:Dialog(format)
  if idx == 'q'
      return
  endif

  let idx = str2nr(idx)

  " open file
  let keys = keys(dict) " refresh keys, coz we modify it above
  exe "e! ".escape(dict[keys[idx]],' ')
  exe "".keys[idx]

endfunction

function! g:Dialog(str)
  call inputsave()
  let idx = input(a:str.'Enter a index: ')
  call inputrestore()
  return idx
endfunction

function! g:test()
  echo "Testing."
endfunction

function! ReverseString(s)
  let len = strlen(a:s)
  let ret = ""
  for i in range(0, len)
    let idx = len - i
    let ret = ret.(a:s[idx])
  endfor
  return ret
endfunction


" Parse for closely selector
function! GetCloseBrackets(s, idx)
  let index = a:idx - 1
  let len = strlen(a:s)
  let resStr = ""
  let str = ""
  let i = index
  let ignoreChar = 0

  " search backward
  while i >= 0
    if a:s[i] == ']'
      let ignoreChar = ignoreChar + 1
    elseif a:s[i] == '[' && ignoreChar != 0
      let ignoreChar = ignoreChar - 1
    endif

    " stop searching
    if a:s[i] == '[' && ignoreChar == 0
      break
    endif

    if ignoreChar == 0
      let str = str.a:s[i]
    endif

    let i = i - 1
  endwhile

  " reverse string and append it to result
  let str = ReverseString(str)
  let resStr = resStr.str

  let str = ""
  let i = index + 1
  let ignoreChar = 0
  " search foreward
  while i <= len - 1
    if a:s[i] == '['
      let ignoreChar = ignoreChar + 1
    elseif a:s[i] == ']' && ignoreChar != 0
      let ignoreChar = ignoreChar - 1
      let i = i + 1
      continue
    endif

    if a:s[i] == ']' && ignoreChar == 0
      break
    endif

    if ignoreChar == 0
      let str = str.a:s[i]
    endif
    let i = i + 1
  endwhile
  " apeend it to result
  let resStr = resStr.str

  " add brackets
  let resStr = "[".resStr."];"
  return resStr
endfunction

function GetPrettyFormat(s, w)
  let len = strlen(a:s)
  let spaceCount = a:w - len
  let i = 1
  let res = "".a:s
  while i <= spaceCount
    let res = res." "
    let i = i + 1
  endwhile
  return res
endfunction

map <C-r> :call g:ListCallTags()<CR>
map <C-g> :call g:OCSCOPE_ListTags()<CR>
map <C-d> :call g:OpenFile()<CR>
" open current file in a newtab
let curFile = expand('%:p')
map <S-t> :exe ":tabnew! ".curFile<CR>

""set g:ocTagFile in vimrc or gvimrc
""let g:ocTagFile="/Users/Pitt/Desktop/Super-Weak-Boy/ocTags"

