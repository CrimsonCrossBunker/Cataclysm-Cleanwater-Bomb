local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "makeshift_transformer",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("makeshift transformer", "makeshift transformers"),
        category = "spare_parts",
        looks_like = "power_supply",
        description = ccb.content.text("A bundle of cables around an iron core.  Useful for controlling voltage."),
        price_cents = 170,
        price_postapoc_cents = 15,
        mass_milligrams = 113000,
        volume_ml = 1000,
    }
    item:material("iron", 1)
    item:material("copper", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end
