"###########################################################################
"  Vim Omnicompletion Template using Python
"
"  Author: Sean Reifschneider <jafo@tummy.com>
"  2011-11-29
"  Placed into the Public Domain
"
"  Vim Omnicompletion is an extremely powerful tool, but I spent quite a
"  lot of time initially figuring out exactly how to make it happen.  Part
"  of that was due to being only somewhat familiar with the vim scripting
"  language, so I really wanted to write it in Python.
"
"  My goal with this template is to make it dead simple for a Python
"  programmer to create Omni-completion functions for vim.
"
"  To use:
"
"     * Copy this file in "~/.vim/plugins".
"
"     * Rename this file to a new name, likely called something about what
"     you are completing and "complete".  For example, the completion
"     for Python in vim is stored in a file called "pythoncomplete.vim".
"
"     * Search for "@@@" in this file and make the changes mentioned.
"
"     * Start up vim and do ":set omnifunc=YOURFILENAME#Complete" where
"     "YOURFILENAME" is the name of the file you created in step 1 above.
"
"     * Start typing something and then type Control-X Control-O to bring
"     up the completion menu.
"
"  If you've had good or bad luck wit this, please let me know!
"
"###########################################################################

"  @@@ This function needs to be named based on the current file name.
"  @@@ Change the part before the "#" to this filename.
function! montageprotocomplete#Complete(findstart, base)
python << PYTHONEOF

COMPONENTS = """
matte/ui/anchor.reel
matte/ui/button.reel
matte/ui/component-group.reel
matte/ui/dynamic-element.reel
matte/ui/image.reel
matte/ui/input-checkbox.reel
matte/ui/input-date.reel
matte/ui/input-number.reel
matte/ui/input-range.reel
matte/ui/input-text.reel
matte/ui/list.reel
matte/ui/loading-panel.reel
matte/ui/loading.reel
matte/ui/popup/alert.reel
matte/ui/popup/confirm.reel
matte/ui/popup/notifier.reel
matte/ui/popup/popup.reel
matte/ui/progress.reel
matte/ui/radio-button.reel
matte/ui/scroll-bars.reel
matte/ui/scroller.reel
matte/ui/select.reel
matte/ui/text-slider.reel
matte/ui/textarea.reel
matte/ui/toggle-button.reel
matte/ui/toggle-switch.reel
matte/ui/video-player.reel
montage/ui/condition.reel
montage/ui/flow.reel
montage/ui/label.reel
montage/ui/loader.reel
montage/ui/modal-overlay.reel
montage/ui/overlay.reel
montage/ui/repetition.reel
montage/ui/slot.reel
montage/ui/substitution.reel
montage/ui/text.reel
native/overview/ui/main.reel
native/ui/anchor.reel
native/ui/button.reel
native/ui/image.reel
native/ui/input-checkbox.reel
native/ui/input-date.reel
native/ui/input-number.reel
native/ui/input-radio.reel
native/ui/input-range.reel
native/ui/input-text.reel
native/ui/progress.reel
native/ui/select.reel
native/ui/textarea.reel
montage/core/media-controller
montage/core/promise-controller
montage/core/range-controller
montage/core/tree-controller
montage/core/undo-manager
montage/core/object-controller
"""

#  @@@ Change this to 2 if you have problems and watch syslog
#  set to values greater than 1 to get debugging information logged to syslog
debug_level = 2

import vim


#################
def debug(*args):
   '''debug(level = 1, message)
   If the "debug_level" global variable is set >= "level", then "message"
   will be logged to syslog.  If only one argument is given, it is assumed
   to be the message, but level comes first because it makes more sense that
   way.
   '''
   if len(args) == 1:
      level = 1
      msg = args[0]
   elif len(args) == 2:
      level = args[0]
      msg = args[1]
   else:
      raise ValueError('Requires arguments: [<level>], message')

   import syslog
   if level <= debug_level: syslog.syslog(msg)


#####################
def vimreturn(value):
   debug('Returning %s' % value)
   vim.command('return %s' % value)


########################################################################
def completion(word, menu = None, abbr = None, info = None, kind = None,
      dup = None, empty = None, icase = None):
   '''Helper to construct a completion item.  You must specify the "word"
   argument, which is the completion choice.  All other items are optional.

   abbr -- The abbreviation of the word, this will be used in the menu
           instead of the word, if given.
   menu -- Additional text displayed in the menu to the right of the word.
   info -- More information about the completion such as documentation
           or definition, to be shown in a preview window when selected.
   kind -- A single letter to distinguish between different classes of
           completions.
   icase -- If set to 1, upper/lowercase characters are treated as
           equivalent.  Otherwise, items only differing in case will
           each have their own menu items.
   dup -- When set to 1, this item will be added even if there is already
           another match with the same "word".
   empty -- When set to 1, this match will be added even if "word" is
           the empty string.

   See ":help complete-functions" in vim for more information.
   '''
   data = {'word' : word}
   if menu != None: data['menu'] = menu
   if info != None: data['info'] = info
   if kind != None: data['kind'] = kind
   if dup != None: data['dup'] = dup
   if empty != None: data['empty'] = empty
   if icase != None: data['icase'] = icase
   return data


#####################################
def do_findstart(completion_context):
   '''
   This function needs to find where the start of the completion is.
   "completion context" is the line up to the cursor, and you need to
   return the position that the completion starts at.

   "completion_context" is the current editor line up to the cursor.

   For simple word matching, use this to find the length of the context
   which is *NOT* related to the last word:

     vimreturn(len(re.match(r'^(.*)\b\w+$', completion_context).group(1)))

   If a completion is not possible: return -1
   '''

   debug('findstart with completion context: "%s"' % completion_context)

   return completion_context.index('"') + 1

   #  @@@ Sample body which reports the start of the current word
   import re
   return re.match(r'^.*"(.*)"$', completion_context).group(1)

   #  completion not possible
   return -1


######################
def do_complete(base):
   '''Find completions and return a list of available completions.
   "base" is the completion word to match against, it is the text between
   what "findstart()" returned and the cursor.

   Use the "completion()" helper (above) to format the completion.

   The return value must be a list of dictionaries.
   '''

   completions = []

   #  @@@  Perform completions here

   for item in COMPONENTS.split("\n"):
     if item and base in item:
       completions.append(completion(item))


     """
     if item and all(c in item for c in base):
       nope = False
       name = item
       
       for char in base:
         if char in name:
           name = name.split(char, 1)[1]
         else:
           nope = True
           break

       if not nope:
         completions.append(completion(item))
       """

   return completions


########################################
findstart = int(vim.eval('a:findstart'))
base = vim.eval('a:base')
row, col = vim.current.window.cursor
line = vim.current.buffer[row - 1]
completion_context = line[:col]

if findstart == 1:
   vimreturn(do_findstart(completion_context))

vim.command('silent let l:completions = %s' % repr(do_complete(base)))
PYTHONEOF
return l:completions
endfunction
