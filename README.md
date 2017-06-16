# vim-template-lite

A tiny Vim plugin for loading template files.

## Installation

Copy `plugin/template-lite.vim` to `~/.vim/plugin/template-lite.vim` on
UNIX-like systems, or install with your favorite plugin manager.

## Usage

Put your template files into your templates directory (`$HOME/.vim/templates` by
default). The filenames and subdirectory names can be whatever you want.

To load your templates automatically, add an entry to
`g:template_lite_mappings`. To illustrate by example:

If I have a template for a Javascript unit test and I put it in
`~/.vim/templates/javascript/template.test.js`, I'd have the following line in
my `.vimrc`:

```vim
let g:template_lite_mappings = { '*.test.js': 'javascript/template.test.js' }
```

This will load my template for all files whose filename matches `*.test.js`.

You can as many entries as necessary, as long as you follow the `pattern:
template_path` format. For example, my `.vimrc` has the following lines:

```vim
let g:template_lite_mappings = {
  \  '*.component.js': 'react-native/component.js',
  \  '*.hoc.js': 'react-native/hoc.js',
  \  '*.styles.js': 'react-native/styles.js',
  \  '*.redux.js': 'react-native/redux.js',
  \  '*.fire.js': 'react-native/fire.js',
  \  '*.component.jsx': 'react/component.jsx',
  \  '*.hoc.jsx': 'react/hoc.jsx',
  \  '*.component.ts': 'angular/component.ts',
  \  '*.sh': 'sh.sh',
  \}
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
current filename. You can even use [Tim Pope's
abolish.vim](https://github.com/tpope/tpope-vim-abolish) plugin to make the
replacement case-aware.

## Configuration

- `g:template_lite_dir` (default: `$HOME/.vim/templates`)

The directory in which vim-template-lite will look for your templates.

- `g:template_lite_autoload` (default: 1)

Governs whether vim-template-lite will enable automatic template loading (1 to
enable, 0 to disable).

- `g:template_lite_mappings` (default: `{}`)

A Dictionary mapping filename patterns to the template filename to be
automatically loaded for them.

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
