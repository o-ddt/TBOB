-- isaac pool (thanks yayamouse)

SMODS.ObjectType({
	key = "TBOBadd",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

-- custom logo

logo = "balatro.png"

SMODS.Atlas {
	key = "balatro",
	path = logo,
	px = 333,
	py = 216,
	prefix_config = { key = false }
}

assert(SMODS.load_file("src/jokers.lua"))()