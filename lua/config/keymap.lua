local keymap = vim.keymap.set

local opts = function(desc)
    return { desc = desc, silent = true }
end

-- Leader is set before plugins are loaded
-- vim.g.mapleader = " "

-- Disable annoying default maps
keymap("n", "J", "<Nop>", opts("Disable J"))
keymap("n", "Q", "<Nop>", opts("Disable Q"))

-- Save with Ctrl+s
keymap("n", "<C-s>", "<cmd>w<CR>", opts("Save File"))

-- Navigating splits with Alt
keymap({ "n", "t" }, "<M-h>", "<cmd>wincmd h<CR>", opts("Window Left"))
keymap({ "n", "t" }, "<M-j>", "<cmd>wincmd j<CR>", opts("Window Down"))
keymap({ "n", "t" }, "<M-k>", "<cmd>wincmd k<CR>", opts("Window Up"))
keymap({ "n", "t" }, "<M-l>", "<cmd>wincmd l<CR>", opts("Window Right"))

-- Resizing splits with arrows
keymap({ "n", "t" }, "<M-Up>", "<cmd>resize -2<CR>", opts("Window Shrink Horizontal"))
keymap({ "n", "t" }, "<M-Down>", "<cmd>resize +2<CR>", opts("Window Expand Horizontal"))
keymap({ "n", "t" }, "<M-Left>", "<cmd>vertical resize -2<CR>", opts("Window Shrink Vertical"))
keymap({ "n", "t" }, "<M-Right>", "<cmd>vertical resize +2<CR>", opts("Window Expand Vertical"))

-- Go back to normal mode with just esc in terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts("Terminal To Normal Mode"))

-- Cycle buffers
keymap("n", "<C-h>", "<cmd>bprevious<CR>", opts("Buffer Previous"))
keymap("n", "<C-l>", "<cmd>bnext<CR>", opts("Buffer Next"))

-- Close buffer
keymap("n", "<C-q>", "<cmd>Bdelete!<CR>", opts("Buffer Close"))

-- Clear search highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts("Clear Highlights"))

-- Change indentation and stay in indent mode
keymap("v", "<", "<gv", opts("Indent Decrease"))
keymap("v", ">", ">gv", opts("Indent Increase"))

-- Move selected lines
keymap("v", "J", ":m '>+1<CR>gv=gv", opts("Move Line Down"))
keymap("v", "K", ":m '<-2<CR>gv=gv", opts("Move Line Up"))

-- Half page jumps with constant cursor position
keymap("n", "<C-d>", "zz<C-d>", opts("Half Page Down"))
keymap("n", "<C-u>", "zz<C-u>", opts("Half Page Up"))

-- Keep original clipboard when pasting over visual selection
keymap("v", "p", '"_dP', opts("Paste Over Selection"))

-- Plugins
--
-- NvimTree
keymap("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", opts("nvim-tree: Toggle"))

-- Comment
keymap("n", "<C-/>", function()
    require("Comment.api").toggle.linewise.current()
end, opts("comment: Toggle Line"))
keymap("x", "<C-/>", function()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, opts("comment: Toggle Selection"))

-- Telescope
keymap("n", "<leader>ff", function()
    require("telescope.builtin").find_files({
        hidden = true,
        no_ingore = true,
    })
end, opts("telescope: Find Files"))
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts("telescope: Live Grep"))
keymap("n", "<leader>fb", require("telescope.builtin").buffers, opts("telescope: Buffers"))
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, opts("telescope: Help Tags"))
keymap("n", "<leader>fd", require("telescope.builtin").diagnostics, opts("telescope: Diagnostics"))
keymap("n", "<leader>fs", require("telescope.builtin").symbols, opts("telescope: Symbols"))
keymap("n", "<leader>fn", require("telescope").extensions.notify.notify, opts("telescope: Symbols"))

-- Neovide
--
-- Resize font scale
if vim.g.neovide then
    vim.g.neovide_scale_factor = 1

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
    end

    keymap("n", "<C-=>", function()
        change_scale_factor(0.1)
    end, opts("neovide: Increase Zoom Level"))

    keymap("n", "<C-->", function()
        change_scale_factor(-0.1)
    end, opts("neovide: Decrease Zoom Level"))

    vim.g.neovide_fullscreen = false
    keymap("n", "<F11>", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
        vim.notify(
            "Fullscreen: " .. (vim.g.neovide_fullscreen and "on" or "off"),
            vim.log.levels.INFO,
            { title = "Neovide" }
        )
    end, opts("neovide: Toggle Fullscreen"))

    vim.g.neovide_profiler = false
    keymap("n", "<F12>", function()
        vim.g.neovide_profiler = not vim.g.neovide_profiler
        vim.notify(
            "Performance Overlay: " .. (vim.g.neovide_profiler and "on" or "off"),
            vim.log.levels.INFO,
            { title = "Neovide" }
        )
    end, opts("neovide: Toggle Performance Overlay"))
end
