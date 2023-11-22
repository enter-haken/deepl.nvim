call _deepl_init()

function! s:get_selected_text()
  let tmp = @@
  silent normal gvy
  let selected_text = @@
  let @@ = tmp
  return selected_text
endfunction

function! deepl#show_translated_text(source, target) range
  let selected_text = s:get_selected_text()
  echo _deepl_get_translated_text(a:source, a:target, selected_text)
endfunction

" Replace visual selection
" ref: https://github.com/christianrondeau/vim-base64/blob/d15253105f6a329cd0632bf9dcbf2591fb5944b8/autoload/base64.vim#L29
function! deepl#replace_to_translated_text(source, target)

  " Preserve line breaks
  let l:paste = &paste
  set paste

  try
    " Apply transformation to the text
    execute "normal! c\<C-r>=_deepl_get_translated_text('" .. a:source .. "', '" .. a:target .. "', @\")\<CR>\<Esc>"
  finally
    " Select the new text
    normal! `[v`]h
    " Revert to previous mode
    let &paste = l:paste
  endtry
endfunction
