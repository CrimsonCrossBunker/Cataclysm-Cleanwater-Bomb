local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "muffler",
        name = ccb.content.plural_text("muffler", "mufflers"),
        description = ccb.content.text("A muffler from a car.  Useful in a few crafting recipes."),
        mass_milligrams = 9525000,
        melee_to_hit = -1,
        color = "light_gray",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 3500,
        category = "veh_parts",
        price_cents = 3000,
        price_postapoc_cents = 100,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 19)
    content.add(item)
end
