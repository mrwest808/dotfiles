augroup filetypedetect
  au! BufRead,BufNewFile *.postcss  setfiletype css
  au! BufRead,BufNewFile *.db  setfiletype cypher
  au! BufRead,BufNewFile *.mdx  setfiletype markdown
augroup END
