" trailguide.vim - Navigate past trailing whitespace.
" Author:       Nate Soares <http://so8r.es>
" Version:      1.0
" License:      The same as vim itself. (See |license|)
if exists('g:loaded_trailguide') || &cp || v:version < 700
	finish
endif
let g:loaded_trailguide = 1


" Filetypes in which to allow trailing whitespace.
if !exists('g:trailguide_exceptions')
	let g:trailguide_exceptions = {}
endif


" Whether or not to highlight trailing whitespace automatically.
if !exists('g:trailguide_autohl')
	let g:trailguide_autohl = 0
endif


" The matchgroup to use for trailing whitespace.
if !exists('g:trailguide_matchgroup')
	let g:trailguide_matchgroup = 'ErrorMsg'
endif


" Whether or not to make the default key mappings.
if !exists('g:trailguide_automap')
	let g:trailguide_automap = 0
endif


command! TrailGuideNext call trailguide#next()
command! TrailGuidePrev call trailguide#prev()
command! TrailGuideShow call trailguide#show()
command! TrailGuideHide call trailguide#hide()
command! TrailGuideToggle call trailguide#toggle()
command! -range=% TrailGuideFix call trailguide#fix(<line1>, <line2>)


" Automatically highlight trailing whitespace. Default: 0.
if g:trailguide_autohl
	augroup trailguide
		autocmd!
		autocmd BufEnter ?*
				\	if trailguide#cares()
				\|		call trailguide#show()
				\|	endif
	augroup end
endif


" Make the default key mappings.
if g:trailguide_automap
	noremap <leader>wn :TrailGideNext<CR>
	noremap <leader>wp :TrailGidePrev<CR>
	noremap <leader>ww :TrailGideFix<CR>
	noremap <leader>wt :TrailGuideToggle<CR>
endif
