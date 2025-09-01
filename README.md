# copy.nvim

Copy with additional filename and line number

## Setup

Lazy:

```lua
return {
	"zlatej/copy.nvim",
	config = function()
		require("copy").setup({
            keymap = {
                line = "<leader>cc", -- default
            },
            -- Prefix to strip absolute path
            prefix = "/home/user/",
        })
	end,
}
```

## Features 
- [x] Whole line copy
- [ ] Visual selection copy
- [ ] Customization

