--tokyonight
return{
	style="moon",
	transparent=false,
	styles={
		sidebars="transparent",
		floats="transparent"
		},
	sidebars={"qf","help"},
	lualine_bold=true,
	on_colors=function(colors)
    colors.bg="#09136c"--background
    colors.bg_highlight="#1e2671"
		colors.fg_gutter="#ffba00"--number color
		colors.fg_dark="#ff9955"--command line
		colors.comment="#889fdd"--comment out
		colors.fg="#aaccee"--地の文
	end
	}
