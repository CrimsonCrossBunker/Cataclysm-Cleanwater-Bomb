local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cold_iron_warhammer",
        name = ccb.content.plural_text("war hammer", "war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool."),
        mass_milligrams = 1337000,
        price_postapoc_cents = 6000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_HAMMERS" },
        volume_ml = 1250,
        longest_side_mm = 1200,
        melee_to_hit = 2,
        price_cents = 16000,
        replace_qualities = true,
        repair_materials = { "iron" },
    }
    item:material("iron", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SPEAR")
    item:flag("NONCONDUCTIVE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("xe_cold_iron_bash_damage", 22)
    item:melee_damage("xe_cold_iron_stab_damage", 23)
    content.add(item)
end
