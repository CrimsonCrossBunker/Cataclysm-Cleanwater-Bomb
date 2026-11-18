local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "väinämöinens_kantele_imitation",
        looks_like = "kantele",
        category = "tools",
        name = ccb.content.plural_text("Väinämöinen's Kantele, imitation", "Väinämöinen's Kanteles, imitation"),
        description = ccb.content.text("A traditional Finnish string instrument.  According to myth the first one was fashioned from a great pike's jawbone.  Does it glimmer in the light?  Do its notes echo and linger more than normal?"),
        mass_milligrams = 1000000,
        volume_ml = 3000,
        longest_side_mm = 460,
        price_cents = 5500,
        price_postapoc_cents = 250,
        symbol = "(",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "kantele_spell", no_fail = true, level = 3 }
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 10,
        fun = -5,
        fun_bonus = 2,
        speed_penalty = 13,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a haunting melody on your kantele, you sing tragic poetry while you play."),
            ccb.content.text("You play an enchanting composition on your kantele, the words you sing along speak of the mysteries of the forest and sea."),
            ccb.content.text("You play a somber piece on your kantele, you sing of a land you can never return to, the past."),
        },
    }
    content.add(item)
end
