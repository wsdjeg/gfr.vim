""
" Search text with grep. The results will be displayed in quickfix windows.
command! -nargs=* Grep call gfr#run(<f-args>)

""
" start filter mode based on previous searching results.
command! -nargs=* Filter call gfr#filter(<q-args>)


command! -nargs=1 GrepSave call gfr#save(<q-args>)

command! -nargs=1 GrepResum call gfr#resum(<q-args>)


command! -nargs=+ Replace call gfr#replace(<f-args>)
