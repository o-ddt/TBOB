-- used for death certificate, allows the player to pick any joker from the collection. i stole this from ultrahand (https://github.com/xioxin/BalatroMods/blob/main/Mods/UltraHand.lua)
isaac.spawn = false

local CardClickRef = Card.click;
function Card:click()
    if isaac_config.liveupdate then
        isaac.update_member_count() -- basically live updating idfk
    else
        local rng = math.random(1,60)
        if rng == 60 then
            isaac.update_member_count() -- basically not live because rare idk
        end
    end
	if G.OVERLAY_MENU then
		local _card = self;
		if isaac.spawn then
			if _card.ability.set == 'Joker' and G.jokers then
				add_joker(_card.config.center.key)
				_card:set_sprites(_card.config.center)
                isaac.spawn = false
			end
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

function isaac.parse_table_with_nested_sections(str)
    local result = {}
    local current_nested_key = nil
    local nested_table = nil

    for line in str:gmatch("[^\r\n]+") do
        local indent, key, value = line:match("^(%s*)([^:]+):%s*(.*)$")
        indent = #indent

        if indent == 0 then
            -- Top-level key
            if value == "" then
                -- It's a nested section start, e.g., "extra:"
                current_nested_key = key
                nested_table = {}
            else
                table.insert(result, key)
                table.insert(result, value)
            end
        elseif indent == 2 and current_nested_key then
            -- Nested key under previous section
            table.insert(nested_table, key)
            table.insert(nested_table, value)
        end

        -- If we reach a new top-level key after a nested one, store the nested table
        if indent == 0 and current_nested_key and nested_table then
            table.insert(result, current_nested_key)
            table.insert(result, nested_table)
            current_nested_key = nil
            nested_table = nil
        end
    end

    -- Edge case: if the last line was a nested section, store it
    if current_nested_key and nested_table then
        table.insert(result, current_nested_key)
        table.insert(result, nested_table)
    end

    return result
end

function isaac.momsknifefunc(jokers,context)
    local rtrn = {} -- made this in moms knife so i put it in a global function
			for i,v in pairs(jokers) do
				local rtern = v:calculate_joker(context) -- had to dig in balatros source code to find this, i was trying to call the function from the joker itself
				local string = inspect(rtern)
				local table = isaac.parse_table_with_nested_sections(string) -- im going to milk this function dry the entire joker i swear to god ive spent like 8 hours coding this joker in total and nothing works please help me i swear to god im going mentally insane
				for i=1,#table,2 do
					local key = table[i] -- i literally used chatgpt for this function because im so tired of iterating through millions of fucking tables
					local value = table[i+1]
					if tonumber(value) and type(rtrn[key]) == "number" then
						rtrn[key] = rtrn[key] + tonumber(value)
					elseif tonumber(value) and not rtrn[key] then
						rtrn[key] = tonumber(value)
					else
						rtrn[key] = value
					end -- as of 2:34:30 on july 8th, 2025 in est (im too lazy to change it to utc this is a big moment), this works on joker_main, and i literally screamed in shock when i saw the xchips. i spent so long on ts and now i now how to do it
				end
			end
			return rtrn
end