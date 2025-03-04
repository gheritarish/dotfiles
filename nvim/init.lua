local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.loader.enable()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- panels
    use 'ldelossa/nvim-ide'

    -- git
    use 'lewis6991/gitsigns.nvim'

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use "stevearc/conform.nvim"
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'onsails/lspkind.nvim',
    }

    -- indent line
    use "lukas-reineke/indent-blankline.nvim"

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } , { 'kdheepak/lazygit.nvim' } } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    -- Rainbow Highlighting
    use {
        "HiPhish/nvim-ts-rainbow2",
        "HiPhish/rainbow-delimiters.nvim"
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Typst
    use {'kaarmu/typst.vim', ft = {'typst'}}

end)

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#CC241D" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#D79921" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#458588" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98971A" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#B16286" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#689D6A" })
end)

-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

-- Typst
vim.g.typst_pdf_viewer = "zathura"

require("ibl").setup {
    indent = {
        char = "▏",
        highlight = highlight
    },
    scope = { enabled = false }
}

--Set colorscheme
vim.opt.background = "dark" -- or "light" for light mode
-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = 1
-- -- Enable transparent mode
vim.g.gruvbox_baby_transparent_mode = 1
vim.cmd([[colorscheme gruvbox-baby]])

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "rust", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

   rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = { "jsx", "cpp", "markdown" },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require 'ts-rainbow.strategy.global',
    -- Do not enable for files with more than n lines
    max_file_lines = 3000,
    hlgroups = {
      'TSRainbowYellow',
      'TSRainbowBlue',
      'TSRainbowOrange',
      'TSRainbowGreen',
      'TSRainbowRed',
      'TSRainbowViolet',
      'TSRainbowCyan',
    },
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust", "markdown", "sql", "gitcommit", "htmldjango", "git", "diff", "vim" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = function(lang, buf)
        --local max_filesize = 100 * 1024 -- 100 KB
        --local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --if ok and stats and stats.size > max_filesize then
            --return true
        --end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup {
    borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { " " },
    },
    defaults = {
        mappings = {
            ["i"] = {
                ["<C-u>"] = false,
                ["<C-s>"] = actions.cycle_previewers_next,
                ["<C-a>"] = actions.cycle_previewers_prev,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        }
    },
    file_browser = {
        theme = "catppuccin",
        hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
        mappings = {
            ["i"] = {
                -- your custom insert mode mappings
            },
            ["n"] = {
                -- your custom normal mode mappings
            },
        },
    },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension("file_browser")
require("telescope").load_extension("lazygit")
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>sf', function()
    require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
    require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
vim.api.nvim_set_keymap(
    "n",
    "<space>fb",
    ":Telescope file_browser<CR>",
    { noremap = true }
)

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pylsp" }
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>n', vim.lsp.buf.references, bufopts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- require('lspconfig')['pyright'].setup{
     -- on_attach = on_attach,
     -- flags = lsp_flags,
-- }
-- :PylspInstall pyls-flake8 pylsp-mypy pyls-isort
require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                flake8 = { enabled = false },
                rope_autoimport = { enabled = false, memory = true },
                rope_completion = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                mypy = { enabled = false },
                pyflakes = { enabled = false },
                ruff = { enabled = true },
                isort = { enabled = false },
            },
        },
    },
}

require('lspconfig')['ruby_lsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        ruby_lsp = {
            diagnostics = true,
            completion = true
        }
    },
    capabilities = capabilities
}

require("conform").setup({
  formatters_by_ft = {
    -- Conform will run multiple formatters sequentially
    python = { "black", "ruff" },
    ruby = { "rubocop" },
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>f",
    ":Format<CR>",
    { noremap = true }
)

local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    formatting = {
         format = lspkind.cmp_format {
            with_text = true,
            mode = 'symbol_text',
            menu = {
               buffer   = "[buf]",
               nvim_lsp = "[LSP]",
               path     = "[path]",
            },
        },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-Tab>'] = cmp.mapping.select_next_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    })
})

local function getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" or vim.bo.filetype == "rst" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      if vim.fn.wordcount().words == 1 then
        return tostring(vim.fn.wordcount().words) .. " word"
      else
          return tostring(vim.fn.wordcount().words) .. " words"
      end
    end
  else
    return ""
  end
end

require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'catppuccin',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = { {'filename', path=1}},
      lualine_x = {'searchcount', 'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress', getWords},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { {'filename', path=1}},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
        lualine_a = {},
        lualine_b = {{'filetype', icon_only = true}},
        lualine_c = {{'filename', path=1}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }


require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '   > <author>, <author_time:%Y-%m-%d> • <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  }
}
vim.cmd([[highlight GitGutterChange guifg=#b16286]])


-- default IDE components
local bufferlist      = require('ide.components.bufferlist')
local explorer        = require('ide.components.explorer')
local outline         = require('ide.components.outline')
local callhierarchy   = require('ide.components.callhierarchy')
local timeline        = require('ide.components.timeline')
local terminal        = require('ide.components.terminal')
local terminalbrowser = require('ide.components.terminal.terminalbrowser')
local changes         = require('ide.components.changes')
local commits         = require('ide.components.commits')
local branches        = require('ide.components.branches')
local bookmarks       = require('ide.components.bookmarks')

require('ide').setup({
    -- The global icon set to use.
    -- values: "nerd", "codicon", "default"
    icon_set = "default",
    -- Set the log level for nvim-ide's log. Log can be accessed with
    -- 'Workspace OpenLog'. Values are 'debug', 'warn', 'info', 'error'
    log_level = "info",
    -- Component specific configurations and default config overrides.
    components = {
        -- The global keymap is applied to all Components before construction.
        -- It allows common keymaps such as "hide" to be overridden, without having
        -- to make an override entry for all Components.
        --
        -- If a more specific keymap override is defined for a specific Component
        -- this takes precedence.
        global_keymaps = {
            -- example, change all Component's hide keymap to "h"
            -- hide = h
        },
        -- example, prefer "x" for hide only for Explorer component.
        -- Explorer = {
        --     keymaps = {
        --         hide = "x",
        --     }
        -- }
    },
    -- default panel groups to display on left and right.
    panels = {
        right = "git"
    },
    -- panels defined by groups of components, user is free to redefine the defaults
    -- and/or add additional.
    panel_groups = {
        git = { changes.Name, commits.Name }
    },
    -- workspaces config
    workspaces = {
        -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
        auto_open = 'none',
    },
    -- default panel sizes for the different positions
    panel_sizes = {
        left = 30,
        right = 90,
        bottom = 15
    }
})
