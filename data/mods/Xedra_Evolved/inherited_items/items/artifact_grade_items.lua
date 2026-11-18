local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "väinämöinens_kantele",
        looks_like = "kantele",
        category = "tools",
        name = ccb.content.plural_text("Väinämöinen's Kantele", "Väinämöinen's Kanteles"),
        description = ccb.content.text("An original kantele made by Väinämöinen himself.  Fashioned from a great pike's jawbone, the material is unlike anything you saw before the end of the world.  Every note from this instrument thrums with power."),
        mass_milligrams = 550000,
        volume_ml = 3000,
        longest_side_mm = 460,
        price_cents = 5500,
        price_postapoc_cents = 250,
        symbol = "(",
        color = "brown",
    }
    item:material("monolith", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "kantele_spell", no_fail = true, level = 15 }
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("xe_cold_iron_bash_damage", 14)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 10,
        fun = -25,
        fun_bonus = 4,
        speed_penalty = 5,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a haunting melody and sing words you don't understand, but they fill you with a strong sense of longing."),
            ccb.content.text("You play an enchanting composition on your kantele, while you play a chorus of children echo along the wind accompanying you in a language you don't recognize."),
            ccb.content.text("You play a somber dirge on your kantele, keening wailing women's voices sing a mournful song along with you.  The language is like none you are familiar with."),
            ccb.content.text("You play a song of courage and battle, of heroes and mythical beasts.  The language is your own and all the words known to you, but it is an extemperaneous piece of music."),
        },
    }
    content.add(item)
end
