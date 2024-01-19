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
		{"akinsho/toggleterm.nvim"},
		{"itchyny/lightline.vim"},
		{"folke/tokyonight.nvim",
		lazy=false,
		priority=1000,
		opts={}
		}
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
		colors.fg_gutter="#ffbb00"
	end
	}
)
vim.cmd[[colorscheme tokyonight]]
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

