" trailguide.vim - Navigate past trailing whitespace.
"
" Author:       Nate Soares <http://so8r.es>
" Version:      1.0
" License:      The same as vim itself. (See |license|)

if exists('g:loaded_trailguide') || &cp || v:version < 700
	finish
endif
let g:loaded_trailguide = 1


command! TrailGuideNext call trailguide#Next()
command! TrailGuidePrev call trailguide#Prev()
command! TrailGuideShow call trailguide#Show()
command! TrailGuideHide call trailguide#Hide()
command! TrailGuideToggle call trailguide#Toggle()
command! -range=% TrailGuideFix call trailguide#Fix(<line1>, <line2>)


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


" Automatically highlight trailing whitespace. Default: 0.
if g:trailguide_autohl
	augroup trailguide
		autocmd!
		autocmd BufEnter ?* if trailguide#Cares()
					\| call trailguide#Show()
					\| endif
	augroup end
endif
