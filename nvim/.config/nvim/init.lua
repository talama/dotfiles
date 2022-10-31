if(vim.g.vscode) then 
	print("vscode")
else
	print("nvim")
	require "talama.options"
  require "talama.keymaps"
  require "talama.plugins"
end
