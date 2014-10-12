" bullet.vim "{{{1

" summary "{{{2

" Vim global plugin
" substitute characters with bullet points

" License: GPL v2
" Author: Bozar

 "}}}2
" user manual "{{{2

" turn off this plugin "{{{3

" let g:Loaded_Bullet = 1

 "}}}3
" change settings "{{{3

" substitute ### with your own setting
" in the .vimrc, leave the rest part unchanged

" key mapping "{{{4

" nmap <unique> <silent> ### <plug>BulletNormal
" vmap <unique> <silent> ### <plug>BulletVisual

 "}}}4
" bullet characters "{{{4

" let g:List_Cha_Pre_Bullet = '###'
" let g:List_Cha_After_Bullet = '###'

" let g:Para_Cha_Pre_Bullet = '###'
" let g:Para_Cha_After_Bullet = '###'

" let g:SubList_Cha_Pre_Bullet = '###'
" let g:SubList_Cha_After_Bullet = '###'

" let g:SubPara_Cha_Pre_Bullet = '###'
" let g:SubPara_Cha_After_Bullet = '###'

 "}}}4
" bullet search patterns "{{{4

" let g:List_Pat_Pre_Bullet = '###'
" let g:List_Pat_After_Bullet = '###'

" let g:Para_Pat_Pre_Bullet = '###'
" let g:Para_Pat_After_Bullet = '###'

" let g:SubList_Pat_Pre_Bullet = '###'
" let g:SubList_Pat_After_Bullet = '###'

" let g:SubPara_Pat_Pre_Bullet = '###'
" let g:SubPara_Pat_After_Bullet = '###'

 "}}}4
 "}}}3
 "}}}2
" load & cpoptions "{{{2

if exists('g:Loaded_Bullet')
	finish
endif

let g:Loaded_Bullet = 1
let s:Save_cpo = &cpoptions
set cpoptions&vim

 "}}}2
" variables "{{{2

" list character, global "{{{3

if !exists('g:List_Cha_Pre_Bullet')
	let g:List_Cha_Pre_Bullet = '='
endif

if !exists('g:List_Cha_After_Bullet')
	let g:List_Cha_After_Bullet = '*'
endif

if !exists('g:Para_Cha_Pre_Bullet')
	let g:Para_Cha_Pre_Bullet = '-'
endif

 "}}}3
" sublist character, global "{{{3

if !exists('g:SubList_Cha_Pre_Bullet')
	let g:SubList_Cha_Pre_Bullet = '=='
endif

if !exists('g:SubList_Cha_After_Bullet')
	let g:SubList_Cha_After_Bullet = '+'
endif

if !exists('g:SubPara_Cha_Pre_Bullet')
	let g:SubPara_Cha_Pre_Bullet = '--'
endif

 "}}}3
" list pattern, global "{{{3

if !exists('g:List_Pat_Pre_Bullet')
	let g:List_Pat_Pre_Bullet = '^\s*=\(=\)\@!\s*'
endif

if !exists('g:List_Pat_After_Bullet')
	let g:List_Pat_After_Bullet = '\t*\t'
endif

if !exists('g:Para_Pat_Pre_Bullet')
	let g:Para_Pat_Pre_Bullet = '^\s*-\(-\)\@!\s*'
endif

if !exists('g:Para_Pat_After_Bullet')
	let g:Para_Pat_After_Bullet = '\t\t'
endif

 "}}}3
" sublist pattern, global "{{{3

if !exists('g:SubList_Pat_Pre_Bullet')
	let g:SubList_Pat_Pre_Bullet
	\ = '^\s*==\(=\)\@!\s*'
endif

if !exists('g:SubList_Pat_After_Bullet')
	let g:SubList_Pat_After_Bullet = '\t\t+\t'
endif

if !exists('g:SubPara_Pat_Pre_Bullet')
	let g:SubPara_Pat_Pre_Bullet
	\ = '^\s*--\(-\)\@!\s*'
endif

if !exists('g:SubPara_Pat_After_Bullet')
	let g:SubPara_Pat_After_Bullet = '\t\t\t'
endif

 "}}}3
" text width, global "{{{3

let s:TextWidth_Default_Save = &textwidth
let s:FormatOptions_Default_Save = &formatoptions
let s:Comments_Default_Save = &comments

if !exists('g:TextWidth_Bullet')
	if &textwidth != 0
		let g:TextWidth_Bullet = &textwidth
	else
		let g:TextWidth_Bullet = 50
	endif
endif

if !exists('g:List_IndentSpace_Bullet')
	let g:List_IndentSpace_Bullet = 8
endif

if !exists('g:SubList_IndentSpace_Bullet')
	let g:SubList_IndentSpace_Bullet = 12
endif

 "}}}3
" local "{{{3

let s:SearchPattern =
\ g:List_Pat_Pre_Bullet . '\|' .
\ g:Para_Pat_Pre_Bullet . '\|' .
\ g:SubList_Pat_Pre_Bullet . '\|' .
\ g:SubPara_Pat_Pre_Bullet

let s:Mark = '###LOOOOOOONG_PLACEHOLDER_BULLET###'

 "}}}3
 "}}}2
" function "{{{2

function s:ChangeSetting(when) "{{{

	" load settings
	if a:when == 0

		" textwidth
		execute "setl textwidth=" .
		\ g:TextWidth_Bullet

		" formatoptions
		setl formatoptions&
		setl formatoptions+=ro2mB1j

		" comments
		setl comments&

		" sublist characters, pre
		execute "setl comments+=s:" .
		\ g:SubList_Cha_Pre_Bullet . ",m:" .
		\ g:SubPara_Cha_Pre_Bullet. ",ex:/"

		" list characters, pre
		execute "setl comments+=s:" .
		\ g:List_Cha_Pre_Bullet . ",m:" .
		\ g:Para_Cha_Pre_Bullet. ",ex:/"

		" sublist characters, after
		execute "setl comments+=:" .
		\ g:SubList_Cha_After_Bullet

		" list characters, after
		execute "setl comments+=:" .
		\ g:List_Cha_After_Bullet

	" unload settings
	elseif a:when == 1

		" textwidth
		execute "setl textwidth=" .
		\ s:TextWidth_Default_Save

		" formatoptions
		execute "setl formatoptions=" .
		\ s:FormatOptions_Default_Save

		" comments
		execute "setl comments=" .
		\ s:Comments_Default_Save

	endif

endfunction "}}}

function s:DefineVar_TextWidth() "{{{

	" set new textwidth
	" list
	if substitute(getline("'j"),
	\ g:List_Pat_Pre_Bullet . "\\|" .
	\ g:Para_Pat_Pre_Bullet,"","")
	\ != getline("'j")
		let s:TextWidth_New =
		\ g:TextWidth_Bullet
		\ - g:List_IndentSpace_Bullet

	" sublist
	elseif substitute(getline("'j"),
	\ g:SubList_Pat_Pre_Bullet . "\\|" .
	\ g:SubPara_Pat_Pre_Bullet,"","")
	\ != getline("'j")
		let s:TextWidth_New =
		\ g:TextWidth_Bullet
		\ - g:SubList_IndentSpace_Bullet
	endif

endfunction "}}}

function s:SetMarkJK() "{{{

	if line("'{") == 1
		'{mark j
		" } bracket pair
	else
		'{+1mark j
		" } bracket pair
	endif
	if line("'}") == line('$')
		'}mark k
	else
		'}-1mark k
	endif

endfunction "}}}

function s:ClearSingleBullet(when) "{{{

	" suppose '=' will be replaced with bullet '*'
	" delete lines containing only such characters
	" '^\s*=\s*$' or '^\s*\/\s*$'
	" '/' appears in a three-piece comment
	" which is defined in s:FormatOptions()
	" :help format-comments

	if a:when == 0
		execute "'j,'ks/\\(" .
		\ s:SearchPattern .
		\ "\\)\\(\\|\\/\\)\\s*$/" .
		\ s:Mark . "/e"
		execute "'j,'ks/^\\s*\\/\\s*$/" .
		\ s:Mark . "/e"

	" delete marked lines after substitution
	" in case line 'j/'k contains mark
	elseif a:when == 1
		call search(s:Mark)
		if substitute(getline('.'),s:Mark,'','')
		\ != getline('.')
			execute "'j,'kg/" . s:Mark . "/delete"
		endif

	endif

endfunction "}}}

function s:Substitute() "{{{

	" list
	" substitute '=' with '*' and indent 1 tab
	" substitute '-' with '' and indent 1 tab
	execute "'j,'ks/" .
	\ g:List_Pat_Pre_Bullet .  "/" .
	\ g:List_Pat_After_Bullet . "/e"
	execute "'j,'ks/" .
	\ g:Para_Pat_Pre_Bullet . "/" .
	\ g:Para_Pat_After_Bullet . "/e"

	" sub list
	" substitute '==' with '+' and indent 2 tabs
	" substitute '--' with '' and indent 2 tabs
	execute "'j,'ks/" .
	\ g:SubList_Pat_Pre_Bullet . "/" .
	\ g:SubList_Pat_After_Bullet . "/e"
	execute "'j,'ks/" .
	\ g:SubPara_Pat_Pre_Bullet . "/" .
	\ g:SubPara_Pat_After_Bullet . "/e"

endfunction "}}}

function s:NoTextWidth_Local(mode) "{{{

	if a:mode == 0
		" normal mode
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
		call <sid>ClearSingleBullet(0)
		call <sid>Substitute()
		call <sid>ClearSingleBullet(1)

	elseif a:mode == 1
		" visual mode
		'<mark j
		'>mark k
		call <sid>NoTextWidth_Local(0)

	endif

endfunction "}}}

function s:TextWidth_Local() "{{{

	call <sid>ChangeSetting(0)

	" mark lines to be deleted
	call <sid>SetMarkJK()
	call <sid>ClearSingleBullet(0)
	" delete marked lines
	call <sid>ClearSingleBullet(1)
	" set marker j & k again
	" (in case marked lines are deleted)
	call <sid>SetMarkJK()

	" format text
	call <sid>DefineVar_TextWidth()
	execute 'setl textwidth=' . s:TextWidth_New
	'j
	execute 'normal gqip'

	" substitute bullets
	call <sid>Substitute()

	" reset old textwidth & format text
	execute 'setl textwidth=' . g:TextWidth_Bullet
	'j
	execute 'normal gqip'

	call <sid>ChangeSetting(1)

endfunction "}}}

function s:TwoInOne_Global(textwidth) "{{{

	let l:fold_pre = &foldenable
	if l:fold_pre == 1
		set nofoldenable
	endif
	
	while 1

		call search(s:SearchPattern,'wc')
		let l:check = substitute(getline('.'),
		\ s:SearchPattern,'','')

		if l:check == getline('.')
			if l:fold_pre == 1
				set foldenable
			endif
			return
		endif

		" textwidth == 0
		if a:textwidth == 0
			call <sid>SetMarkJK()
			call <sid>NoTextWidth_Local(0)
		" textwidth != 0
		elseif a:textwidth == 1
			call <sid>TextWidth_Local()
		endif

	endwhile

endfunction "}}}

 "}}}2
" key mappings "{{{2

" nno <a-b> :call <sid>TwoInOne_Global(0)<cr>
" vno <a-b>
" \ <esc>:call <sid>NoTextWidth_Local(1)<cr>

" check user settings

if !hasmapto('<plug>BulletNormal')
	nmap <unique> <silent> <a-b>
	\ <plug>BulletNormal
endif

if !hasmapto('<plug>BulletVisual')
	vmap <unique> <silent> <a-b>
	\ <plug>BulletVisual
endif

" call functions

nnoremap <unique> <script> <plug>BulletNormal
\ <sid>Normal
vnoremap <unique> <script> <plug>BulletVisual
\ <sid>Visual

nnoremap <sid>Normal
\ :call <sid>TwoInOne_Global(0)<cr>
vnoremap <sid>Visual
\ <esc>:call <sid>NoTextWidth_Local(1)<cr>

 "}}}2
" commands "{{{2

if !exists(':BuLocalNoTW')
	command BuLocalNoTW
	\ call <sid>NoTextWidth_Local(0)
endif

if !exists(':BuLocalTW')
	command BuLocalTW
	\ call <sid>TextWidth_Local()
endif

if !exists(':BuGlobalNoTW')
	command BuGlobalNoTW
	\ call <sid>TwoInOne_Global(0)
endif

if !exists(':BuGlobalTW')
	command BuGlobalTW
	\ call <sid>TwoInOne_Global(1)
endif

 "}}}2
" cpotions "{{{2

let &cpoptions = s:Save_cpo
unlet s:Save_cpo

 "}}}2
" vim: set fdm=marker fdl=20: "}}}1
