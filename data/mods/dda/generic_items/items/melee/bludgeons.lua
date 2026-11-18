local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bat_metal_bolt",
        copy_from = "bat_metal",
        looks_like = "bat_metal",
        name = ccb.content.plural_text("bolt studded aluminum bat", "bolt studded aluminum bats"),
        description = ccb.content.text("An aluminum baseball bat with a selection of bolts threaded through the barrel.  Helps to concentrate the force of a blow, without adding much weight."),
        mass_milligrams = 1138000,
        price_postapoc_cents = 1400,
    }
    item:material("aluminum", 6)
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 27)
    content.add(item)
end

do
    local item = content.Item {
        id = "bat_nerf",
        name = ccb.content.plural_text("foam rubber bat", "foam rubber bats"),
        description = ccb.content.text("A baseball bat made of foam rubber with a plastic handle.  Light and easy to wield, but almost completely ineffective if your goal is to hurt someone."),
        mass_milligrams = 225000,
        longest_side_mm = 600,
        color = "yellow",
        symbol = "/",
        price_postapoc_cents = 50,
        volume_ml = 2250,
        price_cents = 2500,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_aztec_sword",
        name = ccb.content.plural_text("medium steel bladed macuahuitl", "medium steel bladed macuahuitls"),
        description = ccb.content.text("A modern reimagining of the large close combat weapon affiliated with Aztec warriors, made of a sturdy wooden club and sharp blades forged from medium steel.  Blades are definitely sturdier than obsidian ones."),
        copy_from = "lc_aztec_sword",
        looks_like = "lc_aztec_sword",
        price_cents = 5000,
        price_postapoc_cents = 1750,
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 18)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_aztec_sword",
        name = ccb.content.plural_text("high steel bladed macuahuitl", "high steel bladed macuahuitls"),
        description = ccb.content.text("A modern reimagining of the large close combat weapon affiliated with Aztec warriors, made of a sturdy wooden club and sharp blades forged from high steel.  Blades are definitely sturdier than obsidian ones."),
        copy_from = "lc_aztec_sword",
        looks_like = "lc_aztec_sword",
        price_cents = 7000,
        price_postapoc_cents = 2000,
    }
    item:material("wood", 1)
    item:material("hc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 22)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_aztec_sword",
        name = ccb.content.plural_text("hardened steel bladed macuahuitl", "hardened steel bladed macuahuitls"),
        description = ccb.content.text("A modern reimagining of the large close combat weapon affiliated with Aztec warriors, made of a sturdy wooden club and sharp blades forged from hardened steel.  Blades are definitely sturdier than obsidian ones."),
        copy_from = "lc_aztec_sword",
        looks_like = "lc_aztec_sword",
        price_cents = 9000,
        price_postapoc_cents = 2500,
    }
    item:material("wood", 1)
    item:material("ch_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 26)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_aztec_sword",
        name = ccb.content.plural_text("tempered steel bladed macuahuitl", "tempered steel bladed macuahuitls"),
        description = ccb.content.text("A modern reimagining of the large close combat weapon affiliated with Aztec warriors, made of a sturdy wooden club and sharp blades forged from tempered steel.  You can single-handedly avenge the fallen nations of Mesoamerica with this one."),
        copy_from = "lc_aztec_sword",
        looks_like = "lc_aztec_sword",
        price_cents = 12000,
        price_postapoc_cents = 3000,
    }
    item:material("wood", 1)
    item:material("qt_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 30)
    content.add(item)
end

do
    local item = content.Item {
        id = "homemade_polehammer_makeshift",
        copy_from = "homemade_polehammer",
        looks_like = "homemade_polehammer",
        name = ccb.content.plural_text("makeshift homemade polehammer", "makeshift homemade polehammers"),
        description = ccb.content.text("A standard hammerhead mounted at the end of a long stick.  It is far from being a proper weapon, but it allows you to bash zombie heads from a safe distance."),
        mass_milligrams = 1800000,
        volume_ml = 1650,
        melee_to_hit = -2,
        price_cents = 500,
        price_postapoc_cents = 200,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 27)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_simple",
        name = ccb.content.plural_text("simple mace", "simple maces"),
        copy_from = "mace_trench",
        looks_like = "mace_trench",
        description = ccb.content.text("A stick with a circular lump of metal tied to it in a facsimile of a mace.  You could probably improve it by finding a way to pin the head to the handle."),
        price_cents = 10,
        price_postapoc_cents = 75,
        replace_qualities = true,
    }
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_sap",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("makeshift sap", "makeshift saps"),
        description = ccb.content.text("An improvised sap, also known as a cosh, slapjack, and slapper.  A short, flat bludgeoning weapon consisting of a weight embedded between two patches of leather."),
        price_cents = 5000,
        techniques = { "PRECISE", "RAPID" },
        mass_milligrams = 400000,
        volume_ml = 350,
        longest_side_mm = 200,
        melee_to_hit = 1,
        price_postapoc_cents = 50,
        category = "weapons",
    }
    item:material("leather", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "rock_sock",
        symbol = ";",
        color = "white",
        name = ccb.content.plural_text("rock in a sock", "rocks in socks"),
        description = ccb.content.text("A pair of nested socks with a stone tied inside.  A true weapon of desperation."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 825000,
        volume_ml = 500,
        longest_side_mm = 100,
        melee_to_hit = -1,
        replace_qualities = true,
    }
    item:material("cotton", 1)
    item:material("stone", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "sharp_toothbrush",
        symbol = ",",
        color = "light_blue",
        name = ccb.content.plural_text("plastic shank", "plastic shanks"),
        description = ccb.content.text("An oblong plastic object with the far end ground down into a stabbing point."),
        category = "weapons",
        price_cents = 400,
        price_postapoc_cents = 0,
        mass_milligrams = 49000,
        volume_ml = 250,
        longest_side_mm = 200,
        melee_to_hit = -3,
        weapon_categories = { "SHIVS" },
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("CONDUCTIVE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "ax_sheets_bolted",
        copy_from = "ax_sheets_welded",
        looks_like = "ax_sheets_welded",
        name = ccb.content.plural_text("bolted battle axe", "bolted battle axes"),
        description = ccb.content.text("A savage-looking battle axe made out of layered sheet metal bolted to two pipes held together with fittings, vaguely forming a upside-down L shape.  Swing it with all your might."),
    }
    content.add(item)
end
