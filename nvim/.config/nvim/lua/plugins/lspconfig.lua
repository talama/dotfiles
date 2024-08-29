return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local mason_lspconfig = require("mason-lspconfig")

		-- enable autocompletion
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities() or {}
		)

		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- Diagnostic
		vim.diagnostic.config({
			float = {
				border = "rounded",
				focusable = true,
				style = "minimal",
				source = "if_many",
				header = "",
				prefix = "  ",
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		}
		local keymap = vim.keymap.set

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- set keybinds
				local opts = { buffer = bufnr, silent = true }

				opts.desc = "Show buffer diagnostics"
				keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Goto previous diagnostic"
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Goto next diagnostic"
				keymap("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show LSP definitions"
				keymap("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show LSP t[y]pe definitions"
				keymap("n", "gy", vim.lsp.buf.type_definition, opts)

				opts.desc = "Goto declaration"
				keymap("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP implementations"
				keymap("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Show LSP references"
				opts.nowait = true
				keymap("n", "gr", vim.lsp.buf.references, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Signature help"
				keymap("n", "lh", vim.lsp.buf.signature_help, opts)

				opts.desc = "Restart LSP"
				keymap("n", "<leader>lR", ":LspRestart<CR>", opts)

				opts.desc = "LspInfo"
				keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)

				opts.desc = "See available code actions"
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)

				opts.desc = "Format buffer"
				keymap("n", "<leader>lf", vim.lsp.buf.format, opts)

				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end

				if client then
					if client.name == "eslint" then
						client.server_capabilities.documentFormattingProvider = true
					elseif client.name == "tsserver" then
						client.server_capabilities.documentFormattingProvider = false
					elseif client.name == "html" then
						client.server_capabilities.documentFormattingProvider = false
					elseif client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
						local semantic = client.config.capabilities.textDocument.semanticTokens
						if semantic then
							client.server_capabilities.semanticTokensProvider = {
								full = true,
								legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
								range = true,
							}
						end
					end
				end
			end,
		})

		mason_lspconfig.setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					handlers = handlers,
				})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			["bashls"] = function()
				lspconfig["bashls"].setup({
					handlers = handlers,
					capabilities = capabilities,
					completions = {
						completeFunctionCalls = true,
					},
					filetypes = { "sh", "zsh" },
				})
			end,

			-- Lua language server
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							hint = {
								enable = false,
								setType = false,
								paramType = true,
								await = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							workspace = {
								library = {
									checkThirdParty = false,
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
									[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
							},
						},
					},
				})
			end,

			-- Typescript language server
			["tsserver"] = function()
				lspconfig["tsserver"].setup({
					capabilities = capabilities,
					handlers = handlers,
					single_file_support = true,
					completions = {
						completeFunctionCalls = true,
					},
					settings = {
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayVariableTypeHints = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayVariableTypeHints = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,

			-- CSS language server
			["cssls"] = function()
				lspconfig["cssls"].setup({
					handlers = handlers,
					capabilities = capabilities,
					completions = {
						completeFunctionCalls = true,
					},
					settings = {
						css = {
							lint = {
								unknownAtRules = "ignore",
							},
						},
					},
				})
			end,

			-- Go language server
			["gopls"] = function()
				lspconfig["gopls"].setup({
					handlers = handlers,
					capabilities = capabilities,
					completions = {
						completeFunctionCalls = true,
					},
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								fieldalignment = true,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				})
			end,
		})
	end,
}