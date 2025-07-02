--global function thingy (cryptid mod is the most unreadable bullshit)
if not isaac then
	isaac = {}
end
-- this is copy and pasted from cryptid mod, im so sorry the devs that had to write this code just for people to steal it
local mod_path = "" .. SMODS.current_mod.path -- this path changes when each mod is loaded, but the local variable will retain mod path
isaac.path = mod_path
isaac_config = SMODS.current_mod.config or {}

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	cardareas = {
		deck = true,
		discard = true
	},
}
-- isaac pool (thanks yayamouse)
SMODS.ObjectType({
	key = "Isaac",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
G.C.isaacred = HEX("d10400") -- stolen from yahimod which stole this from cryptid mod, i love github repositories
G.C.isaacgold = HEX("c1c894")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'isaacgold'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'isaacred'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
	return ret
end

-- custom logo

logo = "balatro.png"

SMODS.Atlas {
	key = "balatro",
	path = logo,
	px = 333,
	py = 216,
	prefix_config = { key = false }
}

assert(SMODS.load_file("libs/https.lua"))()
assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
assert(SMODS.load_file("libs/qolfunctions.lua"))()
assert(SMODS.load_file("libs/overrides.lua"))()
assert(SMODS.load_file("libs/content.lua"))()
assert(SMODS.load_file("libs/timer.lua"))()

local isaacconfig = function()
	isaac_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = "Isaac Mod Config",
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.4,
						}),
					},
				},
			},
		},
	}
	left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	isaac_nodes[#isaac_nodes + 1] = config
		isaac_nodes[#isaac_nodes + 1] = create_toggle({
		label = "Enable Isaac music",
		active_colour = HEX("00FF7F"),
		ref_table = isaac_config,
		ref_value = "custom_music",
	})
	isaac_nodes[#isaac_nodes + 1] = create_toggle({
		label = "Enable HTTPS module",
		active_colour = HEX("00FF7F"),
		ref_table = isaac_config,
		ref_value = "http",
	})
	isaac_nodes[#isaac_nodes + 1] = create_toggle({
		label = '"Live" updating HTTPS module',
		active_colour = HEX("00FF7F"),
		ref_table = isaac_config,
		ref_value = "liveupdate",
	})
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = isaac_nodes,
	}
end

SMODS.current_mod.config_tab = isaacconfig