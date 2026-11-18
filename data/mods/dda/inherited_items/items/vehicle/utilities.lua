local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "black_box",
        category = "other",
        name = ccb.content.plural_text("military black box", "military black boxes"),
        description = ccb.content.text("An aircraft's black box, seemingly pulled from some sort of military vehicle wreckage.  If you can find a system to analyze this, you may find something of interest."),
        mass_milligrams = 4535000,
        volume_ml = 2000,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end
