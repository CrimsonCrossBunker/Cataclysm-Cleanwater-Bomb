local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "sheet_metal_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("small bronze sheet", "small bronze sheets"),
        description = ccb.content.text("A small sheet of bronze."),
        looks_like = "sheet_metal",
        mass_milligrams = 300000,
        volume_ml = 40,
        longest_side_mm = 200,
        price_cents = 2000,
        price_postapoc_cents = 1,
        melee_to_hit = -5,
        symbol = "]",
        color = "yellow",
    }
    item:material("bronze", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    -- An individual lamella is roughly 3cm x 6cm x 1mm in size.
    local item = content.Item {
        id = "lamellae_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("bronze lamella", "bronze lamellae"),
        description = ccb.content.text("A pile of small bronze rectangles with a pattern of holes drilled into it.  For use in creating or repairing lamellar armor."),
        mass_milligrams = 14000,
        volume_ml = 100,
        price_cents = 1000,
        price_postapoc_cents = 25,
        symbol = ",",
        color = "yellow",
    }
    item:material("bronze", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end
