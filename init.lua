-- This file si main setting of neovim. Keep It Clean...
-- 基本設定
vim.o.number = true               -- 行番号表示
vim.o.relativenumber = true       -- 相対行番号表示
vim.o.tabstop = 2                 -- タブの幅
vim.o.softtabstop = 2             -- インデントに使用するスペースの数
vim.o.shiftwidth = 4              -- シフト幅
vim.o.cursorline = true						-- 行線表示
vim.o.colorcolumn = "80"		  		-- 列線表示

-- キーマッピング
vim.api.nvim_set_keymap('n', '<Space>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

--colorscheme
--vim.cmd('colorscheme desert')

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

--(lazy main setting)
--require("lazy").setup(
--	{
--		{"plugin1",option1},
--		{"akinsho/toggleterm.nvim"}
--	}
--)
require("lazy").setup(
	{
		{"lervag/vimtex"},
		{"akinsho/toggleterm.nvim",version="*",config=true},
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
		{"natecraddock/workspaces.nvim"}
	}
)

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
		colors.fg="#2888ef"--object Value
	end
	}
)

vim.cmd[[colorscheme tokyonight]]

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

lightline={
				colorscheme="powerline",
				active={
					left= { { 'mode', 'paste' },
					{ 'gitbranch', 'readonly', 'filename', 'modified' } 	}
						
				},
				component_function={
						gitbranch="FugitiveHead"
				}

		}

--local setting
vim.opt.undofile=true
local option={
	encoding="utf-8",
	fileencoding="utf-8",
	undofile=true,
	undodir="~/.config/nvim"
}

-- プラグインのキーマッピング (例: telescope)
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>ls', '<cmd>Fern . -drawer -width=25<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>', { 
	noremap = true, silent = true 
})

vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>ToggleTerm<CR><cmd>set nonumber<CR><cmd>set norelativenumber<CR>',{
		noremap = true, silent = true --再帰的マッピング無効化　エラー表示なし
})


-- python3のパスを取得する
local python3_path = vim.fn.trim(vim.fn.system('which python3'))

-- g:python3_host_progにpython3のパスを設定する
vim.g.python3_host_prog = python3_path

-- g:loaded_python3_providerを設定する
vim.g.loaded_python3_provider = 1
