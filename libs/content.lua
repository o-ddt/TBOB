-- mainly for music overrides

SMODS.Sound({
	key = "music_isaac",
	path = "music_isaac.ogg",
	pitch = 1,
	select_music_track = function()
        return (G.GAME.blind and G.GAME.blind:get_type() and not (G.GAME.blind:get_type() == 'Boss') and not (G.shop) and not (G.MAIN_MENU_UI) and not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED))
	end,
})

SMODS.Sound({
	key = "music_isaac_boss",
	path = "music_isaac_boss.ogg",
	pitch = 1,
	select_music_track = function()
        return (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')
	end,
})

SMODS.Sound({
	key = "music_isaac_shop",
	path = "music_isaac_shop.ogg",
	pitch = 1,
	select_music_track = function()
        return (G.shop and not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED))
	end,
})

SMODS.Sound({
	key = "music_isaac_title", -- never going to be consistent because of the starting animation >:(
	path = "music_isaac_title.ogg",
	pitch = 1,
	select_music_track = function()
        return (G.MAIN_MENU_UI)
	end,
})

SMODS.Sound({
	key = "music_isaac_planet",
	path = "music_isaac_planet.ogg",
	pitch = 1,
	sync = false,
	select_music_track = function()
        return (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED)
	end,
})

SMODS.Sound({
	key = "music_isaac_select",
	path = "music_isaac_blindselect.ogg",
	pitch = 1,
	select_music_track = function()
        return (G.GAME.blind and G.GAME.blind:get_type() == nil)
	end,
})