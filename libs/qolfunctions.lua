-- used for death certificate, allows the player to pick any joker from the collection. i stole this from ultrahand (https://github.com/xioxin/BalatroMods/blob/main/Mods/UltraHand.lua)
isaac.spawn = false

local CardClickRef = Card.click;
function Card:click()
	if G.OVERLAY_MENU then
		local _card = self;
		if isaac.spawn then
			if _card.ability.set == 'Joker' and G.jokers then
				add_joker(_card.config.center.key)
				_card:set_sprites(_card.config.center)
                isaac.spawn = false
			end
		else
            isaac.UsePill()
        end
	end
	CardClickRef(self)
end

isaac.UsePill = function()
    local rng = math.random(8,8)
    if rng == 1 and G.jokers.cards then
        local rng2 = math.random(1,#G.jokers.cards)
        if G.jokers.cards[rng2] then
            G.jokers.cards[rng2]:set_edition({ negative = true })
        end
    elseif rng == 2 and G.jokers.cards then
        for i=1,#G.jokers.cards do
            v = G.jokers.cards[i]
            local rng2 = math.random(1,2)
            if rng2 == 1 then
                local _first_dissolve = nil
                if not v.ability.eternal then
                    v:start_dissolve(nil, _first_dissolve)
                    _first_dissolve = true
                end
            end
        end
    elseif rng == 3 then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function ()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, #G.playing_cards do
                    local _card = copy_card(G.playing_cards[i], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
        delay(0.3)
    elseif rng == 4 then
        local rng2 = math.random(1,#G.playing_cards)
        local card = G.playing_cards[rng2]
        card:set_edition({ holo = true })
    elseif rng == 5 then
            local rng2 = math.random(1,#G.playing_cards)
        local card = G.playing_cards[rng2]
        card:set_edition({ polychrome = true })
    elseif rng == 6 then
        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function ()
                    SMODS.add_card({set = 'Joker'})
                    return true
                end
            }))
        end
    elseif rng == 7 then
        if G.jokers then
            local _sellvar = 0
            local _first_dissolve = nil
            for i=1,#G.jokers.cards do
                local card = G.jokers.cards[i]
                _sellvar = _sellvar + G.jokers.cards[i].sell_cost*(4/3)
                G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.3,
					blockable = false,
		    		func = function()
						G.jokers:remove_card(card)
						card:remove()
						card = nil
						return true;
					end
				}))
            end
            ease_dollars(_sellvar)
        end
    elseif rng == 8 then
        if G.jokers then
            card = G.jokers.cards[math.random(1,#G.jokers.cards)]
            G.E_MANAGER:add_event(Event({
    			trigger = 'after',
			    delay = 0.3,
		    	blockable = false,
        		func = function()
    				G.jokers:remove_card(card)
				    card:remove()
			    	card = nil
		    		return true;
	    		end
    		}))
        end
    elseif rng == 9 then
        
    end
end