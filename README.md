License: GPL v2

## Usage

substitute characters with bullet points and indent paragraphs

continous spaces and tabs before pre-defined characters are ignored

change characters and bullets ('=' and '-', '*' and '+') as you like

## Before
 
	=List 1
	-Paragraph 1
	
	=List 2
	
	==SubList 1
	--SubParagraph 1
	
## After

	*	List 1
		Paragraph 1

	*	List 2

			+	Sublist 1
				Subparagraph 1

## Default key mapping

type `<`alt-b`>` in Normal mode or Visual mode

when in Normal mode, you have to set marks first:

begin <-- mark j

...

end <-- mark k

## Customize

substitute ### with your own setting in the .vimrc

leave the rest part unchanged

### key binding

" nmap <unique> <silent> ### <plug>BulletNormal

" vmap <unique> <silent> ### <plug>BulletVisual

### list characters

" let g:ListBefore_Bullet = '###'

" let g:ListAfter_Bullet = '###'

" let g:ParaBefore_Bullet = '###'

" let g:ParaAfter_Bullet = '###'

" let g:SubListBefore_Bullet = '###'

" let g:SubListAfter_Bullet = '###'

" let g:SubParaBefore_Bullet = '###'

" let g:SubParaAfter_Bullet = '###'
