--test
-- This file is main setting of neovim. Keep It Clean...
-- 基本設定
vim.o.langmenu = "en_US.UTF-8"
vim.env.LANG = "en_US.UTF-8"
vim.api.nvim_command("set encoding=utf-8")
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileformats = "unix"
--vim.o.ambiwidth = 'double'				-- 全角は二つ分で表示(->有効化してはならない)
vim.o.number = true                                -- 行番号表示
vim.o.relativenumber = true                        -- 相対行番号表示
vim.o.tabstop = 2                                  -- タブの幅
vim.o.expandtab = true                             -- 上のタブ幅の有効化
vim.o.softtabstop = 1                              -- インデントに使用するスペースの数
vim.o.autoindent = true
vim.o.shiftwidth = 2                               -- シフト幅
vim.o.autoindent = true
vim.o.cursorline = true                            -- 行線表示
vim.o.colorcolumn = "80"                           -- 列線表示
vim.o.directory = "./"                             -- swap file place
vim.o.smartindent = true                           -- mk indent according to the block
--vim.o.guifont="default:h20"
vim.o.guifont = "CaskaydiaMono Nerd Font Mono:h11" --Font
vim.o.guifontwide = "30"
vim.o.hlsearch = true                              --high light for search
--local setting
vim.opt.undofile = true
vim.opt.autochdir = true          --change the work directory automatically
vim.opt.wrap = false              --set no wrap
vim.opt.wrap = false              --set no wrap
vim.opt.inccommand = "split"      --??
vim.opt.clipboard = "unnamedplus" --use clipboard
local option = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  undofile = true,
  undodir = "~/.config/nvim",
}
vim.loader.enable()

-- キーマッピング
vim.api.nvim_set_keymap("n", "<Space>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })
--colorscheme
--

-------------------------------------------------------------------------------
--plugin management (lazy.nvim)
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require("lazy").setup({
  {
    "adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    --keys={"<Leader>;;",":NvimTreeOpen", disc="open tree"},
    --event="VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    },
  },
  { "lervag/vimtex",        ft = { "tex" } },
  { "jxnblk/vim-mdx-js",        ft = { "mdx","md" } },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    version = "*",
    config = true,
    keys = { "<Leader>tt", ":ToggleTerm", disk = "open terminal" },
  },
  { "itchyny/lightline.vim" },
  {
    "folke/tokyonight.nvim",
    event = "VimEnter",
    priority = 1000,
    opts = require("plugins.tokyonight"),
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, --this is equalent to setup ({}) fundtion
  },
  {
    "preservim/nerdcommenter",
    event = "VimEnter",
  },
  --{"lambdalisue/glyph-palette.vim"},
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.5",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VimEnter",
  },

  {
    "uga-rosa/ccc.nvim",
    event = "VimEnter",
    opt = require("plugins.ccc"),
  }, --colorlize.luaなんてのもあるようです
  --{"BurntSushi/ripgrep"},
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
  },
  {
    "neovim/nvim-lspconfig",
    event = "VimEnter",
  }, --lsp
  {
    "williamboman/mason.nvim",
    event = "VimEnter",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VimEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "williamboman/mason.nvim" },
  },
  --compilation:ddcを使おうとしていたが挫折
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",
  },
  {
    "hrsh7th/vim-vsnip",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",
  },
  {
    "mhartington/formatter.nvim",
    event = "InsertLeave",
  },
  --{"vim-skk/skkeleton",event="InsertEnter"},
  {
    "pocco81/auto-save.nvim",
    event = "VimEnter",
  },
  {
    "junegunn/rainbow_parentheses.vim",
    event = "VimEnter",
  },
  {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("alpha").setup(require("alpha.themes.theta").config)
    end,
  },

  {
    "romgrk/barbar.nvim",
    event = "VimEnter",
    dependencies = {
      "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = false,
      -- insert_at_start = true,
      -- …etc.
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
  {
    "Shatur/neovim-session-manager",
    event = "VimEnter",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
  },
  {
    "echasnovski/mini.indentscope",
    event = "VimEnter",
  },
  {
    "EEprotocol/Arduineovim",
    event = "VimEnter",
  },
  { "EEprotocol/Arduineovim" },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VimEnter",
  },

  { "EEprotocol/Arduineovim" },
  { "skanehira/preview-markdown.vim" },
  --{ "ray-x/navigator.lua" },
  { "ray-x/guihua.lua" },
  { "ray-x/web-tools.nvim" },
})
-------------------------------------------------------------------------------
--Arduienovim
-------------------------------------------------------------------------------
require("arduineovim").setup()
-------------------------------------------------------------------------------
--Markdown previewer (peek)
-------------------------------------------------------------------------------
require("peek").setup({
  auto_load = true,        -- whether to automatically load preview when
  -- entering another markdown buffer
  close_on_bdelete = true, -- close preview window on buffer delete

  syntax = true,           -- enable syntax highlighting, affects performance

  theme = "dark",          -- 'dark' or 'light'

  update_on_change = true,

  app = "webview", -- 'webview', 'browser', string or a table of strings
  -- explained below

  filetype = { "markdown" }, -- list of filetypes to recognize as markdown

  -- relevant if update_on_change is true
  throttle_at = 200000,   -- start throttling when file exceeds this
  -- amount of bytes in size
  throttle_time = "auto", -- minimum amount of time in milliseconds
  -- that has to pass before starting new render
})
-------------------------------------------------------------------------------
--LSP setting
-------------------------------------------------------------------------------
-- lspのハンドラーに設定
capabilities = require("cmp_nvim_lsp").default_capabilities()

--mason setting
require("mason").setup()
--mason config
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "texlab", "pyright", "arduino_language_server", "clangd" }
}
--[[require("mason-lspconfig").setup{
]]
-- launch-test.lua
--require("mason-lspconfig").setup_handlers({
--  require("lspconfig").lua_ls.setup({}),
--  require("lspconfig").pyright.setup({}),
--  require("lspconfig").texlab.setup({}),
--  require("lspconfig").arduino_language_server.setup({}),
--  require("lspconfig").typescript_language_server.setup({}),
--//})
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

lspconfig.clangd.setup {
  root_dir = function(fname)
    return util.root_pattern('compile_commands.json', '.git')(fname)
        or vim.fn.getcwd()
  end
}
-- lspの設定後に追加)
vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-tab>"] = cmp.mapping.select_prev_item(),
    ["<tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})


-------------------------------------------------------------------------------
--navigator
-------------------------------------------------------------------------------
--require("navigator").setup({
--  mason = true,
--})
-------------------------------------------------------------------------------
--arduino
-------------------------------------------------------------------------------
---arduino setup
--[[require("mason-lspconfig").setup_handlers({
require("lspconfig").arduino_language_server.setup {
  capabilities = capabilities,
  cmd = {
    "arduino-language-server",
    " -cli-config",
    " ~/Appdata/Local/Arduino15/arduino-cli.yaml",
    "-cli",
    "arduino-cli",
    "-clangd",
    "clangd",
    "-fqbn",
    "arduino:avr:uno",
  },
  -- root_dir = lspconfig.util.find_git_ancestor,
    filetypes = { "arduino", "ino" },
    print("arduino lsp started.")
}--require("arduineovim").setup()
})]]
-------------------------------------------------------------------------------
--snippet settings
-------------------------------------------------------------------------------
--
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

--global function for new line
function Nl()
  return t("", "")
end

local LuaMS = require("snips.lua")
LuaMS:loader()
local texMS = require("snips.tex")
texMS:loader()
-------------------------------------------------------------------------------
--Formatter settings
-------------------------------------------------------------------------------
-- Utilities for creating configurations
local util = require("formatter.util")
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
local biome = function()
  return {
    exe = "npx",
    args = {
      "biome",
      "format",
      "--indent-width=4",
      "--indent-style=tab",
      -- `--stdin-file-path`の後にutil.escape_path(...)が来るようにする
      "--stdin-file-path",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
  }
end

require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = { biome },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end
    },

  markdown = {},
  md = {},
  mdx = {},
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      -- require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  command = "silent! FormatWrite",
})

-------------------------------------------------------------------------------
--Start Setting (goolord/alpha-nvim)
-------------------------------------------------------------------------------
local math = require("math")
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local pikachu = {

  [[          ▀████▀▄▄              ▄█ ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
  [[   █   █  █      ▄▄           ▄▀   ]],
}

--dashboard.header_color ="AlphaCol".. math.random(11)
dashboard.header_color = "#593822"
local another = {

  [[          ▂▟▙▂   ]],
  [[       ▂▄▆██▛ ▚▂▁]],
  [[       ▛▀▀　　▝▜█▆▃]],
  [[　　　▞]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
  [[]],
}

local prop = {
  [[　　　　←       ]],
  [[　　　　∧_∧			]],
  [[　　 ∧_∧･ω･`)　↑]],
  [[↓　( ･ω･`)･ω･`) ]],
  [[　 く|　⊂)ω･`)  ]],
  [[　　 (⌒　ヽ･`)  ]],
  [[　　 ∪￣＼⊃     ]],
}
local jigen = {
  [[                                            (X                       ]],
  [[                                      (J13JZ1vG                      ]],
  [[					                   ((-+<~(1.JwS3JXWfcX3                    ]],
  [[					              (.zHwZ(H6JXuOXdZuWZdfUVoJ__                  ]],
  [[					              (HZA4WYJGXYjGH6dXHSJ=_J3~jz-_                ]],
  [[					               (S<W>SddtdGd1Ywv!.~~(l(v(C(7OJ-~            ]],
  [[				                 _(fTTT?!7?<?<~.~~~.__(-v1J<(v(JT&._         ]],
  [[					               (J<_._~........-.~_..-1(3(v-JCJ<++?ZJ+_     ]],
  [[					             _J43~....~~.......~._(?!_GZ>JIz1vuwJ<J1vZI+(-_]],
  [[					           (v1J!T+~~~...~....~_(J=.(vv7<?~1v(JC<J1vzwI_-^  ]],
  [[					       (JCv~J^_-=(9._~~_~.~_(J=-_-JO>-J!-v<J!(JCzO71x7!    ]],
  [[					   (-?v-J!(C_-=(v~(v?G-(c~(=(Jv_JwC_(>(ciJ^.JCzV1-7~       ]],
  [[					(u,.(>(C(J~(=(v~(v_-=-J1/<(Ov_JwO<(C(z<J^(v=.(J>_          ]],
  [[					   7Tu.(=(C(Z^.v~J=(J&C_-Ov~JXXv(C(J1J=_J3.(dwk_           ]],
  [[					       ?T5J<(J:J3(vu=-JOZ!(KUCjv~J=(f!--zI(kw1d2           ]],
  [[					            TnJ-7~Y<J3dz>(WVjv!_d! .J7jZ!..(kWXXo          ]],
  [[					            ~kSvz4qS-(J:(X<JC..(J7>>(DV~.`..0HSwIn,        ]],
  [[					            (KS2(f777T<<~_-(?6(u&(+--k:....(UX0zSv-1,      ]],
  [[					           (WXkHWS_▒▒▒▒_77▒▒▒▒▒▒▒.`.WV_...-uXVUTuww+?_     ]],
  [[					          (1WHHHR_1▒▒▒▒J_▒▒▒▒▒▒▒▒▒▒,S>-(JZJWVGJZCvT<-      ]],
  [[					         (5udMW9dKj░░░(-░░░░░░░░░░░dS-JwwXYjV+wwUVXZ$_     ]],
  [[					          _&X8dq9dK    (~         JW0Oz VwZuwXX=iwi-       ]],
  [[					    ._     _4vTWHW%           _  (GWXX VXXZXXXJwZwwS~      ]],
  [[					     (n.(,   4(HWf~  __.___---  ($wXX s3ZTXV1X0o?~         ]],
  [[					      (4C(Ya&(Z9d!    +-       -v(vGd +zjY=?=~             ]],
  [[					      (<JA0G?+uX3--.-_(G_     k((Z(3.                      ]],
  [[					       ?5RJjkk0wkZvvXHXd<((((JCJ>J!                        ]],
  [[					        ((kX0WWWGwGXHXkXkZ0ZZJJ$J                          ]],
  [[					            ?TAXYOHkWWkXWXX0ZjY=                           ]],
  [[					              ?<<<IJSUJ6whZ"=                              ]],
  [[					                                                           ]],
  [[					            NeoVim-Qt v.0.9.4 started                      ]],
}

local major = vim.version()["major"]
local minor = vim.version()["minor"]
local patch = vim.version()["patch"]
local nvim_version = "v" .. major .. "." .. minor .. "." .. patch
local jigen2 = {
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⢋⠏⡁⡻⣿            ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⢻⠏⡿⠻⠂⡃⢑⠌⠀⠀⢐⡼⣿          ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⡍⡂⠔⡡⡊⢐⢕⡀⠐⠁⢠⣲⣽⢢⡶⡙⣿         ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣎⣒⣉⣠⣪⣢⣌⣤⣶⣿⣿⣿⡼⢌⣜⡵⢣⠭⣛⢿     ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣳⣋⢚⠕⠫⡪⡪⡪⡮⡍⡻⠿ ]],
  [[⣿⣿⣿⣿⣿⣿⠿⣫⢕⣵⢝⢿⣿⣿⣿⣿⣿⣿⡿⣛⣵⡞⢍⡥⢿⡆⡰⢚⡠⡊⠈⠨⡨⢞⣵]],
  [[⣿⣿⢿⡛⣩⢦⣿⣵⢟⡵⣫⢖⣝⠻⠟⡻⣟⠽⢊⡽⠋⣰⢟⡴⡫⢊⡴⢫⢂⡠⣚⣽   ]],
  [[⣿⣽⢻⠞⡽⣫⢞⡵⣫⢞⡵⣋⡶⠫⣪⢞⢕⡵⠋⢀⢖⡵⡫⢊⡴⢫⡾⠛⢵⣿     ]],
  [[⣿⣿⣿⣿⣶⣥⣟⡾⣡⢋⢜⠕⡴⢟⠑⣵⠋⢄⢔⣵⢫⣞⡠⢟⣇⣧⡁⠐⠁⢿     ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⠑⢌⣽⢛⡴⠗⣵⣃⡔⣱⡿⣗⣫⡽⡌⢡⣾⣿⣿⠄⠀⡨⡻    ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣟⠔⠐⠃⣾⣶⣾⣷⣿⣿⣷⣯⣬⣭⣬⠁⣺⣿⣿⠳⠀⠈⡨⠊⢪⣻  ]],
  [[⣿⣿⣿⣿⣿⣿⢟⡂⠀⠀⠼⠞⣿⣿⣳⣿⣿⣿⣿⣿⣿⡟⢀⡛⢋⠕⢀⢄⠄⠄⠴⠛⢿  ]],
  [[⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠔⢱⣿⣿⣾⣿⣿⣿⣿⣿⣿⠁⡠⠀⠀⠀⠅⠁⢀⠔⢁⢿   ]],
  [[⣿⣿⣿⣟⢿⡿⣿⣷⡱⡀⠀⣾⣿⣿⣿⣿⡿⢟⣽⣿⠣⠀⠀⠀⠀⡀⢀⠄⠁⣄⣥⣼   ]],
  [[⣿⣿⣿⡿⢮⡘⠔⡹⡃⠀⢸⣿⣿⣯⢽⣿⣿⣿⣿⣯⡎⣆⣥⣭⣬⣴⣷⣶⣿      ]],
  [[⣿⣿⣿⣿⣮⣄⡊⠊⠀⠄⠄⠚⠍⠡⠡⠟⢛⡛⢯⢋⢮⣾             ]],
  [[⣿⣿⣿⣿⣿⣿⣦⣴⡒⠄⡁⠀⠀⠀⠀⠀⠀⠈⢀⣶               ]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣶⣿⣤⣾⣤⣬⣷⣾                 ]],
  [[]],
  [[	     Neovim ]] .. nvim_version .. [[ started!!]],
}
--used img2art in python
dashboard.section.header.val = jigen2

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("b", "󰑙  Back to the Session", ":SessionManager load_last_session<CR>:set autochdir<CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
  dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e$MYVIMRC<CR><Shift>U<CR>"),
  dashboard.button("u", "󰮭  Lazy", ":Lazy<CR><Shift-u>"),
  dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
}

local function footer()
  return "New era is coming...!"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("b", "󰑙  Back to the Session", ":SessionManager load_last_session<CR>:set autochdir<CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
  dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR><Shift>U<CR>"),
  dashboard.button("u", "󰮭  Lazy", ":Lazy<CR><Shift-u>"),
  dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
}

local function footer()
  return "New era is coming...!"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

-------------------------------------------------------------------------------
--Filer setup (nvim-tree)
-------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--optionally enable 24-bit colour
vim.opt.termguicolors = true
--empty setup using defaults

--OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-------------------------------------------------------------------------------
--Color Scheme (tokyonight)
-------------------------------------------------------------------------------
--tokyonight setting
--"./lua/plugins/tokyonight.lua"
vim.cmd([[colorscheme tokyonight]])

--CCC setting
--"./lua/plugins/ccc.lua"

--ToggleTerm setting
require("toggleterm").setup({
  open_mapping = [[<c-\>]],
})

--lightline setting
vim.cmd([[
let g:lightline = {
       \ 'colorscheme': 'wombat',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
       \ },
       \ 'component_function': {
       \   'gitbranch': 'FugitiveHead'
       \ }
       \ }
]])

-------------------------------------------------------------------------------
--Autosave(pocco81/auto-save)
-------------------------------------------------------------------------------
require("auto-save").setup({
  enabled = false, -- start NOT auto-save when the plugin is loaded (i.e. when your package manager loads it)

  --vim.api.nvim_get_option_info2なんてのもあるらしい
  --[[vim.api.nvim_create_autocmd({'BufEnter',"Filetype"},
		{
			pattern="*.tex",
			callback=function()
			if vim.o.filetype == "tex" then
				vim.cmd("ASToggle")
			end
		end
		}),]]

  execution_message = {
    message = function() -- message to print on save
      return ("AutoSave: saved at " .. vim.fn.strftime("%Y/%b/%d %H:%M:%S"))
    end,
    dim = 0.18,                                      -- dim the color of `message`
    cleaning_interval = 1250,                        -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
  -- function that determines whether to save the current buffer or not
  -- return true: if buffer is ok to be saved
  -- return false: if it's not ok to be saved
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")

    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
      return true                -- met condition(s), can save
    end
    return false                 -- can't save
  end,
  write_all_buffers = false,     -- write all buffers when the current one meets `condition`
  debounce_delay = 135,          -- saves the file at most every `debounce_delay` milliseconds
  callbacks = {                  -- functions to be executed at different intervals
    enabling = nil,              -- ran when enabling auto-save
    disabling = nil,             -- ran when disabling auto-save
    before_asserting_save = nil, -- ran before checking `condition`
    before_saving = nil,         -- ran before doing the actual save
    after_saving = nil,          -- ran after doing the actual save
  },
})
vim.api.nvim_set_keymap("n", "<leader>as", ":ASToggle<CR>", {})

vim.cmd("ASToggle")

-------------------------------------------------------------------------------
--Session (Shatur/session_manager)
-------------------------------------------------------------------------------
local Path = require("plenary.path")
local config = require("session_manager.config")
require("session_manager").setup({
  sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
  session_filename_to_dir = session_filename_to_dir,           -- Function that replaces symbols into separators and colons to transform filename into a session directory.
  dir_to_session_filename = dir_to_session_filename,           -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
  autoload_mode = config.AutoloadMode.Disabled,                -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_last_session = true,                                -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true,                           -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_dirs = {},                                   -- A list of directories where the session will not be autosaved.
  autosave_ignore_filetypes = {                                -- All buffers of these file types will be closed before the session is saved.
    "gitcommit",
    "gitrebase",
  },
  autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})
-------------------------------------------------------------------------------
--Where is changed (gitsigns)
-------------------------------------------------------------------------------
require("gitsigns").setup({
  signs = {
    add = { text = "󱋱" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,  -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})
-------------------------------------------------------------------------------
-- indent viewer (mini.indentscope)
-------------------------------------------------------------------------------
require("mini.indentscope").setup({

  -- Draw options
  draw = {
    -- Delay (in ms) between event and start of drawing scope indicator
    delay = 100,

    -- Animation rule for scope's first drawing. A function which, given
    -- next and total step numbers, returns wait time (in ms). See
    -- |MiniIndentscope.gen_animation| for builtin options. To disable
    -- animation, use `require('mini.indentscope').gen_animation.none()`.
    --<function: implements constant 20ms between steps>,

    -- Symbol priority. Increase to display on top of more symbols.
    priority = 2,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope = "ii",
    object_scope_with_border = "ai",

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = "[i",
    goto_bottom = "]i",
  },

  -- Options which control scope computation
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = "both",

    -- Whether to use cursor column when computing reference indent.
    -- Useful to see incremental scopes with horizontal cursor movements.
    indent_at_cursor = true,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = false,
  },

  -- Which character to use for drawing scope indicator
  symbol = "╎",
})

-------------------------------------------------------------------------------
-- htmlviewer (ray-x/web-tools.nvim)
-------------------------------------------------------------------------------
require 'web-tools'.setup({
  keymaps = {
    rename = nil,         -- by default use same setup of lspconfig
    repeat_rename = '.',  -- . to repeat
  },
  hurl = {                -- hurl default
    show_headers = false, -- do not show http headers
    floating = false,     -- use floating windows (need guihua.lua)
    json5 = false,        -- use json5 parser require json5 treesitter
    formatters = {        -- format the result by filetype
      json = { 'jq' },
      html = { 'prettier', '--parser', 'html' },
    },
  },
})
-------------------------------------------------------------------------------
-- tab (romgrk/barbar.nvim)
-------------------------------------------------------------------------------
-- Set the filetypes which barbar will offset itself for
require 'barbar'.setup {
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {
      text = 'undotree',
      align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
    },
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = { event = 'BufWipeout' },
    -- Or, specify all three
    Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
  },


}
-------------------------------------------------------------------------------
-- プラグインのキーマッピング (例: telescope)
-------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", {
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<Leader>d", "\"_d", {
  noremap = true,
  silent = true,
})


vim.api.nvim_set_keymap("n", "<Leader>;;", "<cmd>NvimTreeOpen<CR>", {
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap(
  "n",
  "<Leader>tt",
  "<cmd>ToggleTerm direction=horizontal size=12 name=here<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>",
  {
    noremap = true,
    silent = true, --再帰的マッピング無効化　エラー表示なし
  }
)
local window_width = vim.api.nvim_get_option('columns') * 0.4
vim.api.nvim_set_keymap(
  "n",
  "<Leader>vtt",
  "<cmd>ToggleTerm direction=vertical size=" ..
  window_width .. " name=here<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>",
  {
    noremap = true,
    silent = true, --再帰的マッピング無効化　エラー表示なし
  }
)
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true }) --terminal normalmode
vim.api.nvim_set_keymap("t", "<c-[>", "<C-\\><C-n>", { noremap = true }) --terminal normalmode
--ターミナル分割は2<C-\>でできます！

-- python3のパスを取得する
-- pythonのパスを取得する
local python3_path
local python_path
if vim.fn.has("win32") == 1 then
  python3_path = vim.fn.trim(vim.fn.system("gcm python3"))
  python_path = vim.fn.trim(vim.fn.system("gcm python"))
else
  python3_path = vim.fn.trim(vim.fn.system("which python3"))
  python_path = vim.fn.trim(vim.fn.system("which python"))
end

-- g:python3_host_progにpython3のパスを設定する
vim.g.python3_host_prog = python3_path
-- g:loaded_python3_providerを設定する
vim.g.loaded_python3_provider = 0


-------------------------------------------------------------------------------
--javascript Formatter
-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.js",
  callback = function()
    vim.cmd("silent !npx prettier --write %")
  end,
})

-------------------------------------------------------------------------------
--VimTex
-------------------------------------------------------------------------------
vim.g.vimtex_view_method = 'okular'
vim.g.vimtex_view_general_viewer = 'okular'

--[[if os.getenv("VIRTUAL_ENV") then
    local python_executable = ""
    local virtual_env_bin_python = os.getenv("VIRTUAL_ENV") .. "/bin/python3"
    if vim.fn.filereadable(virtual_env_bin_python) ~= 0 then
        python_executable = vim.fn.substitute(vim.fn.system("which python"), '\n', '', 'g')
    else
        python_executable = vim.fn.substitute(vim.fn.system("which python"), '\n', '', 'g')
    end
    if python_executable ~= "" then
        vim.g.python3_host_prog = python_executable
    end
end]]


-- Lua内でコマンドラインモードのマッピングを定義する例
vim.api.nvim_create_autocmd('CmdlineEnter', {
  pattern = 'w!!',
  callback = function()
    vim.cmd('cnoremap <expr> w!! v:cmd ? "silent! write !sudo tee % >/dev/null<CR> | edit!" : "w!!"')
  end,
})


vim.keymap.set(
  'c',
  'w!!',
  'w !sudo tee > /dev/null %<CR>:e!<CR>',
  { noremap = true, silent = false }
)

vim.g.terminal_emulator='foot'
vim.o.shell="/bin/zsh"

-------------------------------------------------------------------------------
--これからやっておくべきこと
-------------------------------------------------------------------------------
--✓スニペット構成(とくにTeXのbegin-endらへんの話)(->environment入力はできる)
--GITブランチの表示
--✓自動補完機能(->snippetは接続だけしました)
--✓変更箇所表示(gitみたいな縦線)(->gitsigns)
--コマンド設定
--✓texの構成(->あとはちまちまスニペット構成)
--✓ワークスペース構成(->sessionにより解決)
--フォーマッタ構成--> sedの機嫌が悪い
--✓フォントサイズ調整in qt(->フォント末尾のオプション)
--lightline改善，ファイル読み込みとかワークスペースとか
--gitも何とかしよう
--✓変数が使われてるかどうかの表示(->どうやらLSPで自動的に行われているよう)
--@windows ターミナル：powershellへ
--✓オープニング画面とかつけたい，VScode的な,nvchad的な(->alpha)
--✓自動保存に役立つ何か(->autosave)
--✓コピペはクリップボードに一元化したい-->なんか上の方に書いてある
--✓ファイルタイプ別のプラグイン呼び出し設定(->Lazy option)
--起動高速化(->plugin設定を別に移す)
--タブも何とかしてえ(->要操作性向上)-->コマンドを設定せねば
--✓lspらへんの話の整理(->割と整った感はある，Masonのおかげ)
--Arduinoやその他の言語についての補完設定
--✓不要行間表示(->あんまいらんな．変なスペースがある行はLSPで表示されるようです)
--✓新しく開くファイルはタブで開く,だけどvスプリットさせたい(->toggleterm,ctrl-v)
--✓ターミナル分割(->num+<ctrl><Leader>)
--✓インデントラインを引く(->miniline?)
--リロードコマンドを組む
--toggleterm常時更新
--変数一覧表示in python
--rename command(->:saveas?)
--✓nvim-tree devicons表示(->Fernから乗り換え)
