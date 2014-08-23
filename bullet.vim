" bullet "{{{1

" header "{{{2

" License: GPL v2

" Author: Bozar

" Vim global plugin
" substitute characters with bullet points

 "}}}2

" vimrc "{{{2

" substitute ### with your own setting in the .vimrc
" leave the rest part unchanged

" key binding

" nmap <unique> <silent> ### <plug>BulletNormal
" vmap <unique> <silent> ### <plug>BulletVisual

" list characters

" let g:ListBefore_Bullet = '###'
" let g:ListAfter_Bullet = '###'

" let g:ParaBefore_Bullet = '###'
" let g:ParaAfter_Bullet = '###'

" let g:SubListBefore_Bullet = '###'
" let g:SubListAfter_Bullet = '###'

" let g:SubParaBefore_Bullet = '###'
" let g:SubParaAfter_Bullet = '###'

 "}}}2

" miscellaneous "{{{2

if exists('g:loaded_Bullet')

	finish

endif

let g:loaded_Bullet = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

 "}}}2

" key mappings "{{{2

" check user settings "{{{3

if !hasmapto('<plug>BulletNormal')

	nmap <unique> <silent> <a-b> <plug>BulletNormal

endif

if !hasmapto('<plug>BulletVisual')

	vmap <unique> <silent> <a-b> <plug>BulletVisual

endif

 "}}}3

" call functions "{{{3

nnoremap <unique> <script> <plug>BulletNormal <sid>Normal
vnoremap <unique> <script> <plug>BulletVisual <sid>Visual

nnoremap <sid>Normal :call <sid>BulletPoint(0)<cr>
vnoremap <sid>Visual <esc>:call <sid>BulletPoint(1)<cr>

 "}}}3
 "}}}2

" commands "{{{2

if !exists(':Bullet') "{{{

	command Bullet call s:BulletPoint(0)

endif "}}}

 "}}}2

" main function "{{{2

function! s:BulletPoint(bullet) "{{{

	if a:bullet == 0

	" catch error

		try
			'j
			catch /E20/
			echo 'ERROR: Mark j not found!'
			return
		endtry

		try
			'k
			catch /E20/
			echo 'ERROR: Mark k not found!'
			return
		endtry

	" list
	" substitute '=' with '*' and indent 1 tab
	" substitute '-' with '' and indent 1 tab

		execute "'j,'ks/" . g:ListBefore_Bullet . "/" . g:ListAfter_Bullet . "/e"
		execute "'j,'ks/" . g:ParaBefore_Bullet . "/" . g:ParaAfter_Bullet . "/e"

	" sub list
	" substitute '==' with '+' and indent 2 tabs
	" substitute '--' with '' and indent 2 tabs

		execute "'j,'ks/" . g:SubListBefore_Bullet . "/" . g:SubListAfter_Bullet . "/e"
		execute "'j,'ks/" . g:SubParaBefore_Bullet . "/" . g:SubParaAfter_Bullet . "/e"

	elseif a:bullet == 1

	" visual mode

		'<mark j
		'>mark k
		call s:BulletPoint(0)

	endif

endfunction "}}}

 "}}}2

" variables "{{{2

" list "{{{3

if !exists('g:ListBefore_Bullet')

	let g:ListBefore_Bullet = '^\s*=\(=\)\@!'

endif

if !exists('g:ListAfter_Bullet')

	let g:ListAfter_Bullet = '\t*\t'

endif

if !exists('g:ParaBefore_Bullet')

	let g:ParaBefore_Bullet = '^\s*-\(-\)\@!'

endif

if !exists('g:ParaAfter_Bullet')

	let g:ParaAfter_Bullet = '\t\t'

endif

 "}}}3

" sublist "{{{3

if !exists('g:SubListBefore_Bullet')

	let g:SubListBefore_Bullet = '^\s*==\(=\)\@!'

endif

if !exists('g:SubListAfter_Bullet')

	let g:SubListAfter_Bullet = '\t\t+\t'

endif

if !exists('g:SubParaBefore_Bullet')

	let g:SubParaBefore_Bullet = '^\s*--\(-\)\@!'

endif

if !exists('g:SubParaAfter_Bullet')

	let g:SubParaAfter_Bullet = '\t\t\t'

endif

 "}}}3
 "}}}2

" miscellaneous "{{{2

let &cpoptions = s:save_cpo
unlet s:save_cpo

 "}}}2

" vim: set foldmethod=marker foldlevel=20: "}}}1
