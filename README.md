* User manual for bullet.vim

** Text

*** Note for Newbies

**** Introduction

"bullet.vim" is a global plugin which can substitute pre-defined characters into bullets and format text if required.

There are six new commands to change the text and over twenty global variables to tweak the plugin.

	+	BuPara0TW
	+	BuPara1NoTW

	+	BuWhole0TW
	+	BuWhole1NoTW

	+	BuEcho0Set
	+	BuEcho1Bullet

You can read the simplified Chinese version [here](http://trow.cc/forum/index.php?showtopic=27171).

**** Installation

This plugin requires three files to run.

Please creat the following two directories if they don't exist.

Download [bullet.vim](https://github.com/Bozar/bullet) and put it into ~/.vim/plugin/.

Download [move_cursor.vim](https://github.com/Bozar/movecursor) and [space.vim](https://github.com/Bozar/space) and put them into ~/.vim/autoload/.

**** Your first command

Restart Vim.  If there are no errors, you have been well ready for the test drive.

Copy the following text and put it into a blank file.

	(==Origin Text==)

Set "textwidth" first:

	+	setl textwidth=50

And then type this command (auto completion will do you a favor):

	+	BuWhole0TW

If the new text looks like this, it means everything has been properly set.

	(==Formatted Text==)

Sit back and read on.  Mr. Kite's show will start in no time.  :)

*** Handbook for Hitchhikers

**** Two steps, and three more commands

Step one.  As mentioned above, you have to insert pre-defined characters so that the plugin can find and replace them.  There are four pre-defined characters and two bullets.  The last special character inserted by user (comment-end character "/") will be explained later.

List and paragraph, before substitution:

	+	=This is a list.
	+	-This is a paragraph.

List and paragraph, after substitution:

	+	*	This is a list.
	+		This is a paragraph.

Sub-list and sub-paragraph, before substitution:

	+	==This is a sub-list.
	+	--This is a sub-paragraph.

Sub-list and sub-paragraph, after substitution:

	+		+	This is a sub-list.
	+			This is a sub-paragraph.

Blank characters (spaces and tabs) before and after pre-defined characters will be deleted.  Tabs are used for indention after substitution.

All these characters mentioned above can be set to your own value.  Besides, the plugin will do some more substitutions in order to (hopefully) avoid unexpected behaviors (see "Guide for Geeks", below).

Step two.  The plugin provides you with six commands.  Four of them substitute characters and format text.  The rest two echo plugin-related variables.  Let's focus on the "editing" commands first.

The four "editing" commands fall into two groups, according to substitution range: inside a paragraph or around the whole text.  Type "BuP" or "BuW" in command-line mode (they are not case-sensitive), and then press tab key to auto-complete the command.  You will see two options, in which "TW" stands for "text width".

	+	BuPara0TW
	+	BuPara1NoTW

	+	BuWhole0TW
	+	BuWhole1NoTW

A paragraph is a block of text seperated by empty lines, which containg no characters (even blank ones) at all, at the beginning and end of the block.

	+	h paragraph

"BuPara1NoTW" will only substitute pre-defined characters inside the paragraph where the cursor stays.  So it is strongly recommend to move cursor into the paragraph you want to edit, or the blank lines below it, not the blank lines above it, in which case the previous paragraph will be edited instead.

"BuPara1NoTW" will also delete three kinds of blank characters in the whole text:

*	spaces between two CJK characters
*	spaces between CJK punctuation mark and western character
*	continous blank characters (spaces and/or tabs) at the end of line

All these deletions can be turned off by setting global variables (see "Guide for Geeks", below).

"BuPara0TW" will do one more thing besides substitution and deletion.  It will format the paragraph.

	+	h gq

If global variable "g:TextWidth_Bullet" is not set, Vim option "textwidth" is used instead.

Please note that even when there are no pre-defined characters inside a paragraph, "BuPara1NoTW" will still delete spaces, and "BuPara0TW" will delete spaces and format paragraph.

The "BuW" commands do the same thing as their "BuP" counterparts, except that substitution and format affect the whole text.

Following these two steps, you can easily insert bullets and format text.  Now let's see how to use two "echoing" commands to list variables and autocommand to load settings for specific files.

	+	BuEcho0Set
	+	BuEcho1Bullet

"BuEcho1Bullet" lists characters and search patterns before/after susbsitution.  These variables affect all four "editing" commands above.

"BuEcho0Set" lists settings and special characters.  Most of them are only related to "BuPara0TW" and "BuWhole0TW".

There are three options which affect the format behavior ("BuEcho0Set" can show the default values for you):

	+	formatoptions
	+	textwidth
	+	comments

If you want to auto-load these options when reading old files or creating new ones, add such lines into your .vimrc:

	+	" enable autocommand
	+	let g:Switch_Auto_Bullet = 1

	+	" load settings for files with suffix .read/write
	+	let g:Pat_File_Bullet = ',*.read'
	+	let g:Pat_File_Bullet .= '*.write'

See Vim help file for more imformation.

	+	h formatoptions
	+	h fo-table
	+	h textwidth
	+	h comments
	+	h :autocmd
	+	h :let.=

Auto load will not work unless "g:Switch_Auto_Bullet" is set to a positive value and "g:Pat_File_Bullet" is not empty.  Type "BuEcho0Set", then scroll to the bottom.  If "Auto load bullet settings:" says "YES", you have done things right.

**** If something goes wrong...

Don't panic, of course. Here are some suggestions for you if there are more characters being deleted than expected, or lines shouldn't be joined become one paragraph.

Narrow the range.  Try "BuP" commands first, then put several paragraphs into a blank buffer and use "BuW" commands to see if things happend as expected.

Beware of pre-defined characters.  Lines beginning with zero or more blank characters and following such characters ("=", "-", "==" and "--") will be substituted into bullets or nothing, depending on whether there are other non-blank characters after such pre-defined ones (see "Guide for Geeks", below).

Define protection lines.  When formatting, every line longer than textwidth will be broken into shorter ones; every line shorter than textwidth will join with other lines , excluding lines containing foldmarkers.  You can define your own protection lines, that is, lines you don't want to have them joined, by setting "g:Pat_Protect_Add_Bullet" and "g:Pat_Protect_Overwrite_Bullet".  See more details below.

	+	h 'foldmarker'

To delete spaces or not.  As mentioned in Step two, three kinds of "spaces" will be deleted (substituted into nothing).  You can tell the plugin not to do extra deletions.

Re-join lines.  If you want to un-format text, that is, to join all lines in a paragraph into one, try this trick.

	+	let g:TextWidth_Bullet = 9999
	+	BuWhole0TW

*** Guide for Geeks

**** Things you should know first...

I assume that you have learnt the ABCs of regular expressions.  And don't forget to read those help documents mentioned above.

**** "BuP" and "BuW" commands

***** Summary

Here are two brief summaries of editing process.  More details will be explained in the "BuEcho0Set" and "BuEcho1Bullet" section.

***** "NoTW" commands

"BuPara1NoTW" and "BuWhole1NoTW" substitute pre-defined characters into bullets.

*	Load script variables

	+	Vim option: formatoptions
	+	Vim option: textwidth
	+	Vim option: comments

	+	Bullet characters/patterns
	+	Comment end character/pattern
	+	Hold position mark
	+	Line protection mark

*	Reset Vim options to their previous value

*	Delete continous spaces and/or tabs at the end of line

*	Set mark j and k around the paragraph or whole text

*	Mark lines that will be deleted

*	Substitute pre-defined characters into bullets

*	Delete marked lines

*	Delete spaces between two CJK characters

*	Delete spaces between CJK punctuation mark and Western character

***** "TW" commands

"BuPara0TW" and "BuWhole0TW" format text after substitution.

*	Load script variables

*	Do NOT reset Vim options to their previous value yet

*	Substitute pre-defined characters into bullets, just as in "NoTW" commands

*	Protect lines that should not be formatted (insert protection mark in the beginning of line)

*	Format text

*	Unprotect lines (delete protection mark)

*	Reset Vim options to their previous value

**** Variables listed by "echoing" commands

You can browse variables and settings by using two "echoing" commands:

	+	BuEcho0Set
	+	BuEcho1Bullet

There are four kinds of "variables":

*	Vim options (number/string)
*	script options (boolean)
*	script variables (number/string)
*	global variables (number/string)

	+	h s:var
	+	h g:var

You can set Vim options and global variables in .vimrc or before inputing commands.

Some global variables have similar functions as Vim options.  When both of them are set, the plugin will use global variables rather than Vim options.

	+	" global variable
	+	let g:TextWidth_Bullet = 50

	+	" Vim option
	+	let &textwidth = 72

When using "BuPara0TW" to format text, the textwidth will be 50.

The plugin only use Vim options and script variables to process text.  When global variables are empty, script variables have their default values.  So if you screw up with some settings, it could be useful to re-set global variables to empty values.

	+	let g:TextWidth_Bullet = ''

Global variables from bullet.vim plugin end with "_Bullet".  They also have four kinds of "prefixes" for you to recognize them.

"Cha_" means character. There are no regular expressions in such variables.

"Pat_" means pattern. These variables contain both characters and regular expressions.

"Switch_" variables turn on/off some boolean settings.  They only accpet number as legal value.

There are four variables beginning with Vim option names, which are "formatoptions", "textwidth" and "comments".  Unless required by autocommand, they won't change Vim settings.  If these variables are not empty, they will affect the format result of "BuPara0TW" and "BuWhole0TW".

**** BuEcho1Bullet

"BuEcho1Bullet" lists all bullet characters/patterns before and after substitution.

These variables affect all four commands:

	+	BuPara0TW
	+	BuPara1NoTW

	+	BuWhole0TW
	+	BuWhole1NoTW

If you want to make some changes, both characters and patterns should be changed.  Let's see an example.

Text, before substitution:

	+	=This is a list.

Variables, before substitution:

	+	let s:Cha_List_Pre = '='
	+	let s:Pat_List_Pre =
	+	\ '^\s*=\(=\)\@!\s*'

Text, after substitution:

	+	*	This is a list.

Variables, after substitution:

	+	let s:Cha_List_Post = '*'
	+	let s:Pat_List_Post = '\t*\t'

Here is what you want:

*	Use "-" instead of "=" as pre-defined character.
*	The pre-defined character must be followed by at least one space.
*	Insert two spaces instead of one tab before and after bullet.

 Text, before substitution:

	+	- This is a list.
	+	-This is NOT a list.

Text, after substitution:

	+	*  This is a list.
	+	-This is NOT a list.

You have to set three global variables to your own value:

	+	let g:Cha_List_Pre_Bullet = '-'
	+	let g:Pat_List_Pre_Bullet = '^\s*-\s+'
	+	let g:Pat_List_Post_Bullet = '  -  '

You might have already noticed that there are six new variable "keywords".

*	_Pre
*	_Post
*	List
*	Para
*	SubList
*	SubPara

"_Pre" refers to characters/patterns before substitution.  "_Post" refers to characters/patterns after substitution.

"List" refers to lines beginning with bullets.  There could be blank characters before and/or after bullets.  "Para" refers to lines in the same paragraph with "List" lines but begin with no bullets.

"SubList" and "SubPara" have more indentions than their counterparts.

**** BuEcho0Set

***** Summary

"BuEcho0Set" lists variables that can be classified to four groups:

*	Vim options

	+	formatoptions
	+	textwidth
	+	comments
	+	tabstop
	+	comment end

*	special marks

	+	hold position mark
	+	line protection

*	delete spaces

*	autocommand

The first group (Vim options) only affects "textwidth" commands:

	+	BuPara0TW
	+	BuWhole0TW

The rest affect all four commands.

***** Vim options

There are three Vim options which will affect the "gq" behavior:

	+	formatoptions
	+	textwidth
	+	comments

You can tell the plugin to load your own settings before formatting text by setting global variables:

	+	g:FormatOptions_Overwrite_Bullet
	+	g:TextWidth_Bullet
	+	g:Comments_Overwrite_Bullet
	+	g:Comments_Add_Bullet

These options will be re-seted to their previous values after formatting.

If you want to put the formatoptions string into register @" whenever you execute any of the six commands, set the following variable to a positive value:

	+	g:Switch_FormatOptions_Put_Bullet

***** Special marks


***** Delete spaces


***** Autocommand
