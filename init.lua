-- This file si main setting of neovim. Keep It Clean...
-- 基本設定
vim.o.number = true               -- 行番号表示
vim.o.relativenumber = true       -- 相対行番号表示
vim.o.tabstop = 2                 -- タブの幅
vim.o.softtabstop = 2             -- インデントに使用するスペースの数
vim.o.shiftwidth = 2              -- シフト幅
vim.o.cursorline = true						-- 行線表示
vim.o.colorcolumn = "80"		  		-- 列線表示
vim.o.directory="./"							-- swap file place
vim.o.smartindent=true            -- mk indent according to the block
--vim.o.guifont="default:h20"
vim.o.guifont="CaskaydiaMono Nerd Font Mono:h13"--Font
vim.o.guifontwide="30"
vim.o.hlsearch=true								--high light for search
--local setting
vim.opt.undofile=true
local option={
	encoding="utf-8",
	fileencoding="utf-8",
	undofile=true,
	undodir="~/.config/nvim"
}

-- キーマッピング
vim.api.nvim_set_keymap('n', '<Space>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
--colorscheme
--
-------------------------------------------------------------------------------
--Luaのお勉強
-------------------------------------------------------------------------------
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
require("lazy").setup(
	{
		{"nvim-tree/nvim-tree.lua"},
		{"nvim-tree/nvim-web-devicons"},
		{"lervag/vimtex",ft={"tex"}},
		{"akinsho/toggleterm.nvim",
		version="*",
		config=true
		},
		{"itchyny/lightline.vim"},
		{"folke/tokyonight.nvim",
		lazy=true,
		cmd="ToggleTerm",
		priority=1000,
		opts={}
		},
		{"windwp/nvim-autopairs",
		event="InsertEnter",
		opts={}--this is equalent to setup ({}) fundtion
		},
		{"preservim/nerdcommenter"},
		{"lambdalisue/fern.vim"},
		{"lambdalisue/glyph-palette.vim"},
		{"nvim-lua/plenary.nvim"},
		{"nvim-telescope/telescope.nvim", tag='0.1.5'},
		{"nvim-telescope/telescope-file-browser.nvim"},
    {"uga-rosa/ccc.nvim"},
		{"BurntSushi/ripgrep"},
		{"nvim-treesitter/nvim-treesitter"},
    {"neovim/nvim-lspconfig"},--lsp
    {"williamboman/mason.nvim",lazy=true, },
    {"williamboman/mason-lspconfig.nvim",lazy=true,},
		--compilation:ddcを使おうとしていたが挫折
		{ "L3MON4D3/LuaSnip",
		version="v2.*",
		build="make install_jsregexp",
		dependencies="saadparwaiz1/cmp_luasnip",
		event="InsertEnter"
		},
		{ "hrsh7th/nvim-cmp",event="InsertEnter" },
		{ "hrsh7th/cmp-nvim-lsp",event="InsertEnter"},
		{"hrsh7th/vim-vsnip",event="InsertEnter"},
		{ "hrsh7th/cmp-buffer",event="InsertEnter"},
		{"mhartington/formatter.nvim"},
		{"vim-skk/skkeleton",event="InsertEnter"},
		{"pocco81/auto-save.nvim"},
		{"natecraddock/workspaces.nvim"},
		{"dstein64/vim-startuptime"},
		{
    'goolord/alpha-nvim',
		event="VimEnter",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.theta'.config)
    end
		},

		{"romgrk/barbar.nvim",dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = true end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
		},
		{"Shatur/neovim-session-manager"}
	}
)
-------------------------------------------------------------------------------
--Luaのお勉強
-------------------------------------------------------------------------------
local function filetype()
	if vim.bo.filetype =="tex" then
		return "tex"
	else
		return "other"
	end
end

-------------------------------------------------------------------------------
--LSP setting
-------------------------------------------------------------------------------
-- lspのハンドラーに設定
capabilities = require("cmp_nvim_lsp").default_capabilities()

--mason setting
require("mason").setup()
--mason config
require("mason-lspconfig").setup{
	ensure_installed={"lua_ls","texlab","pyright","arduino_language_server"}
}
-- launch-test.lua
require"lspconfig".lua_ls.setup{}
require"lspconfig".pyright.setup{}
require"lspconfig".texlab.setup{}
require"lspconfig".arduino_language_server.setup{}
-- lspの設定後に追加
vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
		end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-tab>"] = cmp.mapping.select_prev_item(),
    ["<tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
		['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' })
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})

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

local function fn(
  args,     -- text from i(2) in this example i.e. { { "456" } }
  parent,   -- parent snippet or parent node
  user_args -- user_args from opts.user_args 
)
   return '[' .. args[1][1] .. user_args .. ']'
end
ls.add_snippets("all", {
		s("trig", {
		i(1), t '<-i(1) ',
		f(fn,  -- callback (args, parent, user_args) -> string
    {2}, -- node indice(s) whose text is passed to fn, i.e. i(2)
    { user_args = { "user_args_value" }} -- opts
		),
		t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0)
		}),
		s("HW", {
			t("Hello,",i(1)," World!",i(1),i(0))
		})
})
--global function for new line
function Nl()
	return t('', '')
end

local LuaMS=require("lua")
	LuaMS:loader()
local texMS=require("tex")
	texMS:loader()
--[[ls.add_snippets("lua",
{
	s("lua",{
		t("haste on"),i(0),t("the moon")
	})
	--require("snippets.luasnip")
}
)]]


--require("luasnip.loaders.from_vscode").lazy_load({paths={"./snippets"}})

-------------------------------------------------------------------------------
--Formatter settings
-------------------------------------------------------------------------------
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}


-------------------------------------------------------------------------------
--Start Setting (goolord/alpha-nvim)
-------------------------------------------------------------------------------
local math=require("math")
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
 return
end

local dashboard = require("alpha.themes.dashboard")
local pikachu={

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
dashboard.header_color ="#593822"
local another={

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

local prop={
[[　　　　←       ]],
[[　　　　∧_∧			]],
[[　　 ∧_∧･ω･`)　↑]],
[[↓　( ･ω･`)･ω･`) ]],
[[　 く|　⊂)ω･`)  ]],
[[　　 (⌒　ヽ･`)  ]],
[[　　 ∪￣＼⊃     ]],
}
local jigen={
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

local jigen2={
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
}
--used img2art in python
dashboard.section.header.val = jigen2

 dashboard.section.buttons.val = {
   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
   dashboard.button("b", "󰑙  Back to the Session", ":SessionManager load_last_session<CR>:set autochdir<CR>"),
   dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
   dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
   dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
   dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR><Shift>U<CR>"),
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

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
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
--Color Scheme
-------------------------------------------------------------------------------
--tokyonight setting
require("tokyonight").setup(
	{
	style="moon",
	transparent=false,
	styles={
		sidebars="transparent",
		floats="transparent"
		},
	sidebars={"qf","help"},
	lualine_bold=true,
	on_colors=function(colors)
		colors.fg_gutter="#ffba00"--number color
		colors.fg_dark="#ff9955"--command line
		colors.comment="#889fdd"--comment out
		colors.fg="#aaccee"--地の文
	end
	}
)
vim.cmd[[colorscheme tokyonight]]

--CCC setting
local ccc = require("ccc")
ccc.setup({
  highlighter = {
    -- Default values
    auto_enable = true,
    max_byte = 100 * 1024,
    filetypes = {},
    excludes = {},
    lsp = true,
  },
})

--ToggleTerm setting
require("toggleterm").setup{
	open_mapping=[[<c-\>]]
}


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
require("auto-save").setup{
	enabled=false,-- start NOT auto-save when the plugin is loaded (i.e. when your package manager loads it)

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
		dim = 0.18, -- dim the color of `message`
		cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
	},
    trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save. See :h events
	-- function that determines whether to save the current buffer or not
	-- return true: if buffer is ok to be saved
	-- return false: if it's not ok to be saved
	condition = function(buf)
		local fn = vim.fn
		local utils = require("auto-save.utils.data")

		if
			fn.getbufvar(buf, "&modifiable") == 1 and
			utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
			return true -- met condition(s), can save
		end
		return false -- can't save
	end,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
	callbacks = { -- functions to be executed at different intervals
		enabling = nil, -- ran when enabling auto-save
		disabling = nil, -- ran when disabling auto-save
		before_asserting_save = nil, -- ran before checking `condition`
		before_saving = nil, -- ran before doing the actual save
		after_saving = nil -- ran after doing the actual save
	}
}
vim.api.nvim_set_keymap("n", "<leader>as", ":ASToggle<CR>", {})

vim.cmd("ASToggle")


-------------------------------------------------------------------------------
--Session (Shatur/session_manager)
-------------------------------------------------------------------------------
local Path = require('plenary.path')
local config = require('session_manager.config')
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
  session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
  dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
  autoload_mode = config.AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
    'gitcommit',
    'gitrebase',
  },
  autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})
-------------------------------------------------------------------------------
-- プラグインのキーマッピング (例: telescope)
-------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>;;', '<cmd>NvimTreeOpen<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>ToggleTerm direction=horizontal size=12 name=here<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>',{
		noremap = true, silent = true --再帰的マッピング無効化　エラー表示なし
})

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})--terminal normalmode
vim.api.nvim_set_keymap('t', '<c-[>', '<C-\\><C-n>', {noremap = true})--terminal normalmode
--ターミナル分割は2<C-\>でできます！

-- python3のパスを取得する
local python3_path = vim.fn.trim(vim.fn.system('which python3'))
-- g:python3_host_progにpython3のパスを設定する
vim.g.python3_host_prog = python3_path
-- g:loaded_python3_providerを設定する
vim.g.loaded_python3_provider = 1

-------------------------------------------------------------------------------
--これからやっておくべきこと
-------------------------------------------------------------------------------
--スニペット構成(とくにTeXのbegin-endらへんの話)
--GITブランチの表示
--✓自動補完機能(->snippetは接続だけしました)
--変更箇所表示(gitみたいな縦線)
--コマンド設定
--texの構成
--ワークスペース構成
--フォーマッタ構成
--フォントサイズ調整in qt
--lightline改善，ファイル読み込みとかワークスペースとか
--gitも何とかしよう
--✓変数が使われてるかどうかの表示(->どうやらLSPで自動的に行われているよう)
--@windows ターミナル：powershellへ
--オープニング画面とかつけたい，VScode的な,nvchad的な
--✓自動保存に役立つ何か
--コピペはクリップボードに一元化したい
--ファイルタイプ別のプラグイン呼び出し設定
--起動高速化
--タブも何とかしてえ
--✓lspらへんの話の整理(->割と整った感はある，Masonのおかげ)
--✓不要行間表示(->あんまいらんな．変なスペースがある行はLSPで表示されるようです)
--新しく開くファイルはタブで開く,だけどvスプリットさせたい
--✓ターミナル分割　
--インデントラインを引く
--リロードコマンドを組む
--toggleterm常時更新
--変数一覧表示python
--✓rename command(->:saveas)
--toggleterm devicons表示
