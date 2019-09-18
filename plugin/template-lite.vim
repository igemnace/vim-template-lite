if exists('g:loaded_template_lite')
  finish
endif
let g:loaded_template_lite = 1

" define defaults
let g:template_lite_dir = get(g:, 'template_lite_dir',
      \ $HOME.'/.vim/templates')
let g:template_lite_autoload = get(g:, 'template_lite_autoload', 1)
let g:template_lite_mappings = get(g:, 'template_lite_mappings', {})

" define command completion functions
function! s:ShortenTemplateFilename(index, filename)
  return fnamemodify(a:filename, ':s?'.g:template_lite_dir.'/??')
endfunction

function! s:CompleteTemplates(ArgLead, CmdLine, CursorPos)
  let path_list = globpath(g:template_lite_dir, a:ArgLead . '**', 0, 1)
  let files_path_list = filter(l:path_list, '!isdirectory(v:val)')
  let relative_path_list = map(l:files_path_list,
        \ function('s:ShortenTemplateFilename'))

  return relative_path_list
endfunction

" define commands for template functions
command! EnableTemplates call template_lite#enable()
command! DisableTemplates call template_lite#disable()
command! ToggleTemplates call template_lite#toggle_enable()
command! -nargs=1 -range=0 -complete=customlist,s:CompleteTemplates LoadTemplate
      \ call template_lite#load(<f-args>, <count>)

" enable template loading if autoload is turned on
if g:template_lite_autoload
  call template_lite#enable()
endif
