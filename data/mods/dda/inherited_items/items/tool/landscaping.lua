local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "digging_stick",
        name = ccb.content.plural_text("digging stick", "digging sticks"),
        category = "tools",
        description = ccb.content.text("A large stick with the end carved into a broad blade for digging.  It could be used to dig shallow pits, but not deep ones."),
        mass_milligrams = 1133000,
        volume_ml = 1500,
        longest_side_mm = 900,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("DIG", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "scythe_fake",
        copy_from = "scythe",
        looks_like = "scythe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("scythe", "scythes"),
        description = ccb.content.text("A dull, cheaply-made replica of an old-fashioned farming tool used to cut tall grass."),
        mass_milligrams = 1840000,
        price_cents = 4000,
        price_postapoc_cents = 40,
    }
    item:material("aluminum", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.064 } }
    content.add(item)
end
