function! trailguide#status#warning()
	return trailguide#detected() ? '[$]' : ''
endfunction
