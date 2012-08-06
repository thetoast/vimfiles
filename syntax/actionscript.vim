runtime! syntax/javascript.vim
unlet b:current_syntax

syn keyword GetSet get set
syn match MemberMod /^\s*\[.*\]\s*$/ contains=Modifiers
syn keyword Modifiers Bindable contained

high link GetSet Keyword
high link MemberMod Type
high link Modifiers Function
