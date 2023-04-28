# gfr.vim

**g**rep & **f**ilter & **r**eplace in vim/neovim

<!-- vim-markdown-toc GFM -->

- [Into](#into)
- [Install](#install)
- [Usage](#usage)

<!-- vim-markdown-toc -->

## Into

`gfr.vim` provides searching, filtering, and replacing feature for vim and neovim.

## Install

This plugin can be installed via vim plugin manager, for example:

```
Plug 'wsdjeg/gfr.vim'
```

## Usage

- `:Grep text`: searching text, display results in quickfix windows.
- `:Filter pattern`: filter searching results based on previous searching results.
- `:GrepSave name`: save current searching results to cache with a name.
- `:GrepResum name`: resum searching results from cache by name.
