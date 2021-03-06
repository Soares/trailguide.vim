" Regular Expressions:
let s:regex = '\v\s+%#@<!$'
let s:regex_all = '\v\s+$'

function! trailguide#run(arg, line1, line2) abort "{{{
	if a:arg ==# 'fix'
		call trailguide#fix(a:line1, a:line2)
	elseif a:arg ==# 'prev' || a:arg ==# 'previous'
		call trailguide#prev()
	elseif a:arg ==# 'next'
		call trailguide#next()
	elseif a:arg ==# 'show'
		call trailguide#show()
	elseif a:arg ==# 'hide'
		call trailguide#hide()
	elseif a:arg ==# 'toggle' || a:arg ==# ''
		call trailguide#toggle()
	else
		echohl ErrorMsg
		echo "Unknown TrailGuide command:" a:arg
		echohl None
	endif
endfunction "}}}

function! trailguide#complete(arglead, cmdline, cursorpos) abort "{{{
	return ['show', 'hide', 'toggle', 'next', 'prev', 'previous']
endfunction "}}}

" Whether or not to care about trailing whitespace.
function! trailguide#cares() abort "{{{
	return get(b:, 'trailguide', !&readonly)
endfunction "}}}


" Finds whether or not a file has trailing  whitespace.
" @return {boolean} Whether there is trailing whitespace.
function! trailguide#detected() abort "{{{
	return trailguide#cares() && search(s:regex, 'nw') != 0
endfunction "}}}


" Jump to the next trailing whitespace.
function! trailguide#next() abort "{{{
	call search(s:regex_all, 'w')
endfunction "}}}


" Jump to the previous trailing whitespace.
function! trailguide#prev() abort "{{{
	call search(s:regex_all, 'wb')
endfunction "}}}


" Removes all trailing whitespace in a range.
" We don't use a range function because they forcibly move the cursor.
" @param {number} line1 Where to start.
" @param {number} line2 Where to end.
function! trailguide#fix(line1, line2) abort "{{{
	if trailguide#detected()
		let l:view = winsaveview()
		execute a:line1.','a:line2.'s/'.s:regex_all.'//e'
		call winrestview(l:view)
	endif
endfunction "}}}


" Shows trailing whitespace.
function! trailguide#show() abort "{{{
	let b:trailguide_showing = matchadd(g:trailguide_matchgroup, s:regex)
endfunction "}}}


" Hides trailing whitespace
function! trailguide#hide() abort "{{{
	if exists('b:trailguide_showing')
		call matchdelete(b:trailguide_showing)
		unlet b:trailguide_showing
	endif
endfunction "}}}


" Toggles trailing whitespace
function! trailguide#toggle() abort "{{{
	if exists('b:trailguide_showing')
		call trailguide#hide()
	else
		call trailguide#show()
	endif
endfunction "}}}
