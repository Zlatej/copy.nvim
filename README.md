# copy.nvim

Copy visual selection with additional information

## Setup

Lazy:

```lua
return {
	"zlatej/copy.nvim",
	config = function()
		require("copy.nvim").setup({
            keymap = {
                line = "<leader>cc",
            },
            -- Prefix to strip absolute path
            prefix = "/home/user",
        })
	end,
}
```
