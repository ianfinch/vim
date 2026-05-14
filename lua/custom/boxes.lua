--
-- Make it easier to draw ascii boxes (using venn plugin)
--

local function toggleBoxMode()

    local boxModeEnabled = vim.inspect(vim.b.box_mode_enabled)
    if boxModeEnabled == "nil" then

        vim.cmd[[setlocal ve=all]]
        vim.b.box_mode_enabled = true
        vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", {noremap = true})
        print("Ctrl-V to start drawing, press b to draw a box")
    else

        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "v", "b")
        vim.b.box_mode_enabled = nil
    end
end
vim.keymap.set("", "<Leader>b", toggleBoxMode, { desc = "Draw ASCII boxes" })
