-- local state = {
-- 	floating = {
-- 		buf = -1,
-- 		win = -1,
-- 	}
-- }
--
-- local function create_floating_window(opts)
-- 	opts = opts or {}
-- 	local width = opts.width or math.floor(vim.o.columns * 0.8)
-- 	local height = opts.height or math.floor(vim.o.lines * 0.8)
--
-- 	-- Calculate the position to center the window
-- 	local col = math.floor((vim.o.columns - width) / 2)
-- 	local row = math.floor((vim.o.lines - height) / 2)
--
-- 	-- Create a buffer
-- 	local buf = nil
-- 	if vim.api.nvim_buf_is_valid(opts.buf) then
-- 		buf = opts.buf
-- 	else
-- 		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
-- 	end
--
-- 	-- Define window configuration
-- 	local win_config = {
-- 		relative = "editor",
-- 		width = width,
-- 		height = height,
-- 		col = col,
-- 		row = row,
-- 		style = "minimal", -- No borders or extra UI elements
-- 		border = "rounded",
-- 	}
--
-- 	-- Create the floating window
-- 	local win = vim.api.nvim_open_win(buf, true, win_config)
--
-- 	return { buf = buf, win = win }
-- end
--
-- local toggle_terminal = function()
-- 	if not vim.api.nvim_win_is_valid(state.floating.win) then
-- 		state.floating = create_floating_window { buf = state.floating.buf }
-- 		if vim.bo[state.floating.buf].buftype ~= "terminal" then
-- 			vim.cmd.terminal()
-- 		end
-- 		vim.cmd("startinsert")
-- 	else
-- 		vim.api.nvim_win_hide(state.floating.win)
-- 	end
-- end
--
-- -- Example usage:
-- -- Create a floating window with default dimensions
-- vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
-- vim.keymap.set({ "n", "t" }, "<leader>tr", toggle_terminal)
--
-- return {}
--
--
-- Drop-in floating terminal with title + shadow backdrop + polish
local state = {
	floating = { buf = -1, win = -1 },
	shadow   = { buf = -1, win = -1 },
	augroup  = vim.api.nvim_create_augroup("FloatermDropIn", { clear = true }),
}

-- Look & feel (tweak if you want; no setup function needed)
local UI = {
	width_ratio  = 0.86,
	height_ratio = 0.82,
	min_width    = 60,
	min_height   = 16,
	border       = "rounded",
	winblend     = 8, -- 0..30 (float transparency)
	shadow_blend = 25, -- 0..60 (background dim)
	z_shadow     = 40, -- shadow below main
	z_main       = 50, -- main on top
	icon         = "", -- requires a Nerd Font; change or empty if you like
}

-- --- helpers ----------------------------------------------------------------
local function cwd_name()
	local p = vim.fn.fnamemodify(vim.loop.cwd() or vim.fn.getcwd(), ":t")
	return (p ~= "" and p) or "~"
end

local function title_text()
	local has09 = vim.fn.has("nvim-0.9") == 1
	local t = (UI.icon ~= "" and (UI.icon .. " ") or "") .. "Terminal — " .. cwd_name()
	return has09 and t or nil
end

local function compute_dims()
	local cols, lines = vim.o.columns, vim.o.lines
	local w = math.max(UI.min_width, math.floor(cols * UI.width_ratio))
	local h = math.max(UI.min_height, math.floor(lines * UI.height_ratio))
	w = math.min(w, cols - 2); h = math.min(h, lines - 2)
	local col = math.floor((cols - w) / 2)
	local row = math.floor((lines - h) / 2)
	return w, h, col, row
end

local function ensure_hl()
	-- define local highlight groups used only by this window
	local ok = pcall
	ok(vim.api.nvim_set_hl, 0, "FloatermNormal", { link = "NormalFloat", default = true })
	ok(vim.api.nvim_set_hl, 0, "FloatermBorder", { link = "FloatBorder", default = true })
	ok(vim.api.nvim_set_hl, 0, "FloatermTitle", { link = "FloatTitle", default = true })
	ok(vim.api.nvim_set_hl, 0, "FloatermShadow", { link = "NormalFloat", default = true })
end

-- is there a running job in terminal buffer?
local function term_running(buf)
	local id = vim.b[buf] and vim.b[buf].terminal_job_id
	if not id then return false end
	local st = vim.fn.jobwait({ id }, 0)[1]
	return st == -1 -- -1 => running
end

-- --- window creation ---------------------------------------------------------
local function open_shadow(w, h, col, row)
	-- create a dimmed, borderless backdrop slightly bigger than main
	if state.shadow.buf < 0 or not vim.api.nvim_buf_is_valid(state.shadow.buf) then
		state.shadow.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[state.shadow.buf].bufhidden = "wipe"
	end
	local cfg = {
		relative = "editor",
		width = w,
		height = h,
		col = col,
		row = row,
		style = "minimal",
		zindex = UI.z_shadow,
		border = "none",
	}
	state.shadow.win = vim.api.nvim_open_win(state.shadow.buf, false, cfg)
	-- Just a dim rectangle
	vim.wo[state.shadow.win].winhl = "Normal:FloatermShadow"
	pcall(vim.api.nvim_win_set_option, state.shadow.win, "winblend", UI.shadow_blend)
	-- Make sure it's truly empty (no signcol, no foldcolumn, etc.)
	pcall(vim.api.nvim_win_set_option, state.shadow.win, "signcolumn", "no")
	pcall(vim.api.nvim_win_set_option, state.shadow.win, "foldcolumn", "0")
end

local function create_floating_window()
	ensure_hl()
	local w, h, col, row = compute_dims()

	-- shadow first (same size, tiny offset looks nice)
	open_shadow(w, h, col + 2, row + 1)

	-- terminal buffer
	if state.floating.buf < 0 or not vim.api.nvim_buf_is_valid(state.floating.buf) then
		state.floating.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[state.floating.buf].bufhidden = "hide"
	end

	local cfg = {
		relative = "editor",
		width = w,
		height = h,
		col = col,
		row = row,
		style = "minimal",
		border = UI.border,
		zindex = UI.z_main,
	}
	if vim.fn.has("nvim-0.9") == 1 then
		cfg.title = title_text()
		cfg.title_pos = "center"
	end

	state.floating.win = vim.api.nvim_open_win(state.floating.buf, true, cfg)

	-- polish
	pcall(vim.api.nvim_win_set_option, state.floating.win, "winblend", UI.winblend)
	vim.wo[state.floating.win].winhl =
	"Normal:FloatermNormal,FloatBorder:FloatermBorder,FloatTitle:FloatermTitle"

	-- less UI noise inside
	pcall(vim.api.nvim_win_set_option, state.floating.win, "signcolumn", "no")
	pcall(vim.api.nvim_win_set_option, state.floating.win, "foldcolumn", "0")

	return state.floating.buf, state.floating.win
end

local function close_shadow()
	if state.shadow.win ~= -1 and vim.api.nvim_win_is_valid(state.shadow.win) then
		pcall(vim.api.nvim_win_hide, state.shadow.win)
	end
end

-- --- terminal lifecycle ------------------------------------------------------
local function ensure_terminal(buf)
	-- If not a terminal or its job is dead, (re)spawn shell in the current window.
	if vim.bo[buf].buftype ~= "terminal" or not term_running(buf) then
		-- Attach buffer to the current float window (created by create_floating_window)
		if state.floating.win ~= -1 and vim.api.nvim_win_is_valid(state.floating.win) then
			vim.api.nvim_win_set_buf(state.floating.win, buf)
		end
		local ok = pcall(function() vim.fn.termopen(vim.o.shell) end)
		if not ok then vim.cmd("terminal") end
	end
	vim.cmd("startinsert")
end

local function recenter_if_open()
	if state.floating.win ~= -1 and vim.api.nvim_win_is_valid(state.floating.win) then
		local w, h, col, row = compute_dims()
		-- move both windows
		vim.api.nvim_win_set_config(state.floating.win, {
			relative = "editor", width = w, height = h, col = col, row = row,
		})
		if state.shadow.win ~= -1 and vim.api.nvim_win_is_valid(state.shadow.win) then
			vim.api.nvim_win_set_config(state.shadow.win, {
				relative = "editor", width = w, height = h, col = col + 2, row = row + 1,
			})
		end
	end
end

-- --- user action -------------------------------------------------------------
local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		local buf = create_floating_window()
		ensure_terminal(state.floating.buf)
	else
		vim.api.nvim_win_hide(state.floating.win)
		close_shadow()
	end
end

-- --- autocmds ----------------------------------------------------------------
vim.api.nvim_clear_autocmds({ group = state.augroup })

vim.api.nvim_create_autocmd("VimResized", {
	group = state.augroup,
	callback = recenter_if_open,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = state.augroup,
	callback = function(ev)
		if ev.buf == state.floating.buf then
			-- nuke dead buffer so next open is fresh
			if vim.api.nvim_buf_is_valid(state.floating.buf) then
				pcall(vim.api.nvim_buf_delete, state.floating.buf, { force = true })
			end
			state.floating.buf = -1
			-- hide windows if still open
			if vim.api.nvim_win_is_valid(state.floating.win) then
				pcall(vim.api.nvim_win_hide, state.floating.win)
			end
			close_shadow()
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = state.augroup,
	callback = function(ev)
		if ev.buf == state.floating.buf
				and vim.api.nvim_win_is_valid(state.floating.win)
				and vim.bo[ev.buf].buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

-- same interface as your original
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tr", toggle_terminal, { desc = "Toggle floating terminal" })

return {}
