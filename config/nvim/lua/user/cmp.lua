local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  return
end

local status_ok, luasnip = pcall(require, 'luasnip')
if not status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local function border(hl_name)
   return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
   }
end

options = {
  snippet = {
    expand = function(args)
       require("luasnip").lsp_expand(args.body)
    end,
  },
   window = {
      completion = {
         border = border "CmpBorder",
         winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
         border = border "CmpDocBorder",
      },
   },
   formatting = {
      format = function(_, vim_item)
         local icons = require("user/icons").lspkind
         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
         return vim_item
      end,
   },

   mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Insert,
         select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end, {
         "i",
         "s",
      }),
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
   },
}

cmp.setup(options)
