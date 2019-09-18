function! template_lite#load(template, ...) abort
  " allow passing range as optional second arg
  let l:range = a:0 == 1 ? a:1 : '0'
  let l:template_path = g:template_lite_dir . '/' . a:template
  execute 'keepalt' l:range . 'r' l:template_path

  " trigger a custom autocmd, to allow arbitrary scripts to run
  doautocmd User TemplateLoad
endfunction

function! s:debug(msg) abort
  if get(g:, 'template_lite_debug')
    echom a:msg
  endif
endfunction

function! template_lite#autocmd_load(template) abort
  if get(b:, 'template_loaded', 0)
    call s:debug('template-lite.vim: Loading '
          \ . a:template
          \ . ' but a template has already been loaded. Skipping.')
  else
    let b:template_loaded = 1
    call template_lite#load(a:template)

    " remove extraneous whitespace
    " since this is on BufNewFile
    $d
  endif
endfunction

function! template_lite#enable() abort
  let g:templates_enabled = 1

  augroup TemplateLiteLoading
    autocmd!

    for [pattern, template] in items(g:template_lite_mappings)
      execute 'autocmd BufNewFile' pattern
        \ "call template_lite#autocmd_load('" . template . "')"
    endfor
  augroup END
endfunction

function! template_lite#disable()
  unlet g:templates_enabled

  autocmd! TemplateLiteLoading
endfunction

function! template_lite#toggle_enable()
  if exists('g:templates_enabled') && g:templates_enabled
    call template_lite#disable()
  else
    call template_lite#enable()
  endif
endfunction
