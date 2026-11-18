local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "trade_writ",
        name = ccb.content.plural_text("writ of trade", "writs of trade"),
        description = ccb.content.text("A short writ featuring the signed agreement of establishing a trade route."),
        mass_milligrams = 1000,
        volume_ml = 5,
        price_cents = 3000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "light_cyan",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
