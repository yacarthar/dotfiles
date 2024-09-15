return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                -- js
                null_ls.builtins.formatting.prettier,
                -- py
                null_ls.builtins.formatting.black.with({
                    extra_args = {"--fast"}
                }),
                --null_ls.builtins.diagnostics.isort,
            }
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
}
