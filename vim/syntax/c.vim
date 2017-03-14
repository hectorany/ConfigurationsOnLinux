"highlight Functions"
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions gui=NONE cterm=bold  ctermfg=blue

"syn match cMathOperator display "[-+*%=<>;|.,&!^~:]"
syn match cMathOperator display "++\|--"
hi cMathOperator gui=NONE cterm=bold  ctermfg=yellow

syn match cPointer display "*"
hi cPointer gui=NONE cterm=bold  ctermfg=yellow

syn match cPointerOperator display "->\|\."
hi cPointerOperator gui=NONE cterm=bold  ctermfg=yellow

syn match cLogicalOperator display "[!<>]=\="
hi cLogicalOperator gui=NONE cterm=bold  ctermfg=yellow

syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
hi cBinaryOperator gui=NONE cterm=bold  ctermfg=yellow

syn match cLogicalOperator display "&&\|||"
hi cLogicalOperator gui=NONE cterm=bold  ctermfg=yellow


