if exists('g:loaded_trailguide')
	finish
endif
let g:loaded_trailguide = 1


" Filetypes in which to allow trailing whitespace.
if !exists('g:trailguide_exceptions')
	let g:trailguide_exceptions = []
endif


" Whether or not to highlight trailing whitespace automatically.
if !exists('g:trailguide_autohl')
	let g:trailguide_autohl = 1
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
if !empty(g:trailguide_automap)
	if type(g:trailguide_automap) == type(1)
		let g:trailguide_automap = 'w'
	endif

	exe 'noremap <leader>'.g:trailguide_automap.'n :TrailGideNext<CR>'
	exe 'noremap <leader>'.g:trailguide_automap.'p :TrailGidePrev<CR>'
	exe 'noremap <leader>'.g:trailguide_automap.'w :TrailGideFix<CR>'
	exe 'noremap <leader>'.g:trailguide_automap.'t :TrailGuideToggle<CR>'
endif
