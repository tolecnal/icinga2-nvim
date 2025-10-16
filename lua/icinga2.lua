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

	-- Setup nvim-cmp integration if available
	M.setup_cmp()
end

-- nvim-cmp completion source
function M.setup_cmp()
	local ok, cmp = pcall(require, "cmp")
	if not ok then
		return
	end

	local source = {}

	-- Completion items based on Icinga2 language reference
	local completion_items = {
		-- Keywords
		{ label = "object", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Define a new object" },
		{ label = "template", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Define a template" },
		{ label = "apply", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Apply rule" },
		{ label = "import", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Import template" },
		{ label = "include", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Include file" },
		{
			label = "include_recursive",
			kind = cmp.lsp.CompletionItemKind.Keyword,
			detail = "Include files recursively",
		},
		{ label = "include_zones", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Include zone files" },
		{ label = "library", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Library directive" },
		{ label = "const", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Constant declaration" },
		{ label = "var", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Variable declaration" },
		{ label = "function", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Function definition" },
		{ label = "return", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Return statement" },
		{ label = "if", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Conditional statement" },
		{ label = "else", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Else clause" },
		{ label = "for", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "For loop" },
		{ label = "while", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "While loop" },
		{ label = "break", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Break statement" },
		{ label = "continue", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Continue statement" },
		{ label = "assign", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Assign where clause" },
		{ label = "where", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Where clause" },
		{ label = "ignore", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Ignore where clause" },
		{ label = "use", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Use statement" },
		{ label = "default", kind = cmp.lsp.CompletionItemKind.Keyword, documentation = "Default value" },

		-- Object Types
		{ label = "Host", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Host object type" },
		{ label = "Service", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Service object type" },
		{ label = "CheckCommand", kind = cmp.lsp.CompletionItemKind.Class, documentation = "CheckCommand object type" },
		{ label = "EventCommand", kind = cmp.lsp.CompletionItemKind.Class, documentation = "EventCommand object type" },
		{
			label = "NotificationCommand",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "NotificationCommand object type",
		},
		{ label = "Notification", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Notification object type" },
		{ label = "Dependency", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Dependency object type" },
		{ label = "TimePeriod", kind = cmp.lsp.CompletionItemKind.Class, documentation = "TimePeriod object type" },
		{
			label = "ScheduledDowntime",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "ScheduledDowntime object type",
		},
		{ label = "User", kind = cmp.lsp.CompletionItemKind.Class, documentation = "User object type" },
		{ label = "UserGroup", kind = cmp.lsp.CompletionItemKind.Class, documentation = "UserGroup object type" },
		{ label = "Zone", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Zone object type" },
		{ label = "Endpoint", kind = cmp.lsp.CompletionItemKind.Class, documentation = "Endpoint object type" },
		{ label = "ApiUser", kind = cmp.lsp.CompletionItemKind.Class, documentation = "ApiUser object type" },
		{ label = "ApiListener", kind = cmp.lsp.CompletionItemKind.Class, documentation = "ApiListener object type" },
		{ label = "FileLogger", kind = cmp.lsp.CompletionItemKind.Class, documentation = "FileLogger object type" },
		{ label = "SyslogLogger", kind = cmp.lsp.CompletionItemKind.Class, documentation = "SyslogLogger object type" },
		{
			label = "IcingaApplication",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "IcingaApplication object type",
		},
		{
			label = "CheckerComponent",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "CheckerComponent object type",
		},
		{
			label = "NotificationComponent",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "NotificationComponent object type",
		},
		{
			label = "PerfdataWriter",
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "PerfdataWriter object type",
		},
		{
			label = "GraphiteWriter",
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "GraphiteWriter object type",
		},
		{
			label = "InfluxdbWriter",
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "InfluxdbWriter object type",
		},
		{
			label = "Influxdb2Writer",
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "Influxdb2Writer object type",
		},
		{
			label = "ElasticsearchWriter",
			kind = cmp.lsp.CompletionItemKind.Class,
			detail = "ElasticsearchWriter object type",
		},
		{ label = "GelfWriter", kind = cmp.lsp.CompletionItemKind.Class, documentation = "GelfWriter object type" },
		{
			label = "OpenTsdbWriter",
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "OpenTsdbWriter object type",
		},

		-- Built-in Functions
		{ label = "regex", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Regular expression matching" },
		{ label = "match", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Pattern matching" },
		{ label = "cidr_match", kind = cmp.lsp.CompletionItemKind.Function, documentation = "CIDR network matching" },
		{ label = "len", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get length of array/string" },
		{ label = "union", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Union of arrays" },
		{
			label = "intersection",
			kind = cmp.lsp.CompletionItemKind.Function,
			documentation = "Intersection of arrays",
		},
		{ label = "keys", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get dictionary keys" },
		{ label = "string", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Convert to string" },
		{ label = "number", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Convert to number" },
		{ label = "bool", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Convert to boolean" },
		{ label = "random", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Generate random number" },
		{ label = "log", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Write to log" },
		{ label = "typeof", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get type of value" },
		{ label = "get_time", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get current time" },
		{
			label = "parse_performance_data",
			kind = cmp.lsp.CompletionItemKind.Function,
			detail = "Parse performance data",
		},
		{ label = "dirname", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get directory name" },
		{ label = "basename", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Get base name" },
		{
			label = "escape_shell_arg",
			kind = cmp.lsp.CompletionItemKind.Function,
			documentation = "Escape shell argument",
		},
		{
			label = "escape_shell_cmd",
			kind = cmp.lsp.CompletionItemKind.Function,
			documentation = "Escape shell command",
		},
		{
			label = "escape_create_process_arg",
			kind = cmp.lsp.CompletionItemKind.Function,
			detail = "Escape process argument",
		},
		{ label = "sleep", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Sleep for duration" },
		{ label = "exit", kind = cmp.lsp.CompletionItemKind.Function, documentation = "Exit script" },

		-- Literals
		{ label = "true", kind = cmp.lsp.CompletionItemKind.Value, documentation = "Boolean true" },
		{ label = "false", kind = cmp.lsp.CompletionItemKind.Value, documentation = "Boolean false" },
		{ label = "null", kind = cmp.lsp.CompletionItemKind.Value, documentation = "Null value" },

		-- Common Attributes
		{ label = "name", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Object name" },
		{ label = "display_name", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Display name" },
		{ label = "check_command", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Check command" },
		{ label = "check_interval", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Check interval" },
		{ label = "retry_interval", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Retry interval" },
		{
			label = "max_check_attempts",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Maximum check attempts",
		},
		{ label = "command", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Command to execute" },
		{ label = "arguments", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Command arguments" },
		{ label = "vars", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Custom variables" },
		{ label = "groups", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Object groups" },
		{ label = "address", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Host address" },
		{ label = "address6", kind = cmp.lsp.CompletionItemKind.Property, documentation = "IPv6 address" },
		{
			label = "enable_notifications",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Enable notifications",
		},
		{
			label = "enable_active_checks",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Enable active checks",
		},
		{
			label = "enable_passive_checks",
			kind = cmp.lsp.CompletionItemKind.Property,
			detail = "Enable passive checks",
		},
		{
			label = "enable_event_handler",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Enable event handler",
		},
		{
			label = "enable_flapping",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Enable flapping detection",
		},
		{
			label = "enable_perfdata",
			kind = cmp.lsp.CompletionItemKind.Property,
			documentation = "Enable performance data",
		},
		{ label = "event_command", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Event command" },
		{
			label = "flapping_threshold_high",
			kind = cmp.lsp.CompletionItemKind.Property,
			detail = "Flapping threshold high",
		},
		{
			label = "flapping_threshold_low",
			kind = cmp.lsp.CompletionItemKind.Property,
			detail = "Flapping threshold low",
		},
		{ label = "volatile", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Volatile flag" },
		{ label = "zone", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Zone assignment" },
		{ label = "command_endpoint", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Command endpoint" },
		{ label = "notes", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Notes" },
		{ label = "notes_url", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Notes URL" },
		{ label = "action_url", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Action URL" },
		{ label = "icon_image", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Icon image" },
		{ label = "icon_image_alt", kind = cmp.lsp.CompletionItemKind.Property, documentation = "Icon image alt text" },
	}

	function source:complete(params, callback)
		callback(completion_items)
	end

	function source:get_debug_name()
		return "icinga2"
	end

	-- Register the source
	cmp.register_source("icinga2", source)
end

-- Auto-setup with defaults if user doesn't call setup()
M.setup()

return M
