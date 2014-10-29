User manual for bullet.vim {{{1

Time recording {{{2

	Start writing: Oct 23 | Thu | 2014

	End writing:

	Time spent: 0.5 hours

 }}}2
Text {{{2

Note for Newbies {{{3

Introduction {{{4

	"bullet.vim" is a global plugin which can
	substitute pre-defined characters into bullets
	and format text if required.

	There are six new commands to change the text
	and over twenty global variables to tweak the
	plugin.

		+	BuPara0TW
		+	BuPara1NoTW

		+	BuWhole0TW
		+	BuWhole1NoTW

		+	BuEcho0Set
		+	BuEcho1Bullet

	You can read the simplified Chinese version
	[here](http://trow.cc/forum/index.php?showtopic=27171).

 }}}4
Copy files {{{4

	You need three files for this plugin to run.

	Copy
	[bullet.vim](https://github.com/Bozar/bullet)
	and put it into ~/.vim/plugin/.

	If the directory ~/.vim/autoload/ doesn't
	exist, creat it.

	Copy
	[move_cursor.vim](https://github.com/Bozar/movecursor)
	and
	[space.vim](https://github.com/Bozar/space)
	and put them into ~/.vim/autoload/.

 }}}4
Your first command {{{4

	Restart Vim.  If there are no errors, then you
	have been well ready for the test drive.

	Copy the following text and put it into
	a blank file.

		(==Origin Text==)

	Set "textwidth" first:

		setl textwidth=50

	And then type this command (auto completion
	will do you a favor):

		BuWhole0TW

	If the new text looks like this, it means
	everything has been properly set.

		(==Formatted Text==)

	Sit back and read on.  Mr. Kite's show will
	start in no time.  :)

 }}}4
 }}}3
Handbook for Hitchhikers {{{3

Two steps, and three more commands {{{4

	Step one.  As mentioned above, you have to
	insert pre-defined characters so that the
	plugin can find and replace them.  There are
	four pre-defined characters and two bullets.
	The last special character inserted by user
	(comment-end character "/") will be explained
	later.

	List and paragraph, before substitution:

		@=This is a list.

		@-This is a paragraph.

	List and paragraph, after substitution:

		@*	This is a list.

		@	This is a paragraph.

	Sub-list and sub-paragraph, before
	substitution:

		@==This is a sub-list.

		@--This is a sub-paragraph.

	Sub-list and sub-paragraph, after
	substitution:

			@+	This is a sub-list.

			@	This is a sub-paragraph.

	Blank characters (spaces and tabs) before and
	after pre-defined characters will be deleted.
	Tabs are used for indention after
	substitution.

	All these characters mentioned above can be
	set to your own value (see "Guide for Geeks",
	below).  The plugin will do some more
	substitutions in order to (hopefully) avoid
	unexpected behaviors.  But for now, you don't
	need to care about that.

	Step two.  The plugin provides you with six
	commands.  Four of them substitute characters
	and format text.  The rest two echo
	plugin-related varibles.  Let's focus on the
	"editing" commands first.

	The four "editing" commands fall into two
	groups according to substitution range: inside
	a paragraph or around the whole text.  Type
	"bup" or "buw" in command-line mode, and then
	press tab key to auto-complete the command.
	You will see two options, in which "TW" stands
	for "text width".

		+	BuPara0TW
		+	BuPara1NoTW

		+	BuWhole0TW
		+	BuWhole1NoTW

	A paragraph is a block of text seperated by
	empty lines, which containg no characters
	(even blank ones) at all, at the beginning and
	end of the block.

		+	h paragraph

	"BuPara1NoTW" will only substitute pre-defined
	characters inside the paragraph where the
	cursor stays.  So it is strongly recommend to
	move cursor into the paragraph you want to
	edit, or the blank lines below it, not the
	blank lines above it, in which case the
	previous paragraph will be edited.

	In addition to substitute characters inside
	a paragraph, "BuPara1NoTW" will also delete
	some specific blank characters in the whole
	text: spaces between two CJK characters,
	spaces between CJK punctuation mark and
	western character, continous blank characters
	(spaces and/or tabs) at the end of line.  All
	three deletions can be turned off by setting
	global variables (see "Guide for Geeks",
	below).

	"BuPara0TW" will do one more thing besides
	substitution and deletion.  It will format the
	paragraph.

		+	h gq

	If global variable "g:TextWidth_Bullet" is not
	set, buffer local option "textwidth" is used
	instead.

	Please note that even when there are no
	pre-defined characters inside a paragraph,
	"BuPara1NoTW" will still delete spaces, and
	"BuPara0TW" will delete spaces and format
	paragraph.

	The "buw" commands do the same thing as their
	"bup" counterparts, except that substitution
	and format affect the whole text.

	Following these two steps, you can easily
	insert bullets and format text.  Now let's see
	how to use two "echoing" commands to list
	variables and use autocommand to load settings
	for specific files.

		+	BuEcho0Set
		+	BuEcho1Bullet

	"BuEcho1Bullet" lists characters and search
	patterns before/after susbsitution.  These
	variables affect all four "editing" commands
	above.

	"BuEcho0Set" lists settings and special
	characters.  Most of them are only related to
	"BuPara0TW" and "BuWhole0TW".

	There are three options which affect the
	format behavior ("BuEcho0Set" can show the
	default values for you):

		+	formatoptions
		+	textwidth
		+	comments

	If you want to auto-load these options when
	reading old files or creating new ones, add
	such lines into your .vimrc:

		+	let g:Switch_Auto_Bullet = 1
		+	let g:Pat_File_Bullet = '*.write'
		+	let g:Pat_File_Bullet .= ',*.read'

	See Vim help file for more imformation.

		+	h formatoptions
		+	h fo-table
		+	h textwidth
		+	h comments
		+	h :autocmd
		+	h :let.=

	Auto load will not work unless
	"g:Switch_Auto_Bullet" is set to a positive
	value and "g:Pat_File_Bullet" is not blank.
	Type "BuEcho0Set", then scroll to the bottom.
	If "Auto load bullet settings:" says "YES",
	you have done things right.

 }}}4
If something goes wrong... {{{4

	Don't panic, of course. Here are some
	suggestions for you if there are more
	characters deleted than expected, or lines
	shouldn't be joined become one paragraph.

	Narrow the range.  Try "paragraph" commands
	first, then put several paragraphs into
	a blank buffer and use "whole text" commands
	to see if things happend as expected.

	Beware of pre-defined characters.  Lines
	beginning with zero or more blank characters
	and following such characters ("=", "-", "=="
	and "--") will be processed (substituted into
	bullets or nothing, depending on whether there
	are other non-blank characters after such
	pre-defined ones).

	Define protection lines.  Every line longer
	than textwidth will be broken into shorter
	ones when formatting.  Every line shorter than
	textwidth will join with other lines when
	formatting, excluding lines containing
	foldmarkers.  You can define your own
	protection lines, that is, lines you don't
	want to have them joined, by setting
	"g:Pat_Protect_Add_Bullet" and
	"g:Pat_Protect_Overwrite_Bullet".  See more
	details below.

	To delete spaces or not.  As mentioned in Step
	two, three kinds of "spaces" will be deleted
	(substituted into nothing).

 }}}4
 }}}3
Guide for Geeks {{{3

customize this plugin

	*	learn regular expression
	*	read Vim user manual

	*	what does 'default setting' mean?

	*	change bullet character/patttern

	*	formatoptions, textwidth and comments
	*	tabstop
	*	comment end
	*	mark
	*	protection

 }}}3
 }}}2
 }}}1
