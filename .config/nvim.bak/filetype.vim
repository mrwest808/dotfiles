augroup filetypedetect
  au! BufRead,BufNewFile *.postcss  setfiletype css
  au! BufRead,BufNewFile *.db  setfiletype cypher
  au! BufRead,BufNewFile *.mdx  setfiletype markdown
  au! BufRead,BufNewFile *.cypher  setfiletype cypher
  au! BufRead,BufNewFile *.ejs  setfiletype html
augroup END

augroup tasks
  autocmd!
  au Filetype tasks silent! nmap <buffer> <leader>tt <Plug>(TasksToggleAndClearTask)
  au Filetype tasks silent! nmap <buffer> <leader>td <Plug>(TasksCompleteTask)
augroup END
