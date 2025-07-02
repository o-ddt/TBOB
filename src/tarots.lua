SMODS.Atlas {
	key = "dc",
	path = "deadcert.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = 'deathcert',
    set = 'Spectral',
    hidden = true,
    atlas = 'dc',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    soul_set = 'Tarot',
    loc_txt = {
        name = "Death Certificate",
        text={
        "Spawns the card",
        "{C:dark_edition}of your choice.{}",
        },
    },
    discovered = true,
    config = { extra = { } },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = after,
            delay = 0.4,
            func = function ()
                play_sound('timpani')
                isaac.spawn = true
                card:juice_up(0.3,0.5)
                SMODS.calculate_effect({ message = "Go to the collection and click on any joker you want!" }, card)
                delay(1)
                return true
            end
        }))
        --isaac.spawn = true
    end,
    can_use = function(self, card)
        return true
    end,
}

SMODS.Atlas {
	key = "diplop",
	path = "diplopia.png",
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = 'diplo',
    loc_txt = {
        name = "Diplopia",
        text = {
            "Doubles the values of all owned jokers",
            "(if possible)"
        }
    },
    set = 'Tarot',
    atlas = 'diplop',
    pos = {x=0,y=0},
    discovered = true,
    use = function (self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            trigger = after,
            delay = 0.4,
            func = function ()
                for i=1, (G.jokers and (#G.jokers.cards)) do
                    local card2 = G.jokers.cards[i]
                    for i,v in pairs(card2.ability) do
                        if type(v) == 'table' then
                            for i2,v in pairs(card2.ability[i]) do
                                if type(card2.ability[i][i2]) == "number" then
                                    card2.ability[i][i2] = card2.ability[i][i2] * 2
                                end
                            end
                        elseif type(v) == "number" then
                            card2.ability[i] = card2.ability[i] * 2
                        end
                    end
                    card2.remove_from_deck(card,card2,false)
                    card2.add_to_deck(card,card2,false)
                end
                card:juice_up(0.3,0.5)
                SMODS.calculate_effect({ message = "*2" }, card)
                return true
            end
        }))
    end,
    can_use = function (self,card)
        return (G.jokers and (#G.jokers.cards >= 1))
    end
}