local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "glass_shiv",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("glass shiv", "glass shivs"),
        description = ccb.content.text("A glass shard with wrapping at one end so it can be safely wielded."),
        mass_milligrams = 193000,
        price_postapoc_cents = 10,
        volume_ml = 82,
        longest_side_mm = 150,
        melee_to_hit = -2,
        weapon_categories = { "SHIVS" },
        replace_qualities = true,
    }
    item:material("glass", 13)
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -18)
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    content.add(item)
end
