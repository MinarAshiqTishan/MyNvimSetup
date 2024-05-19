	-- Filename : plugin_config.lua


	---------------------------LAZYVIM_START--------------------------------------------
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
	  vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	  })
	end
	vim.opt.rtp:prepend(lazypath)
	---------------------------LAZYVIM_END--------------------------------------------

	---------------------------------------TREESITTER_START--------------------------------------------

	-- On Windows it is required to use the cl.exe from Visual studio build tools for the Treesitter to work
	-- current path F:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\bin\Hostx64\x64
	require'nvim-treesitter.configs'.compilers = { "cl"}

	require'nvim-treesitter.configs'.setup {
	  -- A list of parser names, or "all" (the five listed parsers should always be installed)
	  ensure_installed = { "c", "vim", "lua", "rust", "vimdoc", "query" },

	  -- Install parsers synchronously (only applied to `ensure_installed`)
	  sync_install = false,

	  -- Automatically install missing parsers when entering buffer
	  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	  auto_install = true,

	  -- List of parsers to ignore installing (or "all")
	  ignore_install = { "javascript" },

	  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	  highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	  },
	}

	---------------------------------------TREESITTER_END--------------------------------------------


	---------------------------------------VIM_DIAGNOSTIC_START--------------------------------------------
	-- Global mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	vim.keymap.set('n', '<space>do', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<space>ds', vim.diagnostic.setloclist)

	---------------------------------------VIM_DIAGNOSTIC_END--------------------------------------------



	---------------------------------------CMP_START------------------------------------------------


	-- Set up nvim-cmp.
	local cmp = require'cmp'

	cmp.setup({
	  snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	  },
	  window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	  },
	  mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	  }),
	  sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	  }, {
		{ name = 'buffer' },
	  })
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
	  sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	  }, {
		{ name = 'buffer' },
	  })
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
	  mapping = cmp.mapping.preset.cmdline(),
	  sources = {
		{ name = 'buffer' }
	  }
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
	  mapping = cmp.mapping.preset.cmdline(),
	  sources = cmp.config.sources({
		{ name = 'path' }
	  }, {
		{ name = 'cmdline' }
	  }),
	  matching = { disallow_symbol_nonprefix_matching = false }
	})

	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	require('rust-tools').setup ({
		server = {
			capabilities = capabilities,
			on_attach = lsp_attach,
		}
	})


	---------------------------------------CMP_END------------------------------------------------



	---------------------------------------LSP_START--------------------------------------------

	local lspconfig = require('lspconfig')
	lspconfig.rust_analyzer.setup {
	  -- Server-specific settings. See :help lspconfig-setup
	  settings = {
		['rust-analyzer'] = {},
	  },
	}


	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('UserLspConfig', {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', '<space>gs', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set('n', '<space>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover, {
			   -- Use a sharp border with `FloatBorder` highlights
			   border = "rounded",
			 }
			)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
			 vim.lsp.handlers.signature_help, {
			   -- Use a sharp border with `FloatBorder` highlights
			   border = "rounded",
			 }
			)
		end,
	})

	---------------------------------------LSP_END----------------------------------------------------



	---------------------------------------HARPOON_START----------------------------------------------

	local harpoon = require("harpoon")
	-- REQUIRED
	harpoon:setup({
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		},
	})
	-- REQUIRED

	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
	-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
	-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
	-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-A-P>", function() harpoon:list():prev() end)
	vim.keymap.set("n", "<C-A-N>", function() harpoon:list():next() end)


	-- basic telescope configuration for Harpoon
--local conf = require("telescope.config").values
--local function toggle_telescope(harpoon_files)
--    local file_paths = {}
--    for _, item in ipairs(harpoon_files.items) do
--        table.insert(file_paths, item.value)
--    end
--
--    require("telescope.pickers").new({}, {
--        prompt_title = "Harpoon",
--        finder = require("telescope.finders").new_table({
--            results = file_paths,
--        }),
--        previewer = conf.file_previewer({}),
--        sorter = conf.generic_sorter({}),
--    }):find()
--end
--
--vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
--    { desc = "Open harpoon window" })



-- The 'extend' functionality can be used to add keymaps for opening files in splits & tabs.
harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})

---------------------------------------HARPOON_END------------------------------------------------




---------------------------------------TELESCOPE_START------------------------------------------------

vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"


--require("telescope").setup {
--	extensions = {
--		file_browser = {
--			theme = "ivy",
--			-- disables netrw and use telescope-file-browser in its place
--			hijack_netrw = false,
--			mappings = {
--				["i"] = {
--					-- your custom insert mode mappings
--				},
--				["n"] = {
--					-- your custom normal mode mappings
--				},
--			},
--		},
--	},
--}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

--vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Alternatively, using lua API
--vim.keymap.set("n", "<space>fb", function()
--		require("telescope").extensions.file_browser.file_browser()
--	end)


--local builtin = require("telescope.builtin")
--local utils = require("telescope.utils")
--
--vim.keymap.set("n", "<space>ff", function()
--		builtin.find_files({ cwd = utils.buffer_dir() })
--	end)

---------------------------------------TELESCOPE_END------------------------------------------------



---------------------------------------NVIM_OIL_START------------------------------------------------

require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you still want to use netrw.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    -- "permissions",
    "mtime",
	{"size",highlight = "Special"},
    "icon",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
	winbar = "%{v:lua.require('oil').get_current_dir()}",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = false,
  lsp_file_methods = {
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  experimental_watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names in a more intuitive order for humans. Is less performant,
    -- so you may want to set to false if you work with large directories.
    natural_order = true,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<space>-" , function()
	  vim.cmd("vsplit | wincmd l")
	    require("oil").open()
	end)
---------------------------------------NVIM_OIL_END------------------------------------------------


