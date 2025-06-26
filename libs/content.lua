-- mainly for music overrides

SMODS.Sound({
	key = "music_isaac",
	path = "music_isaac.ogg",
	pitch = 1,
	select_music_track = function()
        return (not (G.GAME.blind and G.GAME.blind:get_type() == 'Boss') and not (G.shop) and not (G.MAIN_MENU_UI))
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
        return (G.shop)
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