SMODS.Back{
    name = "Rigged Deck",
    key = "d6",
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