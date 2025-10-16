-- icinga2-nvim: Neovim plugin for Icinga2 syntax highlighting and filetype detection
-- Author: Carlos Cesario (original Vim syntax) / Converted for Neovim by tolecnal

local M = {}

-- Default paths for Icinga2 configuration files
local default_patterns = {
	"/etc/icinga2/*.conf",
	"/usr/share/icinga2/include/itl/*.conf",
	"/usr/share/icinga2/include/plugins/*.conf",
	"/usr/share/icinga2/include/*.conf",
}

-- User configuration
local config = {
	custom_paths = {},
}

-- Setup function for user configuration
function M.setup(opts)
	opts = opts or {}
	config.custom_paths = opts.custom_paths or {}

	-- Merge default patterns with custom paths
	local all_patterns = vim.list_extend(vim.deepcopy(default_patterns), config.custom_paths)

	-- Detect icinga2 configuration files
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = all_patterns,
		callback = function()
			vim.bo.filetype = "icinga2"
		end,
	})
end

-- Auto-setup with defaults if user doesn't call setup()
M.setup()

return M
