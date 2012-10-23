runtime! syntax/javascript.vim
unlet b:current_syntax

syn keyword FlexKeywords dynamic get set override
syn match FlexMemberMod /^\s*\[.*\]\s*$/ contains=FlexModifiers
syn match FlexModifiers /\w\+/ contained
syn keyword FlexRepeat each
syn keyword FlexOperators as
syn keyword FlexConditionals is
syn keyword FlexReserved uint

high link FlexKeywords Keyword
high link FlexMemberMod Type
high link FlexModifiers Function
high link FlexRepeat Repeat
high link FlexOperators Operator
high link FlexConditionals Conditional
high link FlexReserved Keyword
