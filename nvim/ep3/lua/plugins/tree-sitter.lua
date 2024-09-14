 return   {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "python", "lua", "typescript", "javascript", "html", "css",
                "vim", "git_config", "toml", "json"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
        end
}
