vim.keymap.set("n", "<c-h>", "<C-w>h", { desc = "turn to left window" })
vim.keymap.set("n", "<c-j>", "<C-w>j", { desc = "turn to down window" })
vim.keymap.set("n", "<c-k>", "<C-w>k", { desc = "turn to up window" })
vim.keymap.set("n", "<c-l>", "<C-w>l", { desc = "turn to right window" })
vim.keymap.set("n", "<leader><esc>", ":wq<cr>", { desc = "store and quit Neovim" })
vim.keymap.set("i", "jj", "<esc>", { desc = "Escape editor insert mode" })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Escape terminal insert mode" })
vim.keymap.set("n", "<esc>", ":noh<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<m-k>", "<c-w>-", { desc = "Reduce horizontal split screen size" })
vim.keymap.set("n", "<m-j>", "<c-w>+", { desc = "Increase horizontal split screen size" })
vim.keymap.set("n", "<m-h>", "<c-w><", { desc = "Reduce vertical split screen size" })
vim.keymap.set("n", "<m-l>", "<c-w>>", { desc = "Increase vertical split screen size" })
vim.keymap.set("n", "<leader>sc", ":set spell!<cr>", { desc = "Enable or disable spell checking" })
vim.keymap.set({ "i", "c", "t" }, "<m-w>", "<c-right>", { desc = "Jump to next word in insert mode" })
vim.keymap.set({ "i", "c", "t" }, "<m-b>", "<c-left>", { desc = "Jump to previous word in insert mode" })
vim.keymap.set({ "i", "c", "t" }, "<m-k>", "<up>", { desc = "Move cursor up in insert mode" })
vim.keymap.set({ "i", "c", "t" }, "<m-j>", "<down>", { desc = "Move cursor down in insert mode" })
vim.keymap.set({ "i", "c", "t" }, "<m-h>", "<left>", { desc = "Move cursor left in insert mode" })
vim.keymap.set({ "i", "c", "t" }, "<m-l>", "<right>", { desc = "Move cursor right in insert mode" })
vim.keymap.set("n", "<c-u>", function()
    vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "k")
end, { desc = "Move 1/4 screen up" })
vim.keymap.set("n", "<c-d>", function()
    vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "j")
end, { desc = "Move 1/4 screen down" })
vim.keymap.set({ "n", "x" }, "H", function()
    return vim.v.count > 0 and "^" or "g^"
end, { expr = true, desc = "Move to the first character at the beginning of the line" })
vim.keymap.set({ "n", "x" }, "L", function()
    return vim.v.count > 0 and "$" or "g$"
end, { expr = true, desc = "Move to the last character at the end of the line" })
