return {
  'folke/tokyonight.nvim',
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent"
      }
    })

    local colorscheme = "tokyonight"

    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
      vim.notify("colorscheme " .. colorscheme .. " not found!")
      return
    end
  end
}
