# copy.nvim

Copy with additional filename and line number

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
            -- Example: /home/user/code/copy-nvim/README.md -> copy-nvim/README.md
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
- [ ] More dynamic path prefix removing
- [ ] Visual selection copy
- [ ] Customizate context

