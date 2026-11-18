local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "beach_volleyball",
        symbol = "*",
        color = "green",
        name = ccb.content.plural_text("beach volleyball", "beach volleyballs"),
        category = "other",
        description = ccb.content.text("A brightly colored beach volleyball.  It is slightly larger than a regular white one."),
        price_cents = 1200,
        price_postapoc_cents = 10,
        mass_milligrams = 280000,
        volume_ml = 1000,
        longest_side_mm = 270,
    }
    item:material("rubber", 1)
    item:throwing_damage { { type = "bash", amount = 4 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "puck",
        symbol = "*",
        color = "dark_gray",
        name = ccb.content.plural_text("hockey puck", "hockey pucks"),
        category = "other",
        description = ccb.content.text("A heavy circular block of solid rubber, normally used for playing hockey.  You can throw it to cause some serious harm."),
        price_cents = 1000,
        price_postapoc_cents = 0,
        mass_milligrams = 170000,
        volume_ml = 250,
        longest_side_mm = 76,
    }
    item:material("rubber", 1)
    item:throwing_damage { { type = "bash", amount = 7 } }
    content.add(item)
end
