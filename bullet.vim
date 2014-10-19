" bullet.vim "{{{1

" Last Update: Oct 19, Sun | 11:39:28 | 2014

" summary "{{{2

" License: GPL v2
" Author: Bozar

" Vim global plugin

" substitute characters with bullet points
" format paragraph/fold block/whole text

 "}}}2
" load & cpoptions "{{{2

if !exists('g:Loaded_Bullet')
	let g:Loaded_Bullet = 0
endif
if g:Loaded_Bullet > 0
	finish
endif
let g:Loaded_Bullet = 1

let s:Save_cpo = &cpoptions
set cpoptions&vim

 "}}}2
" variables "{{{2

" list character "{{{3

if !exists('g:Cha_List_Pre_Bullet')
	let g:Cha_List_Pre_Bullet = ''
endif

if !exists('g:Cha_List_Post_Bullet')
	let g:Cha_List_Post_Bullet = ''
endif

if !exists('g:Cha_Para_Pre_Bullet')
	let g:Cha_Para_Pre_Bullet = ''
endif

 "}}}3
" sublist character "{{{3

if !exists('g:Cha_SubList_Pre_Bullet')
	let g:Cha_SubList_Pre_Bullet = ''
endif

if !exists('g:Cha_SubList_Post_Bullet')
	let g:Cha_SubList_Post_Bullet = ''
endif

if !exists('g:Cha_SubPara_Pre_Bullet')
	let g:Cha_SubPara_Pre_Bullet = ''
endif

 "}}}3
" list pattern "{{{3

if !exists('g:Pat_List_Pre_Bullet')
	let g:Pat_List_Pre_Bullet = ''
endif

if !exists('g:Pat_List_Post_Bullet')
	let g:Pat_List_Post_Bullet = ''
endif

if !exists('g:Pat_Para_Pre_Bullet')
	let g:Pat_Para_Pre_Bullet = ''
endif

if !exists('g:Pat_Para_Post_Bullet')
	let g:Pat_Para_Post_Bullet = ''
endif

 "}}}3
" sublist pattern "{{{3

if !exists('g:Pat_SubList_Pre_Bullet')
	let g:Pat_SubList_Pre_Bullet = ''
endif

if !exists('g:Pat_SubList_Post_Bullet')
	let g:Pat_SubList_Post_Bullet = ''
endif

if !exists('g:Pat_SubPara_Pre_Bullet')
	let g:Pat_SubPara_Pre_Bullet = ''
endif

if !exists('g:Pat_SubPara_Post_Bullet')
	let g:Pat_SubPara_Post_Bullet = ''
endif

 "}}}3
" text width "{{{3

if !exists('g:TextWidth_Bullet')
	let g:TextWidth_Bullet = ''
endif

 "}}}3
" format options "{{{3

if !exists('g:FormatOptions_Overwrite_Bullet')
	let g:FormatOptions_Overwrite_Bullet = ''
endif

if !exists('g:FormatOptions_Add_Bullet')
	let g:FormatOptions_Add_Bullet = ''
endif

if !exists('g:FormatOptions_Substract_Bullet')
	let g:FormatOptions_Substract_Bullet = ''
endif

 "}}}3
" comments "{{{3

if !exists('g:Comments_Overwrite_Bullet')
	let g:Comments_Overwrite_Bullet = ''
endif

if !exists('g:Comments_Add_Bullet')
	let g:Comments_Add_Bullet = ''
endif

if !exists('g:Cha_ComEnd_Bullet')
	let g:Cha_ComEnd_Bullet = ''
endif

if !exists('g:Pat_ComEnd_Bullet')
	let g:Pat_ComEnd_Bullet = ''
endif

 "}}}3
" protect lines "{{{3

if !exists('g:Pat_Protect_Overwrite_Bullet')
	let g:Pat_Protect_Overwrite_Bullet = ''
endif

if !exists('g:Pat_Protect_Add_Bullet')
	let g:Pat_Protect_Add_Bullet = ''
endif

if !exists('g:Cha_Protect_Bullet')
	let g:Cha_Protect_Bullet = ''
endif

 "}}}3
" autocommands "{{{3

if !exists('g:Switch_Auto_Bullet')
	let g:Switch_Auto_Bullet = ''
endif

if !exists('g:Pat_File_Bullet')
	let g:Pat_File_Bullet = ''
endif

 "}}}3
" load space#DelSpace_Trail() "{{{3

if !exists('g:Switch_NotDelSpace_Bullet')
	let g:Switch_NotDelSpace_Bullet = ''
endif

 "}}}3
" placeholder "{{{3

if !exists('g:Cha_Mark_Bullet')
	let g:Cha_Mark_Bullet = ''
endif

 "}}}3
 "}}}2
" function "{{{2

" parts "{{{3

function s:LoadBullets() "{{{4

	" list character, pre
	if g:Cha_List_Pre_Bullet != ''
		let s:Cha_List_Pre = g:Cha_List_Pre_Bullet
	else
		let s:Cha_List_Pre = '='
	endif

	" list character, after
	if g:Cha_List_Post_Bullet != ''
		let s:Cha_List_Post =
		\ g:Cha_List_Post_Bullet
	else
		let s:Cha_List_Post = '*'
	endif

	" para character, pre
	if g:Cha_Para_Pre_Bullet != ''
		let s:Cha_Para_Pre = g:Cha_Para_Pre_Bullet
	else
		let s:Cha_Para_Pre = '-'
	endif

	" sub-list character, pre
	if g:Cha_SubList_Pre_Bullet != ''
		let s:Cha_SubList_Pre =
		\ g:Cha_SubList_Pre_Bullet
	else
		let s:Cha_SubList_Pre = '=='
	endif

	" sub-list character, after
	if g:Cha_SubList_Post_Bullet != ''
		let s:Cha_SubList_Post =
		\ g:Cha_SubList_Post_Bullet
	else
		let s:Cha_SubList_Post = '+'
	endif

	" sub-para character, pre
	if g:Cha_SubPara_Pre_Bullet != ''
		let s:Cha_SubPara_Pre =
		\ g:Cha_SubPara_Pre_Bullet
	else
		let s:Cha_SubPara_Pre = '--'
	endif

	" list pattern, pre
	if g:Pat_List_Pre_Bullet != ''
		let s:Pat_List_Pre = g:Pat_List_Pre_Bullet
	else
		let s:Pat_List_Pre = '^\s*=\(=\)\@!\s*'
	endif

	" list pattern, after
	if g:Pat_List_Post_Bullet != ''
		let s:Pat_List_Post =
		\ g:Pat_List_Post_Bullet
	else
		let s:Pat_List_Post = '\t*\t'
	endif

	" para pattern, pre
	if g:Pat_Para_Pre_Bullet != ''
		let s:Pat_Para_Pre = g:Pat_Para_Pre_Bullet
	else
		let s:Pat_Para_Pre = '^\s*-\(-\)\@!\s*'
	endif

	" para pattern, after
	if g:Pat_Para_Post_Bullet != ''
		let s:Pat_Para_Post =
		\ g:Pat_Para_Post_Bullet
	else
		let s:Pat_Para_Post = '\t\t'
	endif

	" sub-list pattern, pre
	if g:Pat_SubList_Pre_Bullet != ''
		let s:Pat_SubList_Pre =
		\ g:Pat_SubList_Pre_Bullet
	else
		let s:Pat_SubList_Pre =
		\ '^\s*==\(=\)\@!\s*'
	endif

	" sub-list pattern, after
	if g:Pat_SubList_Post_Bullet != ''
		let s:Pat_SubList_Post =
		\ g:Pat_SubList_Post_Bullet
	else
		let s:Pat_SubList_Post = '\t\t+\t'
	endif

	" sub-para pattern, pre
	if g:Pat_SubPara_Pre_Bullet != ''
		let s:Pat_SubPara_Pre =
		\ g:Pat_SubPara_Pre_Bullet
	else
		let s:Pat_SubPara_Pre =
		\ '^\s*--\(-\)\@!\s*'
	endif

	" sub-para pattern, after
	if g:Pat_SubPara_Post_Bullet != ''
		let s:Pat_SubPara_Post =
		\ g:Pat_SubPara_Post_Bullet
	else
		let s:Pat_SubPara_Post = '\t\t\t'
	endif

	let s:Pat_Search =
	\ s:Pat_List_Pre . '\|' .
	\ s:Pat_Para_Pre . '\|' .
	\ s:Pat_SubList_Pre . '\|' .
	\ s:Pat_SubPara_Pre

endfunction "}}}4

function s:LoadStrings() "{{{4

	" comment end character
	if g:Cha_ComEnd_Bullet != ''
		let s:Cha_ComEnd = g:Cha_ComEnd_Bullet
	else
		let s:Cha_ComEnd = '/'
	endif

	" comment end pattern
	if g:Pat_ComEnd_Bullet != ''
		let s:Pat_ComEnd = g:Pat_ComEnd_Bullet
	else
		let s:Pat_ComEnd = '\s*\/\s*'
	endif

	" protection characters
	" such characters will appear in comments
	" as well
	if g:Cha_Protect_Bullet != ''
		let s:Cha_Protect =
		\ g:Cha_Protect_Bullet
	else
		let s:Cha_Protect = '@'
	endif

	" protection patterns
	if g:Pat_Protect_Overwrite_Bullet != ''

		let s:Pat_Protect_Final =
		\ g:Pat_Protect_Overwrite_Bullet .
		\ g:Pat_Protect_Add_Bullet

	else

		let s:Pat_Protect_Origin = '\(\({\{3}'
		let s:Pat_Protect_Origin .=  '\|}\{3}\)'
		let s:Pat_Protect_Origin .= '\d\{0,2}$\)'

		let s:Pat_Protect_Final =
		\ s:Pat_Protect_Origin .
		\ g:Pat_Protect_Add_Bullet

	endif

	" load space#DelSpace_Trail()
	if g:Switch_NotDelSpace_Bullet > 0
		let s:Switch_NotDelSpace = 1
	else
		let s:Switch_NotDelSpace = 0
	endif

	" place holder mark
	if g:Cha_Mark_Bullet != ''
		let s:Cha_Mark = g:Cha_Mark_Bullet
	else
		let s:Cha_Mark =
		\ '###LONG_PLACEHOLDER_FOR_BULLET###'
	endif

endfunction "}}}4

function s:LoadSettings(when) "{{{4

	" load settings
	if a:when == 0

		let s:TextWidth_Save = &textwidth
		let s:FormatOptions_Save = &formatoptions
		let s:Comments_Save = &comments

		" textwidth
		if g:TextWidth_Bullet > 0
			let &l:textwidth = g:TextWidth_Bullet
		endif

		" formatoptions, overwrite
		if g:FormatOptions_Overwrite_Bullet != ''
			let &l:formatoptions =
			\ g:FormatOptions_Overwrite_Bullet
		else
			let &l:formatoptions = 'tcqro2mB1j'
		endif

		" formatoptions, add
		let &l:formatoptions .=
		\ g:FormatOptions_Add_Bullet

		" formatoptions, substract
		let &l:formatoptions =
		\ substitute(&l:formatoptions,
		\ g:FormatOptions_Substract_Bullet,'','g')

		" comments
		" overwrite comment setting
		if g:Comments_Overwrite_Bullet != ''
			let &l:comments =
			\ g:Comments_Overwrite_Bullet

		else

			setl comments=

			" sublist characters, pre
			let &l:comments .=
			\ 's:' . s:Cha_SubList_Pre .
			\ ',m:' . s:Cha_SubPara_Pre.
			\ ',ex:' . s:Cha_ComEnd

			" list characters, pre
			let &l:comments .=
			\ ',s:' . s:Cha_List_Pre .
			\ ',m:' . s:Cha_Para_Pre .
			\ ',ex:' . s:Cha_ComEnd

			" sublist characters, after
			let &l:comments .=
			\ ',f:' . s:Cha_SubList_Post

			" list characters, after
			let &l:comments .=
			\ ',f:' . s:Cha_List_Post

			" protect characters
			let &l:comments .=
			\ ',s:' . s:Cha_Protect .
			\ ',m:' . s:Cha_Protect .
			\ ',ex:' . s:Cha_Protect

		endif

		" add new comments
		let &l:comments .= ',' .
		\ g:Comments_Add_Bullet

	endif

	" unload settings
	if a:when == 1

		" textwidth
		let &l:textwidth = s:TextWidth_Save

		" formatoptions
		let &l:formatoptions =
		\ s:FormatOptions_Save

		" comments
		let &l:comments = s:Comments_Save

	endif

endfunction "}}}4

function s:LoadAll_Bul_Str_Set(when) "{{{4

	call <sid>LoadBullets()
	call <sid>LoadStrings()
	call <sid>LoadSettings(a:when)

endfunction "}}}4

function s:DelSpace() "{{{4

	" delete trailing blank characters: tabs,
	" half-width spaces and full-width spaces
	" NOTE: cursor position must be set first!
	call space#DelSpace_Trail()
	call move_cursor#KeepPos(1)

endfunction "}}}4

function s:DelBullet(when) "{{{4

	" suppose '=' will be replaced with bullet '*'
	" delete lines containing only such characters
	" '^\s*=\s*$' or '^\s*\/\s*$'
	" '/' appears in a three-piece comment
	" which is defined in s:LoadStrings()
	" :help format-comments

	if a:when == 0

		" only bullet
		execute "'j,'ks/\\(" .
		\ s:Pat_Search . '\)\(' .
		\ s:Pat_ComEnd . '\|\s*\)$/' .
		\ s:Cha_Mark . '/e'

		" only s:Pat_ComEnd
		execute "'j,'ks/^" . s:Pat_ComEnd . '$/'
		\ s:Cha_Mark . '/e'

		" s:Pat_ComEnd at the end of line
		let l:pattern = '\(' . s:Pat_Search .
		\ '\).*' . s:Pat_ComEnd . '$'
		'j
		if search(l:pattern,'c',line("'k")) != 0
			execute "'j,'kg/" . s:Pat_Search .
			\ '/s/' . s:Pat_ComEnd . '$//'
		endif

	endif

	" delete marked lines after substitution
	" in case line 'j/'k contains mark
	if a:when == 1
		'j
		if search(s:Cha_Mark,'c',line("'k")) != 0
			execute "'j,'kg/" . s:Cha_Mark .
			\ '/delete'
		endif
	endif

endfunction "}}}4

function s:SubsBullet_Core() "{{{4

	" list
	" substitute '=' with '*' and indent 1 tab
	" substitute '-' with '' and indent 1 tab
	execute "'j,'ks/" .
	\ s:Pat_List_Pre .  '/' .
	\ s:Pat_List_Post . '/e'
	execute "'j,'ks/" .
	\ s:Pat_Para_Pre . '/' .
	\ s:Pat_Para_Post . '/e'

	" sub list
	" substitute '==' with '+' and indent 2 tabs
	" substitute '--' with '' and indent 2 tabs
	execute "'j,'ks/" .
	\ s:Pat_SubList_Pre . '/' .
	\ s:Pat_SubList_Post . '/e'
	execute "'j,'ks/" .
	\ s:Pat_SubPara_Pre . '/' .
	\ s:Pat_SubPara_Post . '/e'

endfunction "}}}4

function s:AutoCommand() "{{{4

	if g:Switch_Auto_Bullet <= 0 ||
	\ g:Pat_File_Bullet == ''
		return
	else
		execute 'autocmd BufRead,BufNewFile ' .
		\ g:Pat_File_Bullet .
		\ " call <sid>LoadAll_Bul_Str_Set(0)"
	endif

endfunction "}}}4

function s:EchoVars(name) "{{{4

	echo a:name . " == '" . eval(a:name) . "'"

endfunction "}}}4

 "}}}3
" main "{{{3

function s:SubsBullet_NoTW(range) "{{{4

	call move_cursor#KeepPos(0)
	call <sid>LoadAll_Bul_Str_Set(0)
	call <sid>LoadAll_Bul_Str_Set(1)

	if s:Switch_NotDelSpace == 0
		call <sid>DelSpace()
	endif

	" set mark j & k
	" paragraph
	if a:range == 0
		call move_cursor#SetMarkJK_Para()
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

endfunction "}}}4

function s:SubsBullet_TW(range) "{{{4

	call move_cursor#KeepPos(0)
	call <sid>LoadAll_Bul_Str_Set(0)

	if s:Switch_NotDelSpace == 0
		call <sid>DelSpace()
	endif

	let l:i = 0

	while 1

		" set mark j & k
		" paragraph
		if a:range == 0
			call move_cursor#SetMarkJK_Para()
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
		call move_cursor#SetMarkJK_Para()
	elseif a:range == 1
		1mark j
		$mark k
	endif
	execute "'j,'ks/^" . s:Cha_Protect . '//e'

	" unload settings
	call <sid>LoadAll_Bul_Str_Set(1)
	" reset cursor position
	call move_cursor#KeepPos(1)

endfunction "}}}4

function s:EchoSettings() "{{{4

	call <sid>LoadAll_Bul_Str_Set(0)

	let l:format = "&formatoptions == '"
	let l:options = &formatoptions

	let l:text = "&textwidth == '"
	let l:width = &textwidth

	let l:com = "&comments == '"
	let l:ments = &comments

	" NOTE: Reload default settings before echoing
	" lines.

	" If the number of lines to be echohed are
	" greater than the screen height, and user
	" break the 'echo function' half-way,

	" Vim will not process the unechoed part.

	" Such as lines to be echoed and functions to
	" be called.

	call <sid>LoadAll_Bul_Str_Set(1)

	let l:auto =  'Auto load bullet settings: '
	if g:Switch_Auto_Bullet > 0
	\ && g:Pat_File_Bullet != ''
		let l:command = 'ON'
	else
		let l:command = 'OFF'
	endif

	let l:del = 'Delete trailing spaces: '
	if s:Switch_NotDelSpace == 0
		let l:space = 'Yes'
	elseif s:Switch_NotDelSpace == 1
		let l:space = 'No'
	endif

	echo '=============================='

	echo l:format . l:options . "'"
	echo '------------------------------'
	call <sid>EchoVars(
	\'g:FormatOptions_Overwrite_Bullet')
	call <sid>EchoVars(
	\'g:FormatOptions_Add_Bullet')
	call <sid>EchoVars(
	\'g:FormatOptions_Substract_Bullet')
	echo '=============================='

	echo l:text . l:width . "'"
	echo '------------------------------'
	call <sid>EchoVars('g:TextWidth_Bullet')
	echo '=============================='

	echo l:com . l:ments . "'"
	echo '------------------------------'
	call <sid>EchoVars(
	\'g:Comments_Overwrite_Bullet')
	call <sid>EchoVars('g:Comments_Add_Bullet')
	echo '=============================='

	call <sid>EchoVars('&tabstop')
	call <sid>EchoVars('&softtabstop')
	call <sid>EchoVars('&shiftwidth')
	call <sid>EchoVars('&expandtab')
	echo '=============================='

	call <sid>EchoVars('s:Pat_Search')
	echo '=============================='

	call <sid>EchoVars('s:Cha_ComEnd')
	echo '------------------------------'
	call <sid>EchoVars('g:Cha_ComEnd_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Pat_ComEnd')
	echo '------------------------------'
	call <sid>EchoVars('g:Pat_ComEnd_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Cha_Mark')
	echo '------------------------------'
	call <sid>EchoVars('g:Cha_Mark_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Cha_Protect')
	echo '------------------------------'
	call <sid>EchoVars('g:Cha_Protect_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Pat_Protect_Final')
	echo '------------------------------'
	call <sid>EchoVars(
	\'g:Pat_Protect_Overwrite_Bullet')
	call <sid>EchoVars(
	\'g:Pat_Protect_Add_Bullet')
	echo '=============================='

	echo l:del . l:space
	echo '------------------------------'
	call <sid>EchoVars(
	\'g:Switch_NotDelSpace_Bullet')
	echo '=============================='

	echo l:auto . l:command
	echo '------------------------------'
	call <sid>EchoVars('g:Switch_Auto_Bullet')
	call <sid>EchoVars('g:Pat_File_Bullet')
	echo '=============================='

endfunction "}}}4

function s:EchoBullets() "{{{4

	call <sid>LoadAll_Bul_Str_Set(0)
	call <sid>LoadAll_Bul_Str_Set(1)

	echo '=============================='

	call <sid>EchoVars('s:Cha_List_Pre')
	call <sid>EchoVars('s:Cha_List_Post')
	call <sid>EchoVars('s:Cha_Para_Pre')
	echo '------------------------------'
	call <sid>EchoVars('g:Cha_List_Pre_Bullet')
	call <sid>EchoVars('g:Cha_List_Post_Bullet')
	call <sid>EchoVars('g:Cha_Para_Pre_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Pat_List_Pre')
	call <sid>EchoVars('s:Pat_List_Post')
	call <sid>EchoVars('s:Pat_Para_Pre')
	call <sid>EchoVars('s:Pat_Para_Post')
	echo '------------------------------'
	call <sid>EchoVars('g:Pat_List_Pre_Bullet')
	call <sid>EchoVars('g:Pat_List_Post_Bullet')
	call <sid>EchoVars('g:Pat_Para_Pre_Bullet')
	call <sid>EchoVars('g:Pat_Para_Post_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Cha_SubList_Pre')
	call <sid>EchoVars('s:Cha_SubList_Post')
	call <sid>EchoVars('s:Cha_SubPara_Pre')
	echo '------------------------------'
	call <sid>EchoVars('g:Cha_SubList_Pre_Bullet')
	call <sid>EchoVars(
	\'g:Cha_SubList_Post_Bullet')
	call <sid>EchoVars('g:Cha_SubPara_Pre_Bullet')
	echo '=============================='

	call <sid>EchoVars('s:Pat_SubList_Pre')
	call <sid>EchoVars('s:Pat_SubList_Post')
	call <sid>EchoVars('s:Pat_SubPara_Pre')
	call <sid>EchoVars('s:Pat_SubPara_Post')
	echo '------------------------------'
	call <sid>EchoVars('g:Pat_SubList_Pre_Bullet')
	call <sid>EchoVars(
	\'g:Pat_SubList_Post_Bullet')
	call <sid>EchoVars('g:Pat_SubPara_Pre_Bullet')
	call <sid>EchoVars(
	\'g:Pat_SubPara_Post_Bullet')
	echo '=============================='

endfunction "}}}4

 "}}}3
 "}}}2
" commands "{{{2

autocmd VimEnter * call <sid>AutoCommand()

if !exists(':BuPara0TW')
	command BuPara0TW call <sid>SubsBullet_TW(0)
endif

if !exists(':BuPara1NoTW')
	command BuPara1NoTW
	\ call <sid>SubsBullet_NoTW(0)
endif

if !exists(':BuWhole0TW')
	command BuWhole0TW call <sid>SubsBullet_TW(1)
endif

if !exists(':BuWhole1NoTW')
	command BuWhole1NoTW
	\ call <sid>SubsBullet_NoTW(1)
endif

if !exists(':BuEcho0Set')
	command BuEcho0Set call <sid>EchoSettings()
endif

if !exists(':BuEcho1Bullet')
	command BuEcho1Bullet call <sid>EchoBullets()
endif

 "}}}2
" cpotions "{{{2

let &cpoptions = s:Save_cpo
unlet s:Save_cpo

 "}}}2
" vim: set fdm=marker fdl=20 tw=50: "}}}1
