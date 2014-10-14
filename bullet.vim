" bullet.vim "{{{1

" Last Update: Oct 14, Tue | 16:48:07 | 2014

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

" key mapping "{{{4

" nmap <unique> <silent> ### <plug>BulletNormal
" vmap <unique> <silent> ### <plug>BulletVisual

 "}}}4
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

if !exists('g:TextWidth_Opt_Bullet')
	let g:TextWidth_Opt_Bullet = -1
endif

 "}}}3
" format options, global "{{{3

if !exists('g:FormatOptions_Opt_Bullet')
	let g:FormatOptions_Opt_Bullet = ''
endif

 "}}}3
" comments "{{{3

if !exists('g:Comments_Opt_Bullet')
	let g:Comments_Opt_Bullet = ''
endif

 "}}}3
" protect lines, global "{{{3

if !exists('g:Pat_Protect_Bullet')
	let g:Pat_Protect_Bullet = '\(\({\{3}'
	let g:Pat_Protect_Bullet .=  '\|}\{3}\)'
	let g:Pat_Protect_Bullet .= '\d\{0,2}$\)'
endif

if !exists('g:Cha_Protect_Bullet')
	let g:Cha_Protect_Bullet = '@'
endif

 "}}}3
" bullet mode, global "{{{3

if !exists('g:SwitchBulletMode_Bullet')
	let g:SwitchBulletMode_Bullet = 0
endif

if !exists('g:Pat_File_Bullet')
	let g:Pat_File_Bullet == ''
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
		if g:TextWidth_Opt_Bullet < 0
			let &l:textwidth = &textwidth
		else
			let &l:textwidth =
			\ g:TextWidth_Opt_Bullet
		endif

		" formatoptions
		setl formatoptions&
		if g:FormatOptions_Opt_Bullet != ''
			let &l:formatoptions =
			\ g:FormatOptions_Opt_Bullet
		else
			let &l:formatoptions .= 'ro2mB1j'
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
		\ 's:' . g:Cha_List_Pre_Bullet .
		\ ',m:' . g:Cha_Para_Pre_Bullet.
		\ ',ex:/'

		" sublist characters, after
		let &l:comments .=
		\ 'f:' . g:Cha_SubList_After_Bullet

		" list characters, after
		let &l:comments .=
		\ 'f:' . g:Cha_List_After_Bullet

		" protect characters
		let &l:comments .=
		\ 's:' . g:Cha_Protect_Bullet .
		\ ',m:' . g:Cha_Protect_Bullet .
		\ ',ex:' . g:Cha_Protect_Bullet

		" comments
		if g:Comments_Opt_Bullet != ''
			let &l:comments .=
			\ g:Comments_Opt_Bullet
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
		\ s:SearchPat .
		\ '\)\s*\(\|\/\)\s*$/' .
		\ s:Mark . '/e'
		" only s:EndComment
		execute "'j,'ks/^" . s:EndComment . '$/'
		\ s:Mark . '/e'
		" s:EndComment at the end of line
		if search(s:SearchPat,'cnw') != 0
			execute "'j,'kg/" . s:SearchPat .
			\ '/s/' . s:EndComment . '$//'
		endif
	endif

	" delete marked lines after substitution
	" in case line 'j/'k contains mark
	if a:when == 1
		if search(s:Mark,'cnw') != 0
			execute "'j,'kg/" . s:Mark . '/delete'
		endif
	endif

endfunction "}}}

function s:SubsBullet() "{{{

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

autocmd VimEnter * call <sid>BulletMode()

function s:NoTextWidth_Local(mode,pos) "{{{

	" normal mode
	if a:mode == 0

		if a:pos == 1
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
			if a:pos == 1
				call move_cursor#KeepPos(1)
			endif
			echo 'ERROR: Mark k not found!'
			return
		endtry

		call <sid>DelBullet(0)
		call <sid>SubsBullet()
		call <sid>DelBullet(1)

		if a:pos == 1
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

	if a:pos == 1
		call move_cursor#KeepPos(0)
	endif
	call <sid>LoadSettings(0)

	" mark lines to be deleted
	call move_cursor#Para_SetMarkJK()
	call <sid>DelBullet(0)

	" substitute bullets
	call <sid>SubsBullet()

	" delete marked lines
	call <sid>DelBullet(1)
	" set marker j & k again
	" (in case marked lines are deleted)
	call move_cursor#Para_SetMarkJK()

	'j
	execute 'normal gqip'

	call <sid>LoadSettings(1)
	if a:pos == 1
		call move_cursor#KeepPos(1)
	endif

endfunction "}}}

function s:TwoInOne_Global(textwidth) "{{{

	call move_cursor#KeepPos(0)
	let l:fold_save = &foldenable
	set nofoldenable

	while 1

		if search(s:SearchPat,'wc') == 0
			let &foldenable = l:fold_save
			call move_cursor#KeepPos(1)
			return
		endif

		if a:textwidth == 0
			1mark j
			$mark k
			call <sid>NoTextWidth_Local(0,0)
		elseif a:textwidth == 1
			call <sid>TextWidth_Local(0)
		endif

	endwhile

endfunction "}}}

function s:FormatText(range) "{{{

	" save cursor position
	call move_cursor#KeepPos(0)

	" load settings
	call <sid>LoadSettings(0)

	" mark format range
	" paragraph
	if a:range == 0
		call move_cursor#Para_SetMarkJK()
	" fold block
	elseif a:range == 1
		if move_cursor#Fold_SetMarkJK() == 1
			call <sid>LoadSettings(1)
			call move_cursor#KeepPos(1)
			return
		endif
	" whole text
	elseif a:range == 2
		1mark j
		$mark k
	endif

	" protect lines
	'j
	if search(g:Pat_Protect_Bullet,'c',line("'k"))
	\ != 0
		execute "'j,'kg/" . g:Pat_Protect_Bullet .
		\ '/s/^/' . g:Cha_Protect_Bullet . '/'
	endif

	" format
	" 'jgq'k doesn't work for the last line: 'k
	'k
	execute "normal lgq'j"

	" unprotect lines
	if a:range == 0
		call move_cursor#Para_SetMarkJK()
	elseif a:range == 1
		call move_cursor#Fold_SetMarkJK()
	elseif a:range == 2
		1mark j
		$mark k
	endif
	execute "'j,'ks/^" . g:Cha_Protect_Bullet .
	\ '//e'

	" unload settings
	call <sid>LoadSettings(1)

	" reset cursor position
	call move_cursor#KeepPos(1)

endfunction "}}}

function s:EchoVars() "{{{

	call <sid>LoadSettings(0)
		let l:fo = &formatoptions
		let l:tw = &textwidth
		let l:com = &comments
	call <sid>LoadSettings(1)

	let l:fo_o = g:FormatOptions_Opt_Bullet
	let l:tw_o = g:TextWidth_Opt_Bullet
	let l:com_o = g:Comments_Opt_Bullet

	let l:pat_pro = g:Pat_Protect_Bullet
	let l:cha_pro = g:Cha_Protect_Bullet

	if g:SwitchBulletMode_Bullet != 0
		let l:switch = 'ON'
	else
		let l:switch = 'OFF'
	endif
	let l:mode = g:SwitchBulletMode_Bullet
	let l:file = g:Pat_File_Bullet

	echo '--------------------'
	echo "&formatoptions == '" . l:fo . "'"
	echo "g:FormatOptions_Opt_Bullet == '" .
	\ l:fo_o . "'"
	echo '--------------------'
	echo "&textwidth == '" . l:tw . "'"
	echo "g:TextWidth_Opt_Bullet == '" .
	\ l:tw_o ."'"
	echo '--------------------'
	echo "&comments == '" . l:com . "'"
	echo "g:Comments_Opt_Bullet == '" .
	\ l:com_o . "'"
	echo '--------------------'
	echo "g:Pat_Protect_Bullet == '" .
	\ l:pat_pro . "'"
	echo "g:Cha_Protect_Bullet == '" .
	\ l:cha_pro . "'"
	echo '--------------------'
	echo 'Auto load bullet settings: ' . l:switch
	echo "g:SwitchBulletMode_Bullet == '" .
	\ l:mode . "'"
	echo "g:Pat_File_Bullet == '" . l:file . "'"
	echo '--------------------'

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

if !exists(':FoParagraph')
	command FoParagraph
	\ call <sid>FormatText(0)
endif

if !exists(':FoFoldBlock')
	command FoFoldBlock
	\ call <sid>FormatText(1)
endif

if !exists(':FoWholeText')
	command FoWholeText
	\ call <sid>FormatText(2)
endif

if !exists(':BuEchoVars')
	command BuEchoVars call <sid>EchoVars()
endif

 "}}}2
" cpotions "{{{2

let &cpoptions = s:Save_cpo
unlet s:Save_cpo

 "}}}2
" vim: set fdm=marker fdl=20: "}}}1
