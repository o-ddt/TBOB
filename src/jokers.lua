--Creates an atlas for cards to use
SMODS.Atlas {
	key = "placeholder",
	path = "placeholder.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "isaac",
	path = "isaac.png",
	px = 71,
	py = 95
}

SMODS.Sound({key = "thumbsup", path = "thumbsup.ogg"})

SMODS.Joker {
	key = 'isaac',
	loc_txt = {
		name = 'Isaac',
		text = {
			"{X:mult,C:white} X#1# {} Mult",
			"Repeats every played {C:red}#2#{} card twice",
			"{C:inactive}jesus loves you, can't you see{}"
		}
	},
	config = { extra = { Xmult = 3, suit = "Hearts"} },
	rarity = 3,
	atlas = 'isaac',
	pos = { x = 0, y = 0 },
	cost = 12,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.suit}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card.base.suit == card.ability.extra.suit then
				return {
					message = '<3',
					message_card = card,
					sound = "tboi_thumbsup",
					repetitions = 2,
					card = context.other_card
				}
			end
		end
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end
}

SMODS.Atlas {
	key = "eve",
	path = "eve.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'eve',
	loc_txt = {
		name = 'Eve',
		text = {
			"{C:mult}+#1#{} Mult",
			"Repeats every played {C:black}#2#{} card twice",
			"{C:inactive}dead bird mmm{}"
		}
	},
	config = { extra = { Xmult = 10, suit = "Spades"} },
	rarity = 2,
	atlas = 'eve',
	pos = { x = 0, y = 0 },
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.suit, card.ability.extra.extra }}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card.base.suit == card.ability.extra.suit then
				return {
					message = 'Spade',
					message_card = card,
					sound = "tboi_thumbsup",
					repetitions = 2,
					card = context.other_card
				}
			end
		end
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.Xmult } },
				mult_mod = card.ability.extra.Xmult
			}
		end
	end
}

SMODS.Atlas {
	key = "cain",
	path = "cain.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'cain',
	loc_txt = {
		name = 'Cain',
		text = {
			"Every Joker gives {X:mult,C:white}X#1#{} Mult,",
			"Every Dollar gives {C:mult}+#2#{} Mult,",
			"and Every Card in Deck gives {C:chips}+#3#{} Chips.",
			"{C:inactive}Currently {}{X:mult,C:white}X#4#{}{C:inactive} Mult, {}{C:mult}+#5#{}{C:inactive} Mult, and {}{C:chips}+#6#{}{C:inactive} Chips.{}"
		}
	},
	config = { extra = { Xmult = 1, Omult = 2, Ochips = 2} },
	rarity = 4,
	atlas = 'cain',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 20,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	loc_vars =  function (self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Omult, card.ability.extra.Ochips, card.ability.extra.Xmult*(G.jokers and #G.jokers.cards or 1), card.ability.extra.Omult * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0))), math.max(0, card.ability.extra.Ochips * (G.playing_cards and (#G.playing_cards) or 0)) } }
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = math.max(0, card.ability.extra.Ochips * (G.playing_cards and (#G.playing_cards) or 0)),
				mult = card.ability.extra.Omult * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0))),
				Xmult = card.ability.extra.Xmult * #G.jokers.cards
			}
		end
	end
}

SMODS.Atlas {
	key = "maggy",
	path = "maggy.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'maggy',
	loc_txt = {
		name = 'Magdalene',
		text = {
			"{C:attention}+#1#{} Hand Size",
			"{C:inactive}USE YOUR YUM HEART{}"
		}
	},
	config = { extra = { handsize = 3 } },
	rarity = 2,
	atlas = 'maggy',
	pos = { x = 0, y = 0 },
	cost = 6,
	discovered = true,
	blueprint_compat = false,
	loc_vars = function (self, info_queue, card)
		return { vars = { card.ability.extra.handsize } }
	end,
	add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.handsize)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.handsize)
    end
}

SMODS.Atlas {
	key = "lost",
	path = "lost.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'helpwhereami',
	loc_txt = {
		name = "Lost",
		text = {
			"Opening a pack creates a random{C:chips} Spectral Card{},",
			"also creates one at the start of every {C:red}Boss Blind{}"
		}
	},
	config = { extra = {} },
	rarity = 2,
	atlas = 'lost',
	pos = {x=0,y=0},
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	calculate = function (self,card,context)
		if context.setting_blind and context.blind.boss then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
    			delay = 0.4,
                func = function()
                    play_sound('tboi_thumbsup')
	                SMODS.add_card({ set = 'Spectral', soulable = true })
		            card:juice_up(0.3, 0.5)
    				return true
                end
            }))
			return {
				message = "Boo!"
			}
		end
		if context.open_booster then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
        		delay = 0.4,
                func = function()
                    play_sound('tboi_thumbsup')
	                SMODS.add_card({ set = 'Spectral', soulable = true })
		            card:juice_up(0.3, 0.5)
    				return true
                end
            }))
			return {
				message = "Boo!"
			}
		end
	end
}

SMODS.Atlas {
	key = "megafatt",
	path = "megafatty.png",
	px = 142,
	py = 95
}

SMODS.Joker{
    key = 'megafat',
	loc_txt = {
		name = "Mega Fatty",
		text = {
			"{C:red}-#1# {}Joker Slot,",
			"{X:mult,C:white}X#2# {} Mult"
		}
	},
	config = {extra = {jokers = 1, Xmult = 10}},
	rarity = 3,
	atlas = 'megafatt',
	cost = 15,
    discovered = true,
    blueprint_compat = true,
    pos = {x=0, y= 0},
	display_size = { w = 1 * 142, h = 1 * 95 },
	loc_vars = function (self, info_queue, card)
		return {vars = {card.ability.extra.jokers, card.ability.extra.Xmult}}
	end,
	add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.jokers
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.jokers
	end,
	calculate = function (self,card,context)
		if context.joker_main then
			return{
				Xmult = card.ability.extra.Xmult
			}
		end
	end
}

SMODS.Atlas {
	key = "monster",
	path = "monstro.png",
	px = 71,
	py = 95
}


SMODS.Joker{
	key = 'monstro',
	loc_txt = {
		name = 'Monstro',
		text = {
			"At the start of every blind,",
			"destroy a random playing card",
			"and add {C:mult}+#1#{} Mult.",
			"{C:inactive}Currently {}{C:mult}+#2#{}{C:inactive} Mult.{}"
		}
	},
	config = {extra = {incr = 5, amnt = 0}},
	rarity = 2,
	atlas = 'monster',
	pos = {x=0,y=0},
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	loc_vars = function (self, info_queue, card)
		return { vars = { card.ability.extra.incr,card.ability.extra.amnt } }
	end,
	calculate = function (self,card,context)
		if context.setting_blind then
			local rng = math.random(1,#G.playing_cards)
			card.ability.extra.amnt = card.ability.extra.amnt + card.ability.extra.incr
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function ()
					play_sound('timpani')
					SMODS.destroy_cards(G.playing_cards[rng])
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			return {
				message = "+5"
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.amnt
			}
		end
	end
}


SMODS.Joker{
	key = 'T. Bethany',
	loc_txt = {
		name = "Tainted Bethany",
		text = {
			"At the start of every boss blind,",
			"creates a random negative perishable joker."
		}
	},
	config = { extra = {} },
	rarity = 3,
	atlas = 'placeholder',
	pos = {x=0,y=0},
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	calculate = function (self,card,context)
		if context.setting_blind and context.blind.boss then
			return {
				func = function ()
					G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
								trigger = 'after',
           						delay = 0.4,
                                func = function()
            	                    play_sound('tboi_thumbsup')
					                SMODS.add_card({ set = 'Joker', stickers = {"perishable"}, edition = "e_negative" })
				    	            card:juice_up(0.3, 0.5)
                					return true
                                end
                            }))
                            SMODS.calculate_effect({ message = "lemegeton" }, card)
                            return true
                        end
                    }))
				end
			}
		end
	end
}

SMODS.Atlas {
	key = "delirim",
	path = "delirim.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'delirium',
	loc_txt = {
		name = 'Delirium',
		text = {
			"Sell this card for",
			"a random {C:black}Negative {}{C:red}Rare Joker{}"
		}
	},
	config = {extra = {price = 0}},
	rarity = 3,
	atlas = "delirim",
	pos = {x=0,y=0},
	cost = 8,
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	loc_vars = function (self, info_queue, card)
		return {vars = {card.ability.extra.price}}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra_value = -4
        card:set_cost()
    end,
	calculate = function (self,card,context)
		if context.selling_self then
			return {
				message = "poof!",
				func = function ()
					G.E_MANAGER:add_event(Event({
						trigger = "immediate",
						func = function ()
							play_sound('tboi_thumbsup')
							SMODS.add_card({ set = 'Joker', rarity = 1, edition = "e_negative" })
							card:juice_up(0.3,0.5)
							return true
						end
					}))
				end
			}
		end
	end
}

SMODS.Joker{
	key = 'keeper',
	loc_txt = {
		name = 'Keeper',
		text = {
			"After #1# rounds,",
			"sell this card for {C:money}$#3#{}",
			"{C:inactive}#2# rounds left{}"
		}
	},
	config = {extra = {rounds = 5, remainingrnds = 4, price = 50}},
	rarity = 3,
	atlas = "placeholder",
	pos = {x=0,y=0},
	cost = 8,
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	loc_vars = function (self, info_queue, card)
		return {vars = {card.ability.extra.rounds,card.ability.extra.remainingrnds + 1,card.ability.extra.price }}
	end,
	calculate = function (self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.remainingrnds > 0 then
				card.ability.extra.remainingrnds = card.ability.extra.remainingrnds - 1
				return {
					message = tostring(card.ability.extra.remainingrnds+1)
				}
			elseif card.ability.extra.remainingrnds == 0 then
				card.ability.extra_value = (card.ability.extra.price - 4)
				card:set_cost()
				return {
					message = "Ready!"
				}
			end
        end
	end
}

SMODS.Atlas {
	key = "school",
	path = "schoolbag.png",
	px = 71,
	py = 95
}


SMODS.Joker{
    key = 'schhol',
	loc_txt = {
		name = "Schoolbag",
		text = {
			"{C:attention}+#1# {}Joker Slot",
		}
	},
	config = {extra = {jokers = 1}},
	rarity = 2,
	atlas = 'school',
	cost = 6,
    discovered = true,
    blueprint_compat = false,
    pos = {x=0, y= 0},
	loc_vars = function (self, info_queue, card)
		return {vars = {card.ability.extra.jokers}}
	end,
	add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.jokers
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.jokers
	end,
}

SMODS.Atlas {
	key = "taisic",
	path = "taisaac.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'tissac',
	loc_txt = {
		name = "Tainted Isaac",
		text = {
			--"{C:attention}+#1#{} selection size" (didn't feel right unless i stole the acsension code from cryptid or made it also give splash)
			"Flushes and straights can be made with",
			"{C:attention}#1#{} cards."
		}
	},
	config = {extra = {size = 3}},
	rarity = 3,
	atlas = 'taisic',
	pos = {x=0,y=0},
	cost = 20,
	discovered = true,
	blueprint_compat = false,
	loc_vars = function (self,info_queue,card)
		return {vars = {card.ability.extra.size}}
	end,
}

local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers()
    if next(SMODS.find_card('j_tboi_tissac')) then
        return 3
    end
    return smods_four_fingers_ref()
end

SMODS.Atlas {
	key = "brokeymodem",
	path = "brokenmodem.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'brokeymodey',
	loc_txt = {
		name = "Broken Modem",
		text = {
			"Gives {X:chips,C:white}X#1#{} chips",
			"for every concurrent player on",
			"{C:red}The Binding of Isaac: Rebirth{}",
			"{C:inactive}Currently {}{X:chips,C:white}X#2#{}{C:inactive} chips.{}"
		}
	},
	config = {extra = {mult = 0.25}},
	rarity = 4,
	atlas = 'brokeymodem',
	pos = {x=0,y=0},
	soul_pos = {x=1,y=0},
	cost = 20,
	discovered = true,
	blueprint_compat = true,
	loc_vars = function (self,info_queue,card)
		return {vars = {card.ability.extra.mult,isaac.player_count*card.ability.extra.mult}}
	end,
	calculate = function (self,card,context)
		if context.joker_main then
			return {
				xchips = isaac.player_count*card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker {
    key = "momknife",
	loc_txt = {
		name = "Mom's Knife",
		text = {
			"At the start of every blind,",
			"{C:attention}Absorbs {}the joker to the right",
			"and adds it to this jokers {C:attention}Calculation.{}",
			"{C:inactive}``ISAAC!``{}"
		}
	},
    blueprint_compat = true,
    perishable_compat = false,
	discovered = true,
    rarity = 4,
    cost = 2,
	atlas = 'placeholder',
    pos = { x = 0, y = 0 },
    config = { extra = { jokers = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then -- stole this from vanilla remade's ceremonial dagger cause im to lazy to code
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
				card.ability.extra.jokers[#card.ability.extra.jokers+1] = sliced_card
				local variables = inspectDepth(sliced_card.ability)
				local data = isaac.parse_table_with_nested_sections(variables)
				for i = 1, #data, 2 do
 					local key = data[i]
    				local value = data[i + 1]
    				if key == "name" or key == "set" or key == "type" or key == "hands_played_at_create" or key == "order" then
						goto continue
					end
					if key == "extra" and type(value) == "table" then
						for i=1,#value,2 do
		 					local key2 = value[i]
    						local value2 = value[i + 1]
							if tonumber(value2) and card.ability.extra[key2] and type(card.ability.extra[key2]) == "number" then
								card.ability.extra[key2] = card.ability.extra[key2] + tonumber(value2)
							elseif tonumber(value2) and (not card.ability.extra[key2] or type(card.ability.extra[key2]) ~= "number") then
								card.ability.extra[key2] = tonumber(value2)
							else
								card.ability.extra[key2] = value2
							end
						end
					end
					if tonumber(value) and card.ability.extra[key] and type(card.ability.extra[key]) == "number" then
						card.ability.extra[key] = card.ability.extra[key] + tonumber(value)
					elseif tonumber(value) and (not card.ability.extra[key] or type(card.ability.extra[key]) ~= "number") then
						card.ability.extra[key] = tonumber(value)
					else
						card.ability.extra[key] = value
					end
				    ::continue::
				end
                sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = localize { type = 'description', key = 'Joker', vars = { sliced_card.calculate } },
                    colour = G.C.RED,
                    no_juice = true,
					--isaac.momsknifefunc(card.ability.extra.jokers,context)
                }
            end
        end
		if context.joker_main then
			return isaac.momsknifefunc(card.ability.extra.jokers,context)
		end
    end
}