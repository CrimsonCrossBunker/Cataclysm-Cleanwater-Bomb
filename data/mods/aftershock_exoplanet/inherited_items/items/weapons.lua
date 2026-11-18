local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "golf_club",
        name = ccb.content.plural_text("golf club", "golf clubs"),
        copy_from = "golf_club",
        looks_like = "golf_club",
    }
    item:material("aluminum", 1)
    item:material("titanium", 1)
    content.replace(item)
end

do
    local item = content.Item {
        id = "ceramic_knife",
        category = "weapons",
        name = ccb.content.plural_text("bodyguard knife", "bodyguard knives"),
        description = ccb.content.text("Designed to evade security measures, this knife is a must have for any Cataclysm dinner party."),
        mass_milligrams = 390000,
        volume_ml = 250,
        price_cents = 4000,
        melee_to_hit = -1,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("ceramic", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 5)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 15)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_toxic_knife",
        category = "weapons",
        name = ccb.content.plural_text("neurotoxic knife", "neurotoxic knives"),
        description = ccb.content.text("A broad white-ceramic knife that is constantly kept coated in neurotoxic oil by a handle mounted reservoir.  Don't cut yourself."),
        mass_milligrams = 390000,
        volume_ml = 250,
        price_cents = 4000,
        symbol = "/",
        color = "white",
        replace_qualities = true,
        melee_to_hit = -1,
        weapon_categories = { "KNIVES" },
    }
    item:material("ceramic", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 5)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("NPC_THROWN")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("afs_toxin_pierce", 21)
    item:throwing_damage { { type = "afs_toxin_pierce", amount = 14 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "aza_sword",
        symbol = "/",
        color = "white",
        name = ccb.content.plural_text("Aztlani hunting sword", "Aztlani hunting swords"),
        description = ccb.content.text("An ornate, single-handed sword used by Aztlani hunters to finish injured game.  Made from gleaming composite alloy, its tip and frontal blade have been sharpened to a monomolecular point, while its back features a serrated saw edge."),
        price_cents = 100000,
        price_postapoc_cents = 450000,
        techniques = { "WBLOCK_2" },
        mass_milligrams = 1360000,
        volume_ml = 2000,
        longest_side_mm = 900,
        category = "weapons",
        replace_qualities = true,
        weapon_categories = { "LONG_SWORDS" },
    }
    item:material("superalloy", 1)
    item:material("qt_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 50)
    item:tool()
    content.add(item)
end
