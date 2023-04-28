command! -nargs=* Grep call gfr#run(<f-args>)

""
" start filter mode based on previous searching results.
command! -nargs=* Filter call gfr#filter(<q-args>)
