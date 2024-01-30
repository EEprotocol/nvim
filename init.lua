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
require("lazy").setup(
	{
		{"lervag/vimtex",ft={tex}},
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
vim.g.lightline={
		colorscheme="powerline",
		active={
			left= { { 'mode', 'paste' },
			{ 'gitbranch', 'readonly', 'filename', 'modified' } 	}
		},
		component_function={
				gitbranch="FugitiveHead"
		}
}



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
--新しく開くファイルはタブで開く,だけどスプリットさせたい
--✓ターミナル分割　
--インデントラインを引く
