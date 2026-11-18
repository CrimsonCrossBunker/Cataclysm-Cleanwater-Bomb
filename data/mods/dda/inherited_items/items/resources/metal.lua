local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "gold_small",
        category = "spare_parts",
        name = ccb.content.plural_text("gold", "gold"),
        description = ccb.content.text("A soft, shiny metal.  Before the apocalypse this would've been worth a small fortune, but now its value is greatly diminished."),
        mass_milligrams = 19000,
        volume_ml = 1,
        price_cents = 32015,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "yellow",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("gold", 1)
    content.add(item)
end
