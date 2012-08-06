runtime! syntax/xml.vim

syn include @actionscript syntax/actionscript.vim
syn include @actionscript syntax/javascript.vim

syn region ScriptTag start=/<fx:Script>/ end=/<\/fx:Script>/ contains=ScriptCDATA,xmlTag,xmlEndTag,xmlCdataEnd keepend
syn region ScriptCDATA start=/<!\[CDATA\[/ end=/\]\]>/me=s-1 contains=xmlCdataStart,@actionscript keepend
