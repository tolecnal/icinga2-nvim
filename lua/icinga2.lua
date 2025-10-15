-- icinga2-nvim: Neovim plugin for Icinga2 syntax highlighting and filetype detection
-- Author: Carlos Cesario (original Vim syntax) / Converted for Neovim by tolecnal

local M = {}

-- Detect icinga2 configuration files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"/etc/icinga2/*.conf",
		"/usr/share/icinga2/include/itl/*.conf",
		"/usr/share/icinga2/include/plugins/*.conf",
		"/usr/share/icinga2/include/*.conf",
	},
	callback = function()
		vim.bo.filetype = "icinga2"
	end,
})

return M
