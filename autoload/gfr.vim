
""
" @section Introduction, intro
" @library
" @order intro options config layers api faq changelog
" gfr.vim provides searching, filtering, and replacing feature for vim and neovim.

" load the api

let s:JOB = SpaceVim#api#import('job')


let s:grep_exe = 'grep'

let s:grep_default_opt = ''

let s:rst = []


function! gfr#run(...) abort
  if a:0 >= 1
    let expr = a:1
  else
    let expr = input('search expr:')
    normal! :
  endif
  let s:rst = []
  let id =  s:JOB.start(s:get_search_cmd(expr), {
        \ 'on_stdout' : function('s:grep_stdout'),
        \ 'on_stderr' : function('s:grep_stderr'),
        \ 'in_io' : 'null',
        \ 'on_exit' : function('s:grep_exit'),
        \ })
  if id > 0
    echohl Comment
    echo 'searching: ' . expr
    echohl None
  endif
endfunction


function! s:grep_stdout(id, data, event) abort
  for data in a:data
    let info = split(data, '\:\d\+\:')
    if len(info) == 2
      let [fname, text] = info
      let lnum = matchstr(data, '\:\d\+\:')[1:-2]
      call add(s:rst, {
            \ 'filename' : fnamemodify(fname, ':p'),
            \ 'lnum' : lnum,
            \ 'text' : text,
            \ })
    endif
  endfor
endfunction

function! s:grep_stderr(id, data, event) abort

endfunction

function! s:grep_exit(id, data, event) abort
  call setqflist([], 'r', {'title': ' ' . len(s:rst) . ' items',
        \ 'items' : s:rst
        \ })
  botright copen
endfunction

function! s:get_search_cmd(expr) abort
  return ['grep', '-inHR', '--exclude-dir', '.git', a:expr, '.']
endfunction

function! s:list()
  call setqflist([], 'r', {'title': ' ' . len(s:rst) . ' items',
        \ 'items' : s:rst
        \ })
  botright copen
endfunction


"" filter function

function! gfr#filter(pattern) abort
  let temp_file = tempname()
  let context = []
  for item in s:rst
    call add(context, item.filename . ':' . item.lnum .  ':' . item.text)
  endfor
  call writefile(context, temp_file)
  let s:rst = []
  let cmd = ['grep', a:pattern, temp_file]
  let id =  s:JOB.start(cmd, {
        \ 'on_stdout' : function('s:grep_stdout'),
        \ 'on_stderr' : function('s:grep_stderr'),
        \ 'in_io' : 'null',
        \ 'on_exit' : function('s:grep_exit'),
        \ })
  if id > 0
    echohl Comment
    echo 'filtering: ' . a:pattern
    echohl None
  endif
endfunction
