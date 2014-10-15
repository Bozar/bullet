" bullet.vim "{{{1

" Last Update: Oct 16, Thu | 00:38:42 | 2014

" user manual "{{{2

" summary "{{{3

" Vim global plugin

" substitute characters with bullet points
" format paragraph/fold block/whole text

" License: GPL v2
" Author: Bozar

 "}}}3
" turn off this plugin "{{{3

" let g:Loaded_Bullet = 1

 "}}}3
" change settings "{{{3

" substitute ### with your own setting
" in the .vimrc, leave the rest part unchanged

" bullet characters "{{{4

" let g:Cha_List_Pre_Bullet = '###'
" let g:Cha_List_After_Bullet = '###'

" let g:Cha_Para_Pre_Bullet = '###'
" let g:Cha_Para_After_Bullet = '###'

" let g:Cha_SubList_Pre_Bullet = '###'
" let g:Cha_SubList_After_Bullet = '###'

" let g:Cha_SubPara_Pre_Bullet = '###'
" let g:Cha_SubPara_After_Bullet = '###'

 "}}}4
" bullet search patterns "{{{4

" let g:Pat_List_Pre_Bullet = '###'
" let g:Pat_List_After_Bullet = '###'

" let g:Pat_Para_Pre_Bullet = '###'
" let g:Pat_Para_After_Bullet = '###'

" let g:Pat_SubList_Pre_Bullet = '###'
" let g:Pat_SubList_After_Bullet = '###'

" let g:Pat_SubPara_Pre_Bullet = '###'
" let g:Pat_SubPara_After_Bullet = '###'

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

if !exists('g:Cha_List_Pre_Bullet')
	let g:Cha_List_Pre_Bullet = '='
endif

if !exists('g:Cha_List_After_Bullet')
	let g:Cha_List_After_Bullet = '*'
endif

if !exists('g:Cha_Para_Pre_Bullet')
	let g:Cha_Para_Pre_Bullet = '-'
endif

 "}}}3
" sublist character, global "{{{3

if !exists('g:Cha_SubList_Pre_Bullet')
	let g:Cha_SubList_Pre_Bullet = '=='
endif

if !exists('g:Cha_SubList_After_Bullet')
	let g:Cha_SubList_After_Bullet = '+'
endif

if !exists('g:Cha_SubPara_Pre_Bullet')
	let g:Cha_SubPara_Pre_Bullet = '--'
endif

 "}}}3
" list pattern, global "{{{3

if !exists('g:Pat_List_Pre_Bullet')
	let g:Pat_List_Pre_Bullet = '^\s*=\(=\)\@!\s*'
endif

if !exists('g:Pat_List_After_Bullet')
	let g:Pat_List_After_Bullet = '\t*\t'
endif

if !exists('g:Pat_Para_Pre_Bullet')
	let g:Pat_Para_Pre_Bullet = '^\s*-\(-\)\@!\s*'
endif

if !exists('g:Pat_Para_After_Bullet')
	let g:Pat_Para_After_Bullet = '\t\t'
endif

 "}}}3
" sublist pattern, global "{{{3

if !exists('g:Pat_SubList_Pre_Bullet')
	let g:Pat_SubList_Pre_Bullet
	\ = '^\s*==\(=\)\@!\s*'
endif

if !exists('g:Pat_SubList_After_Bullet')
	let g:Pat_SubList_After_Bullet = '\t\t+\t'
endif

if !exists('g:Pat_SubPara_Pre_Bullet')
	let g:Pat_SubPara_Pre_Bullet
	\ = '^\s*--\(-\)\@!\s*'
endif

if !exists('g:Pat_SubPara_After_Bullet')
	let g:Pat_SubPara_After_Bullet = '\t\t\t'
endif

 "}}}3
" text width, global "{{{3

if !exists('g:TextWidth_Bullet')
	let g:TextWidth_Bullet = -1
endif

 "}}}3
" format options, global "{{{3

if !exists('g:FormatOptions_Bullet')
	let g:FormatOptions_Bullet = ''
endif
if !exists('g:FormatOptions_Minus_Bullet')
	let g:FormatOptions_Minus_Bullet = ''
endif


 "}}}3
" comments "{{{3

if !exists('g:Comments_Add_Bullet')
	let g:Comments_Add_Bullet = ''
endif
if !exists('g:Comments_Overwrite_Bullet')
	let g:Comments_Overwrite_Bullet = ''
endif

 "}}}3
" protect lines, global "{{{3

if !exists('g:Pat_Protect_Add_Bullet')
	let g:Pat_Protect_Add_Bullet = ''
endif
if !exists('g:Pat_Protect_Overwrite_Bullet')
	let g:Pat_Protect_Overwrite_Bullet = ''
endif

if !exists('g:Cha_Protect_Bullet')
	let g:Cha_Protect_Bullet = ''
endif

 "}}}3
" bullet mode, global "{{{3

if !exists('g:SwitchBulletMode_Bullet')
	let g:SwitchBulletMode_Bullet = 0
endif

if !exists('g:Pat_File_Bullet')
	let g:Pat_File_Bullet = ''
endif

 "}}}3
" local "{{{3

let s:SearchPat =
\ g:Pat_List_Pre_Bullet . '\|' .
\ g:Pat_Para_Pre_Bullet . '\|' .
\ g:Pat_SubList_Pre_Bullet . '\|' .
\ g:Pat_SubPara_Pre_Bullet

let s:Mark = '###LOOONG_PLACEHOLDER_FOR_BULLET###'
let s:EndComment = '\s*\/\s*'

 "}}}3
 "}}}2
" function "{{{2

" parts "{{{3

function s:LoadSettings(when) "{{{

	" load settings
	if a:when == 0

		let s:TextWidth_Save =
		\ &textwidth
		let s:FormatOptions_Save =
		\ &formatoptions
		let s:Comments_Save =
		\ &comments

		" textwidth
		if g:TextWidth_Bullet < 0
			let &l:textwidth = &textwidth
		else
			let &l:textwidth =
			\ g:TextWidth_Bullet
		endif

		" formatoptions
		setl formatoptions&
		if g:FormatOptions_Bullet != ''
			let &l:formatoptions =
			\ g:FormatOptions_Bullet
		else
			let &l:formatoptions .= 'ro2mB1j'
			let g:FormatOptions_Bullet =
			\ &l:formatoptions
		endif
		let &l:formatoptions =
		\ substitute(&l:formatoptions,
		\ g:FormatOptions_Minus_Bullet,'','')

		" protect lines, character
		if g:Cha_Protect_Bullet != ''
			let s:Cha_Protect =
			\ g:Cha_Protect_Bullet
		else
			let s:Cha_Protect = '@'
		endif

		" comments
		setl comments=

		" sublist characters, pre
		let &l:comments .=
		\ 's:' . g:Cha_SubList_Pre_Bullet .
		\ ',m:' . g:Cha_SubPara_Pre_Bullet.
		\ ',ex:/'

		" list characters, pre
		let &l:comments .=
		\ ',s:' . g:Cha_List_Pre_Bullet .
		\ ',m:' . g:Cha_Para_Pre_Bullet.
		\ ',ex:/'

		" sublist characters, after
		let &l:comments .=
		\ ',f:' . g:Cha_SubList_After_Bullet

		" list characters, after
		let &l:comments .=
		\ ',f:' . g:Cha_List_After_Bullet

		" protect characters
		let &l:comments .=
		\ ',s:' . s:Cha_Protect .
		\ ',m:' . s:Cha_Protect .
		\ ',ex:' . s:Cha_Protect

		if g:Comments_Add_Bullet != ''
			let &l:comments .= ',' .
			\ g:Comments_Add_Bullet
		endif
		if g:Comments_Overwrite_Bullet != ''
			let &l:comments =
			\ g:Comments_Overwrite_Bullet
		endif

		" protect lines, pattern
		let s:Pat_Protect_Origin = '\(\({\{3}'
		let s:Pat_Protect_Origin .=  '\|}\{3}\)'
		let s:Pat_Protect_Origin .= '\d\{0,2}$\)'

		let s:Pat_Protect_Final =
		\ s:Pat_Protect_Origin .
		\ g:Pat_Protect_Add_Bullet

		if g:Pat_Protect_Overwrite_Bullet != ''
			let s:Pat_Protect_Final =
			\ g:Pat_Protect_Overwrite_Bullet
		endif

	endif

	" unload settings
	if a:when == 1

		" textwidth
		let &l:textwidth =
		\ s:TextWidth_Save

		" formatoptions
		let &l:formatoptions =
		\ s:FormatOptions_Save

		" comments
		let &l:comments =
		\ s:Comments_Save

	endif

endfunction "}}}

function s:DelBullet(when) "{{{

	" suppose '=' will be replaced with bullet '*'
	" delete lines containing only such characters
	" '^\s*=\s*$' or '^\s*\/\s*$'
	" '/' appears in a three-piece comment
	" which is defined in s:LoadSettings()
	" :help format-comments

	if a:when == 0
		" only bullet
		execute "'j,'ks/\\(" .
		\ s:SearchPat . '\)\(' .
		\ s:EndComment . '\|\s*\)$/' .
		\ s:Mark . '/e'
		" only s:EndComment
		execute "'j,'ks/^" . s:EndComment . '$/'
		\ s:Mark . '/e'
		" s:EndComment at the end of line
		let l:pattern = '\(' . s:SearchPat .
		\ '\).*' . s:EndComment . '$'
		'j
		if search(l:pattern,'c',line("'k")) != 0
			execute "'j,'kg/" . s:SearchPat .
			\ '/s/' . s:EndComment . '$//'
		endif
	endif

	" delete marked lines after substitution
	" in case line 'j/'k contains mark
	if a:when == 1
		'j
		if search(s:Mark,'c',line("'k")) != 0
			execute "'j,'kg/" . s:Mark . '/delete'
		endif
	endif

endfunction "}}}

function s:SubsBullet_Core() "{{{

	" list
	" substitute '=' with '*' and indent 1 tab
	" substitute '-' with '' and indent 1 tab
	execute "'j,'ks/" .
	\ g:Pat_List_Pre_Bullet .  '/' .
	\ g:Pat_List_After_Bullet . '/e'
	execute "'j,'ks/" .
	\ g:Pat_Para_Pre_Bullet . '/' .
	\ g:Pat_Para_After_Bullet . '/e'

	" sub list
	" substitute '==' with '+' and indent 2 tabs
	" substitute '--' with '' and indent 2 tabs
	execute "'j,'ks/" .
	\ g:Pat_SubList_Pre_Bullet . '/' .
	\ g:Pat_SubList_After_Bullet . '/e'
	execute "'j,'ks/" .
	\ g:Pat_SubPara_Pre_Bullet . '/' .
	\ g:Pat_SubPara_After_Bullet . '/e'

endfunction "}}}

function s:BulletMode() "{{{

	if g:SwitchBulletMode_Bullet == 0
		return
	endif

	if g:Pat_File_Bullet == ''
		return
	endif

	execute 'autocmd BufRead,BufNewFile ' .
	\ g:Pat_File_Bullet .
	\ ' call <sid>LoadSettings(0)'

endfunction "}}}

function s:ShowValue(name) "{{{

	echo a:name . " == '" . eval(a:name) ."'"

endfunction "}}}

 "}}}3
" main "{{{3

function s:SubsBullet_NoTW(range) "{{{

	call move_cursor#KeepPos(0)

	" set mark j & k
	" paragraph
	if a:range == 0
		call move_cursor#Para_SetMarkJK()
	" whole text
	elseif a:range == 1
		1mark j
		$mark k
	endif

	" mark lines to be deleted
	call <sid>DelBullet(0)
	" substitute bullets
	call <sid>SubsBullet_Core()
	" delete marked lines
	call <sid>DelBullet(1)

	call move_cursor#KeepPos(1)

endfunction "}}}

function s:SubsBullet_TW(range) "{{{

	" save cursor position
	call move_cursor#KeepPos(0)
	" load settings
	call <sid>LoadSettings(0)

	let l:i = 0

	while 1

		" set mark j & k
		" paragraph
		if a:range == 0
			call move_cursor#Para_SetMarkJK()
		" whole text
		elseif a:range == 1
			1mark j
			$mark k
		endif

		" substitute bullets once
		" set marks twice (before and after
		" substitution), in case marked lines 'j
		" and 'k are deleted
		if l:i > 0
			break
		endif

		" mark lines to be deleted
		call <sid>DelBullet(0)
		" substitute bullets
		call <sid>SubsBullet_Core()
		" delete marked lines
		call <sid>DelBullet(1)

		let l:i = l:i +1

	endwhile

	" protect lines
	'j
	if search(s:Pat_Protect_Final,'c',line("'k"))
		execute "'j,'kg/" . s:Pat_Protect_Final .
		\ '/s/^/' . s:Cha_Protect . '/'
	endif

	" format
	if a:range == 0
		execute "normal 'jgqip"
	elseif a:range == 1
		execute "normal gggqG"
	endif

	" unprotect lines
	if a:range == 0
		call move_cursor#Para_SetMarkJK()
	elseif a:range == 1
		1mark j
		$mark k
	endif
	execute "'j,'ks/^" . s:Cha_Protect . '//e'

	" unload settings
	call <sid>LoadSettings(1)
	" reset cursor position
	call move_cursor#KeepPos(1)

endfunction "}}}

function s:EchoVars() "{{{

	call <sid>LoadSettings(0)

	if g:SwitchBulletMode_Bullet != 0
	\ && g:Pat_File_Bullet != ''
		let l:switch = 'ON'
	else
		let l:switch = 'OFF'
	endif

	echo '------------------------------'
	call <sid>ShowValue('&formatoptions')
	call <sid>ShowValue('g:FormatOptions_Bullet')
	call <sid>ShowValue('g:FormatOptions_Minus
	\_Bullet')

	echo '------------------------------'
	call <sid>ShowValue('&textwidth')
	call <sid>ShowValue(
	\'g:TextWidth_Bullet')

	echo '------------------------------'
	call <sid>ShowValue('&comments')
	call <sid>ShowValue(
	\'g:Comments_Add_Bullet')
	call <sid>ShowValue(
	\'g:Comments_Overwrite_Bullet')

	echo '------------------------------'
	call <sid>ShowValue('s:Pat_Protect_Final')
	call <sid>ShowValue(
	\'g:Pat_Protect_Add_Bullet')
	call <sid>ShowValue(
	\'g:Pat_Protect_Overwrite_Bullet')

	echo '------------------------------'
	call <sid>ShowValue('s:Cha_Protect')
	call <sid>ShowValue(
	\'g:Cha_Protect_Bullet')

	echo '------------------------------'
	echo 'Auto load bullet settings: ' . l:switch
	call <sid>ShowValue(
	\'g:SwitchBulletMode_Bullet')
	call <sid>ShowValue(
	\'g:Pat_File_Bullet')

	echo '------------------------------'

	call <sid>LoadSettings(1)

endfunction "}}}

 "}}}3
 "}}}2
" commands "{{{2

autocmd VimEnter * call <sid>BulletMode()

if !exists(':BuParaTW')
	command BuParaTW call <sid>SubsBullet_TW(0)
endif

if !exists(':BuParaNoTW')
	command BuParaNoTW
	\ call <sid>SubsBullet_NoTW(0)
endif

if !exists(':BuWholeNoTW')
	command BuWholeNoTW
	\ call <sid>SubsBullet_NoTW(1)
endif

if !exists(':BuWholeTW')
	command BuWholeTW call <sid>SubsBullet_TW(1)
endif

if !exists(':BuEcho')
	command BuEcho call <sid>EchoVars()
endif

 "}}}2
" cpotions "{{{2

let &cpoptions = s:Save_cpo
unlet s:Save_cpo

 "}}}2
" vim: set fdm=marker fdl=20: "}}}1
