local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "druid_bandages",
        category = "drugs",
        name = ccb.content.plural_text("Vegetative Poultice", "Vegetative Poultices"),
        looks_like = "leaves",
        description = ccb.content.text("A mixture of bark, moss, and leaves, glowing softly with verdant energy."),
        mass_milligrams = 50000,
        volume_ml = 60,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "!",
        color = "green",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 3, bleed = 12, move_cost = 300 }
    content.add(item)
end
