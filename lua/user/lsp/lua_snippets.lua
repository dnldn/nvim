local m = {}

function m.custom_snippets()

	--Require lua snip library.
	local ls = require("luasnip")

	--Shorthands from luasnippet library.
	local snip = ls.snippet --Creates new snippet. All arguments below are passed as objects into this block.
	local node = ls.snippet_node --Allows for branching out to sub-nodes - a tad tweaky for my use cases.
	local text = ls.text_node --Inserts static text. Commas create linebreaks. text({"---", "title: "})
	local insert = ls.insert_node --Use insert to create arguments for snippet; insert(1, "note_title"), insert(2, "author")
	local func = ls.function_node --Calls a function to insert text, ie: year = function() return {os.date('%Y')} end     func(year, {}),
	local choice = ls.choice_node --Switching nodes - need an example.
	local dynamicn = ls.dynamic_node --Similar to function_node, but returns snippet_node instead of just text.

	--Local functions called by all languages.
	local year = function() return {os.date('%Y')} end
	local date = function() return {os.date('%Y-%m-%d')} end

	--Universal language block. Compress to single line after unit tests. First argument indicates language type (nil = all).
	--TODO: replace these with dofile or require from subdirectory.
	ls.add_snippets("lua", {
		snip({
		    trig = "year",
		    namr = "Year",
		    dscr = "Output current year (test).",
		}, {
		    func(year, {}),
		}),

		snip({
		    trig = "meta",
		    namr = "Metadata",
		    dscr = "Yaml metadata format for markdown"
		},
		{
		    text({"---",
		    "title: "}), insert(1, "note_title"), text({"",
		    "author: "}), insert(2, "author"), text({"",
		    "date: "}), func(date, {}), text({"",
		    "categories: ["}), insert(3, ""), text({"]",
		    "lastmod: "}), func(date, {}), text({"",
		    "tags: ["}), insert(4), text({"]",
		    "comments: true",
		    "---", ""}),
		    insert(0)
		  }),
	})
end



function m.init()
	--Loads all custom snippets.
	m.custom_snippets()
end
return m
