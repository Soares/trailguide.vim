function! trailguide#status#flag()
	return trailguide#status#warning()
endfunction


function! trailguide#status#warning()
	return trailguide#detected() ? '[$]' : ''
endfunction
