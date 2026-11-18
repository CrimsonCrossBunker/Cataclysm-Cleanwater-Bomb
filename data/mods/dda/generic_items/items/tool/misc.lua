local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "grapnel",
        category = "tools",
        name = ccb.content.plural_text("grappling hook", "grappling hooks"),
        description = ccb.content.text("A folding grappling hook attached to a stout, 30-foot long piece of lightweight cord.  Useful for keeping yourself safe from falls.  Can be used in place of a long rope for butchering, in a pinch."),
        mass_milligrams = 1980000,
        volume_ml = 2500,
        copy_from = "rope_30",
        looks_like = "rope_30",
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_gray",
        techniques = { "SPIN", "WRAP" },
        replace_qualities = true,
    }
    item:material("cotton", 1)
    item:material("steel", 1)
    item:quality("COOK", 1)
    item:quality("ROPE", 2)
    item:clear_use_actions()
    item:deploy_furniture("f_rope_up")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 6)
    item:clear_flags()
    item:flag("BELTED")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_SALVAGE")
    item:flag("OVERSIZE")
    item:flag("TIE_UP")
    item:flag("WATER_FRIENDLY")
    content.add(item)
end

do
    local item = content.Item {
        id = "umbrella",
        category = "tools",
        name = ccb.content.plural_text("umbrella", "umbrellas"),
        description = ccb.content.text("An umbrella with a pointy end, useful for keeping dry when wielded."),
        mass_milligrams = 411000,
        longest_side_mm = 1010,
        volume_ml = 1500,
        price_cents = 2400,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        ascii_picture = "umbrella",
        symbol = "/",
        color = "magenta",
        techniques = { "WBLOCK_1" },
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("RAIN_PROTECT")
    item:flag("SHEATH_SWORD")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "dressage_whip",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("dressage whip", "dressage whips"),
        description = ccb.content.text("A long, thin and flexible rod that tapers to a point, originally used to stimulate a horse and give them orders."),
        mass_milligrams = 90000,
        volume_ml = 732,
        longest_side_mm = 1100,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
        weapon_categories = { "WHIPS" },
    }
    item:material("epoxy", 1)
    item:material("nylon", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("WHIP")
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "riding_crop",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("riding crop", "riding crops"),
        description = ccb.content.text("A rod ending in a leather popper originally used to stimulate a horse and give them orders."),
        mass_milligrams = 68000,
        volume_ml = 1480,
        longest_side_mm = 600,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
    }
    item:material("epoxy", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end
