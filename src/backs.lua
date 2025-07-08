SMODS.Atlas {
	key = "riged",
	path = "rigged.png",
	px = 71,
	py = 95
}

SMODS.Back{
    name = "Rigged Deck",
    key = "d6",
    atlas = 'riged',
    pos = {x = 0, y = 0},
    config = {probability = 1000},
    loc_txt = {
        name ="Rigged Deck",
        text={
            "Every chance thing happens",
            "{C:green}100%{} of the time."
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i,v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[i] = math.huge
                end
                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Eden's Blessing",
    key = "blesseden",
    pos = {x = 1, y = 0},
    config = {},
    loc_txt = {
        name ="Eden's Blessing",
        text={
            "Start with a random",
            "{C:attention}Consumable {}and {C:attention}Joker{}"
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local rng = math.random(1,3)
                local rng2 = math.random(1,250)
                if rng == 1 then
                    SMODS.add_card({ set = 'Spectral', soulable = true })
                elseif rng == 2 then
                    SMODS.add_card({ set = 'Tarot', soulable = true })
                elseif rng == 3 then
                    SMODS.add_card({ set = 'Planet', soulable = true })
                end
                if rng2 ~= 1 then
                    SMODS.add_card({ set = 'Joker' })
                elseif rng2 == 1 then
                    SMODS.add_card({ set = 'Joker', legendary = true })
                end
                return true
            end
        }))
    end
}