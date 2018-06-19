" Load Pathogen for plugins:
	execute pathogen#infect()
	execute pathogen#helptags()

" Some basics:
	set nocompatible
	syntax on
	filetype plugin indent on
	set encoding=utf-8
	" line numbering
	set number
	set relativenumber
	" incremental and highlighted search
	set hlsearch
	set incsearch
	" set tab width to 4
	set shiftwidth=4
	set tabstop=4
	set smartindent
	" ignore cases when autocompleting
	set ignorecase

" for vim live latex preview
	let g:livepreview_engine = 'xelatex' . ''

" formatoptions
	set formatoptions=croq
	set fileformats=unix,dos

"TODO	
	" Seite 162

