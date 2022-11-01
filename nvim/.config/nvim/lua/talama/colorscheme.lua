local colorscheme = 'onedarkpro'

if colorscheme == 'onedark' then
  require('onedark').setup{
  style = 'dark'
  }
  require('onedark').load()  
elseif colorscheme == 'onedarkpro' then
  require('onedarkpro').setup({
    theme = "onedark_vivid"
  })
  vim.cmd('colorscheme onedarkpro')
else vim.cmd('colorscheme darkblue')
end
