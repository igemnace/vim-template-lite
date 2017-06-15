# vim-template-lite

A tiny Vim plugin for loading template files.

## Configuration

- `g:templates_dir` (default: `$HOME/.vim/skeletons`)

The directory in which vim-template-lite will look for your templates.

- `g:templates_autoload` (default: 1)

Governs whether vim-template-lite will enable automatic template loading (1 to
enable, 0 to disable).

- `g:templates_mappings` (default: `{}`)

A Dictionary mapping filename patterns to the template filename to be
automatically loaded for them.

Example:

If I have a template for a Javascript unit test and I put it in
`~/.vim/skeletons/javascript/template.test.js`, I'd have the following line in
my `.vimrc`:

```vim
let g:templates_mappings = { '*.test.js': 'javascript/template.test.js' }
```

## Other Usage

### Manual Loading

Use `:DisableTemplates` to temporarily stop automatically loading templates. Use
`:EnableTemplates` to turn it back on.

Use `:LoadTemplate` to manually load a template. The argument should be a
filename relative to your templates directory, for example `:LoadTemplate
python/template.py`.

`:LoadTemplate` is Tab-completable, to help you identify your template quickly.

### Replacement Text

I intentionally left out automatic text replacement, to allow the user full
control over the templates.

You can implement this by hooking up an `autocmd` instead. For example,

```vim
autocmd User TemplateLoad execute "%s/{{filename}}/" . expand("%:t:r") . "/g"
```

This will replace all instances of `{{filename}}` in the template with the
current filename. You can even use [Tim Pope's abolish.vim](https://github.com/tpope/tpope-vim-abolish) plugin
to make the replacement case-aware.

## Tiny Vim Plugins

I have a set of functionality in my .vimrc that I intentionally implemented with
a minimalist philosophy.

I don't want a monolithic plugin to do all sorts of things for me all at once.
Instead, I want tiny plugins that do a single, specific task each.

This way I can compose several of these tiny plugins to achieve what I want,
while still allowing me to configure and leave out unwanted behavior. Moreover,
I can rely on other excellent tools that already exist!

## Licensing

This project is free and open source software, licensed under the MIT license.
You are free to use, modify, and redistribute this software.

Take a look at [Github's Choose a License page](https://choosealicense.com/licenses/mit/) for a bit more detail.
