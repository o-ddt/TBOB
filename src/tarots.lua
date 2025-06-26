SMODS.Consumable {
    key = 'deathcert',
    set = 'Spectral',
    hidden = true,
    pos = { x = 2, y = 2 },
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
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            G.shared_soul.role.draw_major = card
            G.shared_soul:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.shared_soul:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end
}