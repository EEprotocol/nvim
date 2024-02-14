local LuaMS={}
function LuaMS.loader()
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
  args     -- text from i(2) in this example i.e. { { "456" } }
  --parent,   -- parent snippet or parent node
  --user_args -- user_args from opts.user_args 
)
   return args[1][1]
end

ls.add_snippets("lua",
{
	s("lua",{
		t("haste on "),i(1,"an var"),t(" the venus"),i(0)
	}),

	s("multi",{
		t({"anti","parabolalism"})
	}),

	s("trig", {
	i(1), t '<-i(1) ',
	f(fn,   --callback (args, parent, user_args) -> string
		{2}  --node indice(s) whose text is passed to fn, i.e. i(2
		  --opts
	),
	t ' i(2)->', i(2), t '<-i(2) i(0)->', i(0)
	}),

	s("begin", {
	t 'begin(',i(1),t')',
	t({'', ''}),
	t({'  '}),i(0),
	t({'', ''}),
	t'end(',f(fn,{1}),t')',
	}),

	s('lam', {
		t({'function('}), i(1), t({')'}),
			t({'', ''}),
			t({'  '}), i(0),
			t({'', ''}),
			t({'end'})
  }),

	s("trigger", {
		i(1, "First jump"),
		t(" :: "),
		sn(2, {
			i(1, "Second jump"),
			t(" : "),
			i(2, "Third jump")
		})
	})
}
)
end
return LuaMS
