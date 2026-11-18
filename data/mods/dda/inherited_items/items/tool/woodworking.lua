local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "hatchet",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("hatchet", "hatchets"),
        description = ccb.content.text("A one-handed hatchet.  Makes a great melee weapon, and is useful both for chopping things and hammering them."),
        category = "tools",
        price_cents = 2500,
        price_postapoc_cents = 500,
        techniques = { "WBLOCK_1" },
        mass_milligrams = 907000,
        volume_ml = 1000,
        longest_side_mm = 380,
        melee_to_hit = 0,
        weapon_categories = { "HAND_AXES" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:quality("CUT", 1)
    item:quality("AXE", 2, 1.5)
    item:quality("BUTCHER", 16)
    item:quality("HAMMER", 2)
    item:quality("HAMMER_FINE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 20)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general_no_tip", {  })
    content.add(item)
end
