local options = {
    backup = false,
    clipboard = "unnamedplus",      -- allows nvim to access the system clipboard
    cmdheight = 1,                  -- more space in the nvim command line for messages
    completeopt = { "menuone", "noselect" },
    conceallevel = 0,               -- makes `` invisible in markdown
    fileencoding = "utf-8",
    hlsearch = true,                -- highlight matches on the last search
    incsearch = true,               -- show search results as you type
    ignorecase = true,              -- ignore case in search
    mouse = "a",                    -- enable mouse interaction
    pumheight = 10,                 -- pop-up menu height
    showmode = false,               -- hide the mode, replaced by plugin
    showtabline = 2,                -- always show tabs at the top
    smartcase = true,
    smartindent = true,
    splitbelow = true,              -- vertical splits default to below
    splitright =  true,             -- horizontal splits default to below
    swapfile = false,
    termguicolors = true,
    timeoutlen = 300,               -- time to wait for a mapping the execute in ms
    undofile = true,                -- persistent undo
    updatetime = 300,               -- faster completions
    writebackup = false,            -- don't allow editing if file is opened in other program
    expandtab = true,               -- convert tabs to spaces
    shiftwidth = 4,                 -- number of spaces for each indentation
    tabstop = 4,                    -- number of spaces for in place of a tab
    cursorline = true,              -- highlight the current line
    number = true,
    relativenumber = false,
    numberwidth = 4,                -- number column width
    signcolumn = "yes",             -- always show the signcolumn, otherwise shifts screen on insert
    wrap = true,
    linebreak = true,               -- don't split words when wrapping
    scrolloff = 6,                  -- number of lines to keep above and below the cursor
    sidescrolloff = 6,              -- number of columns to keep on either side of the cursor (if wrap false)
    guifont = "Fira Code:h12",
    whichwrap = "bs<>[]hl",         -- horizontal keys that can get wrapped
    shell = "/usr/bin/zsh",
    list = true,                    -- replace certain invisible characters with symbols
    listchars = {
        tab = "→ ",
        trail = "·",
        extends = "…",
        precedes = "…",
        nbsp = "␣",
    },
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Disable netrw early to avoid race issues
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setting the leader key early before loading plugins
vim.g.mapleader = " "

vim.opt.shortmess:append("c")           -- don't show |ins-completion-menu| messages
vim.opt.iskeyword:append("-")           -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.


if vim.g.neovide then
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 10
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.g.neovide_transparency = 1.0
    vim.g.transparency = 0.85
    -- vim.g.neovide_floating_blur_amount_x = 2.0 -- doesn't seem to do anything
    -- vim.g.neovide_floating_blur_amount_y = 2.0

    vim.g.neovide_scroll_animation_length = 0.4
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 60

    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_animation_length = 0.1
    vim.g.neovide_cursor_trail_size = 0.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true

    vim.g.neovide_confirm_quit = true
end
