local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "scrap_axe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("makeshift boarding axe", "makeshift boarding axes"),
        ascii_picture = "halberd",
        description = ccb.content.text("This is an oversized axe made from scraps of salvaged metal.  While not as versatile or durable as the boarding axe, it still packs a punch."),
        mass_milligrams = 9250000,
        price_cents = 6000,
        price_postapoc_cents = 6000,
        volume_ml = 2750,
        longest_side_mm = 1200,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        melee_to_hit = -1,
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
        category = "weapons",
    }
    item:quality("AXE", 2)
    item:quality("BUTCHER", -30)
    item:material("budget_steel", 1)
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:melee_damage("cut", 35)
    content.add(item)
end
