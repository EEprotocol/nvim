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
vim.o.guifont="CaskaydiaMono Nerd Font Mono"--Font
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
vim.cmd('colorscheme desert')
-------------------------------------------------------------------------------
--lazy...!(plugin)
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
		{"lervag/vimtex",ft={"tex"}},
		{"akinsho/toggleterm.nvim",
		version="*",
		config=true
		},
		{"itchyny/lightline.vim"},
		{"folke/tokyonight.nvim",
		lazy=false,
		priority=1000,
		opts={}
		},
--		{'nvim-lualine/lualine.nvim',
--    dependencies = { 'nvim-tree/nvim-web-devicons' }
--    --	},
		{"windwp/nvim-autopairs",
		event="InsertEnter",
		opts={}--this is equalent to setup ({}) fundtion
		},
		{"preservim/nerdcommenter"},
		{"lambdalisue/fern.vim"},
		{"nvim-lua/plenary.nvim"},
		{"nvim-telescope/telescope.nvim", tag='0.1.5'},
		{"nvim-telescope/telescope-file-browser.nvim"},
    {"uga-rosa/ccc.nvim"},
		{"BurntSushi/ripgrep"},
		{"nvim-treesitter/nvim-treesitter"},
    {"neovim/nvim-lspconfig"},--lsp
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
		--compilation:ddcを使おうとしていたが挫折
		{ "L3MON4D3/LuaSnip",tag="v2.*",dependencies="saadparwaiz1/cmp_luasnip","rafamadriz/friendly-snippets"},
		{ "hrsh7th/nvim-cmp",event="InsertEnter" },
		{ "hrsh7th/cmp-nvim-lsp",event="InsertEnter"},
		{"hrsh7th/vim-vsnip",event="InsertEnter"},
		{ "hrsh7th/cmp-buffer" },
		{ "saadparwaiz1/cmp_luasnip" },
		{"mhartington/formatter.nvim"},
		{"vim-skk/skkeleton"},


		{"natecraddock/workspaces.nvim"}
	}
)
--
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
--[[vim.lsp.start({
  name = "lua_ls", -- 管理上の名前
  cmd = { "lua-language-server" }, -- Language server を起動するためのコマンド
  root_dir = vim.fs.dirname(vim.fs.find({ ".luarc.json" }, { upward = true })[1]), -- プロジェクトのルートディレクトリを検索する
})]]
require"lspconfig".lua_ls.setup{}
require"lspconfig".pyright.setup{}
require"lspconfig".texlab.setup{}
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
			t("Hello, World!")
		})
  --[[lua = {
    s({
      t = 'std',
      }, {
      t({'#include <bits/stdc++.h>', 'using namespace std;', ''}),
      i(0),
    }),
  },]]
})
ls.add_snippets("lua",
{
	s("lua",{
		t("haste on"),i(0),t("the moon")
	})
}
)

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
--Color Scheme
-------------------------------------------------------------------------------
--tokyonight setting
require("tokyonight").setup(
	{
	style="moon",
	transparent=false,
	styles={
		sidebars="transparent"
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
--[[vim.g.lightline={
		colorscheme="powerline",
		active={
			left= { { 'mode', 'paste' },
			{ 'gitbranch', 'readonly', 'filename', 'modified' } 	}
		},
		component_function={
				gitbranch="FugitiveHead"
		}
}]]
vim.cmd[[
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
]]
-------------------------------------------------------------------------------

-- プラグインのキーマッピング (例: telescope)
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>;;', '<cmd>Fern . -drawer -width=25<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>ToggleTerm direction=horizontal size=12 name=here<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>',{
		noremap = true, silent = true --再帰的マッピング無効化　エラー表示なし
})

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})--terminal normalmode
vim.api.nvim_set_keymap('t', '<c-[>', '<C-\\><C-n>', {noremap = true})--terminal normalmode

-- python3のパスを取得する
local python3_path = vim.fn.trim(vim.fn.system('which python3'))
-- g:python3_host_progにpython3のパスを設定する
vim.g.python3_host_prog = python3_path
-- g:loaded_python3_providerを設定する
vim.g.loaded_python3_provider = 1

-------------------------------------------------------------------------------
--これからやっておくべきこと
--スニペット構成
--GITブランチの表示
--自動補完機能
--変更箇所表示(gitみたいな縦線)
--コマンド設定
--texの構成
--ワークスペース構成
--フォーマッタ構成
--フォントサイズ調整in qt
--lightline改善，ファイル読み込みとかワークスペースとか
--gitも何とかしよう
--変数が使われてるかどうかの表示
--@windows ターミナル：powershellへ
--オープニング画面とかつけたい，VScode的な,nvchad的な
--自動保存に役立つ何か
--コピペはクリップボードに一元化したい
--ファイルタイプ別のプラグイン呼び出し設定
--起動高速化
--タブも何とかしてえ
--lspらへんの話の整理
--不要行間表示
--新しく開くファイルはタブで開く,だけどvスプリットさせたい
--✓ターミナル分割　
--インデントラインを引く
