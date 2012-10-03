" trailguide.vim - Navigate past trailing whitespace.
"
" Author:       Nate Soares <http://so8r.es>
" Version:      1.0
" License:      The same as vim itself. (See |license|)

if exists('g:loaded_trailguide') || &cp || v:version < 700
	finish
endif
let g:loaded_trailguide = 1


" Commands:
command! TrailGuideNext call trailguide#Next()
command! TrailGuidePrev call trailguide#Prev()
command! -range=% TrailGuideFix call trailguide#Fix(<line1>, <line2>)
command! TrailGuideShow call trailguide#Show()
command! TrailGuideHide call trailguide#Hide()
command! TrailGuideToggle call trailguide#Toggle()


" Automatically highlight trailing whitespace. Default: 0.
if !exists('g:trailguide#autohl') | let g:trailguide#autohl = 0 | endif
if g:trailguide#autohl
	augroup trailguide
		autocmd!
		autocmd BufEnter ?* if trailguide#Cares()
					\| call trailguide#Show()
					\| endif
	augroup end
endif
