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
            -- Prefix to strip off absolute path
            prefix = "/home/user/",
        })
	end,
}
```

## Features 
- [x] Copy only context
- [x] One line copy
- [ ] Visual selection copy
- [ ] Customizate context

