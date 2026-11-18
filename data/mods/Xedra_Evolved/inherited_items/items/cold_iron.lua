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

do
    local item = content.Item {
        id = "cold_iron_arming_sword",
        looks_like = "arming_sword",
        category = "weapons",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("cold iron arming sword", "cold iron arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed.\n\nMade with cold iron and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        mass_milligrams = 1360000,
        volume_ml = 2000,
        longest_side_mm = 900,
        price_cents = 100000,
        price_postapoc_cents = 4500,
        techniques = { "WBLOCK_2" },
        melee_to_hit = 1,
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS" },
        repair_materials = { "iron" },
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("CONDUCTIVE")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 7)
    item:clear_melee_damage()
    item:melee_damage("xe_cold_iron_bash_damage", 6)
    item:melee_damage("xe_cold_iron_cut_damage", 26)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cold_iron_battleaxe",
        name = ccb.content.plural_text("cold iron battle axe", "cold iron battle axes"),
        description = ccb.content.text("A huge cold iron axe designed for early warfare.  Though intended for use as a weapon, it can also be pressed into service as a rather clumsy woodcutting tool."),
        mass_milligrams = 2002000,
        volume_ml = 2500,
        longest_side_mm = 1000,
        price_cents = 40000,
        price_postapoc_cents = 12000,
        melee_to_hit = 0,
        symbol = "/",
        color = "dark_gray",
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
        category = "weapons",
    }
    item:material("iron", 1)
    item:material("wood", 1)
    item:quality("AXE", 2)
    item:quality("BUTCHER", -20)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("xe_cold_iron_bash_damage", 19)
    item:melee_damage("xe_cold_iron_cut_damage", 38)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cold_iron_knife",
        name = ccb.content.plural_text("cold iron baselard", "cold iron baselards"),
        description = ccb.content.text("A medieval dagger forged from cold iron.  It is not the sharpest tool in the shed, but it is certainly one of the largest."),
        mass_milligrams = 420000,
        volume_ml = 250,
        longest_side_mm = 600,
        price_cents = 19590,
        melee_to_hit = 0,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("iron", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 15)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("xe_cold_iron_bash_damage", 5)
    item:melee_damage("xe_cold_iron_stab_damage", 16)
    item:tool()
    content.add(item)
end
