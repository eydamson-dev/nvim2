return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      modules = {},
      ignore_install = {},
      ensure_installed = { "lua", "css", "scss", "html", "javascript", "typescript", "json" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
    })

    -- Set up treesitter folding for UFO
    vim.opt.foldmethod = "manual"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
