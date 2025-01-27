```
cd ~
git clone git@github.com:mluders/dotfiles.git
cd dotfiles
make
```

# TODO:

* `ds` to delete a segment in vim (camel or snake case segments)
* LSP
* Figure out how to use quickfix list (better than harpoon?)
* Auto format code on save
* token motion (dit, cit), and change definiton of word to ignore _ so that _ and - are treated equally
* Better grep without having to type regex
* Grep same files as rg
* Search a folder
* Snippets, figure them out
* 'Julian/vim-textobj-brace' (it doesn't quite work as expected, make it work)
* Alt-t ftplugin to find corresponding Ruby test
* LSP: When I gd and select a result, the quickfix list should close automatically
* Better way to run tests so I don't lose the terminal window
* ciw should use treesitter (in a string, . should be part of the word, but should be treated separately in a function)
* project specific file to store list of "quick" files (immediately accessible from telescope without waiting)
* fold/unfold list structures
* select to end of line (easier than g_)
* copy paste (especially pasting over words with viw)
* LLM
     - Automatic commit messages
* g'aw to add quotes around word
