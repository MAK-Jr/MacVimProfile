===About objcscope===

Objcscope is a vim plugin for jumping to definition or implement of objc seletor
like cscope for c/c++.

Objcscope just works on Linux/Unix, Mac OS X, becuase it use the "find" command
line to search path.

===Requirements===

OS: Linux/Unix, Mac OS X(Windows not works)

Others: Node.js installed

===Installation===

1. Install Node.js
   See this page: https://github.com/creationix/nvm

2. Install objcscope script(javascript)

   Copy objcscope to ~/ and run:

  		chmod 775 ~/objcscope

   ADD ~/ to your $PATH variable

3. copy the whole folder to ~/.vim

4. Done

===Usage===

1. Enter your directory and run

  		objcsope . 
  	This command will create "ocTags" in current directory

2. in your vimrc add this line:

  		let g:ocTagFile="PAHT FOR YOUR tags file"
3. Move your cursor in the line which contains objc selector and press `ctrl+g`,
objcscope will show up a list for you to select.
`ctrl+d` and enter a file name, this will open the file which has been parsed into the objc tag file

===About Me===

Author: Pitt Mak

Email: Skeleton.MAK.Jr_AT_gmail.com


