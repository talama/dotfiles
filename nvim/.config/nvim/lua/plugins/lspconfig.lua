return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
				keymap("n", "M", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end)

				opts.desc = "Signature help"
				keymap("n", "gh", vim.lsp.buf.signature_help, opts)

				opts.desc = "Restart LSP"
				keymap("n", "<leader>lR", ":LspRestart<CR>", opts)

				opts.desc = "See available code actions"
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Show line diagnostics"
				keymap("n", "<leader>cd", vim.diagnostic.open_float, opts)

				opts.desc = "Show buffer diagnostics"
				keymap("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Smart rename"
				keymap("n", "<leader>cr", vim.lsp.buf.rename, opts)

				opts.desc = "Format buffer"
				keymap("n", "<leader>cF", vim.lsp.buf.format, opts)

				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end

				if client then
					if client.name == "eslint" then
						client.server_capabilities.documentFormattingProvider = true
					elseif client.name == "vtsls" then
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

		-- Next, you can provide a dedicated handler for specific servers.
		lspconfig.bashls.setup({
			capabilities = capabilities,
			completions = {
				completeFunctionCalls = true,
			},
			filetypes = { "sh", "zsh" },
		})

		-- HTML language server
		lspconfig.html.setup({
			capabilities = capabilities,
			filetypes = { "html", "templ", "gohtmltmpl", "gotmpl" },
		})

		-- Emmet
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"astro",
				"css",
				"eruby",
				"gohtmltmpl",
				"gotmpl",
				"html",
				"htmldjango",
				"javascriptreact",
				"less",
				"pug",
				"sass",
				"scss",
				"svelte",
				"typescriptreact",
				"vue",
				"htmlangular",
			},
		})

		-- CSS language server
		lspconfig.cssls.setup({
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

		lspconfig.jsonls.setup({
			on_new_config = function(new_config)
				new_config.settings.json.schemas = new_config.settings.json.schemas or {}
				vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
			end,
			settings = {
				json = {
					format = {
						enable = true,
					},
					validate = { enable = true },
				},
			},
		})

		-- Lua language server
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "Snacks" },
					},
					hint = {
						enable = true,
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
						completion = { workspaceWord = true, callSnippet = "Replace" },
						doc = {
							privateName = { "^_" },
						},
					},
				},
			},
		})

		lspconfig.vtsls.setup({
			capabilities = capabilities,
			settings = {
				vtsls = {
					enableMoveToFileCodeAction = true,
					autoUseWorkspaceTsdk = true,
					experimental = {
						maxInlayHintLength = 30,
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
				javascript = {
					suggest = {
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = { enabled = "always" },
					inlayHints = {
						parameterNames = {
							enabled = "literals",
							suppressWhenArgumentMatchesName = true,
						},
						parameterTypes = { enabled = false },
						variableTypes = {
							enabled = false,
							suppressWhenTypeMatchesName = true,
						},
						propertyDeclarationTypes = { enabled = false },
						functionLikeReturnTypes = { enabled = false },
						enumMemberValues = { enabled = false },
					},
				},
				typescript = {
					updateImportsOnFileMove = { enabled = "always" },
					suggest = {
						completeFunctionCalls = true,
					},
					inlayHints = {
						parameterNames = {
							enabled = "literal",
							suppressWhenArgumentMatchesName = true,
						},
						parameterTypes = { enabled = true },
						variableTypes = {
							enabled = false,
							suppressWhenTypeMatchesName = true,
						},
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
				},
			},
		})

		-- Go language server
		lspconfig.gopls.setup({
			capabilities = capabilities,
			filetypes = { "go", "gomod", "gowork" },
			completions = {
				completeFunctionCalls = true,
			},
			settings = {
				gopls = {
					gofumpt = true,
					completeFunctionCalls = true,
					-- ["build.templateExtensions"] = { "gohtml", "html", "gotmpl", "tmpl" },
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
						assignVariableTypes = false,
						compositeLiteralFields = false,
						compositeLiteralTypes = false,
						constantValues = false,
						functionTypeParameters = false,
						parameterNames = false,
						rangeVariableTypes = false,
					},
					analyses = {
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
}
