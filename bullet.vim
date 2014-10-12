" bullet.vim "{{{1

" user manual "{{{2

" summary "{{{3

" Vim global plugin
" substitute characters with bullet points

" License: GPL v2
" Author: Bozar

 "}}}3
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

function s:KeepPos_IfLoaded() "{{{

	let s:Loaded = 1
	try
		call move_cursor#KeepPos(2)
		catch /E117/
		let s:Loaded = 0
	endtry

endfunction "}}}

autocmd VimEnter * call <sid>KeepPos_IfLoaded()

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

let s:Mark = '###LOOONG_PLACEHOLDER_FOR_BULLET###'

 "}}}3
 "}}}2
" function "{{{2

function s:ChangeSetting(when) "{{{

	" load settings
	if a:when == 0

		let s:TextWidth_Default_Save =
		\ &textwidth
		let s:FormatOptions_Default_Save =
		\ &formatoptions
		let s:Comments_Default_Save =
		\ &comments

		" textwidth
		execute "setl textwidth=" .
		\ g:TextWidth_Bullet

		" formatoptions
		setl formatoptions&
		setl formatoptions+=ro2mB1j

		" comments
		setl comments=

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

	" there are no bullets in this paragraph
	else
		let s:TextWidth_New = g:TextWidth_Bullet

	endif

endfunction "}}}

function s:SetMarkJK() "{{{

	if line("'{") == 1
		'{
		mark j
		" } bracket pair
	else
		'{+1
		mark j
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
		\ "\\)\\s*\\(\\|\\/\\)\\s*$/" .
		\ s:Mark . "/e"
		execute "'j,'ks/^\\s*\\/\\s*$/" .
		\ s:Mark . "/e"

	" delete marked lines after substitution
	" in case line 'j/'k contains mark
	" and to prevent short lines seperated by
	" single bullets ('=' or '-') to be joined
	elseif a:when == 1
		call search(s:Mark)
		if substitute(getline('.'),s:Mark,'','')
		\ != getline('.')
			execute "'j,'kg/" . s:Mark . "/delete"
		endif

	endif

endfunction "}}}

function s:SubsBullet() "{{{

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

function s:NoTextWidth_Local(mode,pos) "{{{

	" normal mode
	if a:mode == 0

		if a:pos == 1 && s:Loaded == 1
			call move_cursor#KeepPos(0)
		endif

		try
			'j
			catch /E20/
			echo 'ERROR: Mark j not found!'
			return
		endtry
		try
			'k
			catch /E20/
			if a:pos == 1 && s:Loaded == 1
				call move_cursor#KeepPos(1)
			endif
			echo 'ERROR: Mark k not found!'
			return
		endtry

		call <sid>ClearSingleBullet(0)
		call <sid>SubsBullet()
		call <sid>ClearSingleBullet(1)

		if a:pos == 1 && s:Loaded == 1
			call move_cursor#KeepPos(1)
		endif

	" visual mode
	elseif a:mode == 1

		'<mark j
		'>mark k
		call <sid>NoTextWidth_Local(0,1)

	endif

endfunction "}}}

function s:TextWidth_Local(pos) "{{{

	if a:pos == 1 && s:Loaded == 1
		call move_cursor#KeepPos(0)
	endif
	call <sid>ChangeSetting(0)

	" mark lines to be deleted
	call <sid>SetMarkJK()
	call <sid>ClearSingleBullet(0)

	" format text
	call <sid>DefineVar_TextWidth()
	execute 'setl textwidth=' . s:TextWidth_New
	'j
	execute 'normal gqip'

	" substitute bullets
	" the end of paragraph is no longer mark k
	" after formatting
	call <sid>SetMarkJK()
	call <sid>SubsBullet()

	" delete marked lines
	call <sid>ClearSingleBullet(1)
	" set marker j & k again
	" (in case marked lines are deleted)
	call <sid>SetMarkJK()

	" reset old textwidth & format text
	execute 'setl textwidth=' . g:TextWidth_Bullet
	'j
	execute 'normal gqip'

	call <sid>ChangeSetting(1)
	if a:pos == 1 && s:Loaded == 1
		call move_cursor#KeepPos(1)
	endif

endfunction "}}}

function s:TwoInOne_Global(textwidth) "{{{

	if s:Loaded == 1
		call move_cursor#KeepPos(0)
	endif
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
			if s:Loaded == 1
				call move_cursor#KeepPos(1)
			endif
			return
		endif

		" textwidth == 0
		if a:textwidth == 0
			call <sid>SetMarkJK()
			call <sid>NoTextWidth_Local(0,0)
		" textwidth != 0
		elseif a:textwidth == 1
			call <sid>TextWidth_Local(0)
		endif

	endwhile

endfunction "}}}

 "}}}2
" key mappings "{{{2

" nno <a-b> :call <sid>TwoInOne_Global(0)<cr>
" vno <a-b>
" \ <esc>:call <sid>NoTextWidth_Local(1,1)<cr>

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
\ <esc>:call <sid>NoTextWidth_Local(1,1)<cr>

 "}}}2
" commands "{{{2

if !exists(':BuLocalNoTW')
	command BuLocalNoTW
	\ call <sid>NoTextWidth_Local(0,1)
endif

if !exists(':BuLocalTW')
	command BuLocalTW
	\ call <sid>TextWidth_Local(1)
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
