require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.floaterm"
require "user.project"
require "user.alpha"
require "user.whichkey"
-- require "user.truezen"
require "user.zen-mode"
require "user.neoscroll"
require "user.emmet"
-- require "user.nvim-ufo"
-- require "user.prettyfold"
-- require "user.vim-rooter"
require "user.hop"

vim.cmd[[
  " -------------------------------------------------------------
  " WSL 2 사용 시 yank 내용을 
  " -------------------------------------------------------------
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
      augroup WSLYank
          autocmd!
          autocmd TextYankPost * call system('echo '.
      \shellescape(
        \join(v:event.regcontents, "\<CR>")
      \).' | '.s:clip
    \)
      augroup END
  end 
]]
