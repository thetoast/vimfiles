runtime! syntax/javascript.vim

syn keyword typeScriptReserved module

syn match typeScriptRef -///\s*<reference\s\+.*/>$- contains=typeScriptRefD,typeScriptRefS
syn region typeScriptRefD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region typeScriptRefS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+


high link typeScriptReserved Keyword

high link typeScriptRef Include
high link typeScriptRefS String
high link typeScriptRefD String
