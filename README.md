# ctx-copy.nvim

Copy with additional context - path:line

## Default keybinds
### Copy context
```md
# <leader>cc
copy-nvim/README.md:6
```
### Copy line with context
```md
# <leader>cl
copy-nvim/README.md:24
"zlatej/copy.nvim",
```

## Setup

Lazy:

```lua
return {
	"zlatej/copy.nvim",
	config = function()
		require("copy").setup({
            keymap = { -- default keymaps
                cp_context = "<leader>cc"
                cp_line = "<leader>cl", 
            },
            -- Array of path prefixes to strip from absolute file paths
            -- Prefixes are processed sequentially in the order listed
            -- Examples for this config:
                -- /home/user/code/copy-nvim/README.md -> copy-nvim/README.md
                -- /home/user/.zshrc -> .zshrc
                -- /home/user2/.zshrc -> /home/user2/.zshrc
            prefixes = {
                "/home/user",
                "code"
            },
            remove_indent = true
        })
	end,
}
```

## Features 
- [x] Copy only context
- [x] One line copy
- [x] More dynamic path prefix removing
- [ ] Visual selection copy
- [ ] Customizate context

