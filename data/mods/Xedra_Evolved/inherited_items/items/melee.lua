local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dreamdross_knife",
        category = "weapons",
        name = ccb.content.plural_text("dreamdross knife", "dreamdross knives"),
        description = ccb.content.text("Covered with thin layer of dreamdross, this knife is a light and sharp tool to work with."),
        copy_from = "knife_combat",
        looks_like = "knife_combat",
        volume_ml = 400,
        longest_side_mm = 300,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
        techniques = { "RAPID" },
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("dreamstuff", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 21)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:adjust_measurements { mass_milligrams = { factor = 0.6 } }
    item:adjust_melee_damage { factors = { stab = 0.6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamdross_club",
        category = "weapons",
        name = ccb.content.plural_text("dreamdross club", "dreamdross clubs"),
        description = ccb.content.text("It was a good tool before, but now it's covered with a thick layer of dreamdross, and it works as a light but deadly weapon."),
        copy_from = "mace",
        looks_like = "mace",
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 1,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "MACES" },
    }
    item:material("dreamstuff", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:flag("TRADER_AVOID")
    item:flag("WOODEN_WEAPON")
    item:adjust_measurements { mass_milligrams = { factor = 0.6 } }
    item:adjust_melee_damage { factors = { bash = 0.9 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_longsword",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("dreamforged longsword", "dreamforged longswords"),
        description = ccb.content.text("A longsword, forged entirely from dreamdross.  It is much lighter than one made of steel, but applies much less force to its target.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.5 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("dreamforged warhammer", "dreamforged warhammers"),
        description = ccb.content.text("A warhammer, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 1.2 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_spear",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("dreamforged spear", "dreamforged spears"),
        description = ccb.content.text("A spear, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { stab = 1.2 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_halberd",
        copy_from = "halberd",
        looks_like = "halberd",
        name = ccb.content.plural_text("dreamforged halberd", "dreamforged halberds"),
        description = ccb.content.text("A two-handed halberd, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 1.1 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_mace",
        copy_from = "mace",
        looks_like = "mace",
        name = ccb.content.plural_text("dreamforged mace", "dreamforged maces"),
        description = ccb.content.text("A light mace, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.9 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_morningstar",
        copy_from = "morningstar",
        looks_like = "morningstar",
        name = ccb.content.plural_text("dreamforged morningstar", "dreamforged morningstars"),
        description = ccb.content.text("A light morningstar, forged entirely from dreamdross.  So light that you can't properly apply any force on it.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.9 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_estoc",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("dreamforged estoc", "dreamforged estocs"),
        description = ccb.content.text("An estoc, forged entirely from dreamdross.  So light that you can't properly apply any force on it.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { stab = 0.5 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_arming_sword",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("dreamforged arming sword", "dreamforged arming swords"),
        description = ccb.content.text("An arming sword, forged entirely from dreamdross.  So light that you can't properly apply any force on it.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.5 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_battleaxe",
        copy_from = "battleaxe",
        looks_like = "battleaxe",
        name = ccb.content.plural_text("dreamforged battle axe", "dreamforged battle axes"),
        description = ccb.content.text("A battle axe, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.7 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_katana",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("dreamforged katana", "dreamforged katana"),
        description = ccb.content.text("A katana, forged entirely from dreamdross.  So light that you can't properly apply any force on it.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.3 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_knife_combat",
        copy_from = "knife_combat_army",
        looks_like = "knife_combat_army",
        name = ccb.content.plural_text("dreamforged army knife", "dreamforged army knives"),
        description = ccb.content.text("A small military knife, forged entirely from dreamdross.  You barely feel any weight.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { stab = 0.6 } }
    item:replace_material("plastic", "forged_dreamstuff")
    item:replace_material("steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_kris",
        copy_from = "kris",
        looks_like = "kris",
        name = ccb.content.plural_text("dreamforged kris", "dreamforged krises"),
        description = ccb.content.text("A small curved knife, forged entirely from dreamdross.  You barely feel any weight.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.3, stab = 0.85 } }
    item:replace_material("steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_kukri",
        copy_from = "kukri",
        looks_like = "kukri",
        name = ccb.content.plural_text("dreamforged kukri", "dreamforged kukris"),
        description = ccb.content.text("A small kukri, forged entirely from dreamdross.  You barely feel any weight.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.3, stab = 0.9 } }
    item:replace_material("mc_steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("dreamforged nodachi", "dreamforged nodachi"),
        description = ccb.content.text("A long nodachi, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.3 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_rapier",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("dreamforged rapier", "dreamforged rapiers"),
        description = ccb.content.text("A short rapier, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { stab = 0.65 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_tanto",
        copy_from = "tanto",
        looks_like = "tanto",
        name = ccb.content.plural_text("dreamforged tanto", "dreamforged tanto"),
        description = ccb.content.text("A long tanto, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { stab = 0.3 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_wakizashi",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("dreamforged wakizashi", "dreamforged wakizashi"),
        description = ccb.content.text("A long wakizashi, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 0.3 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_zweihander",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("dreamforged zweihänder", "dreamforged zweihänders"),
        description = ccb.content.text("A huge two-handed sword, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.3, cut = 0.6 } }
    item:replace_material("leather", "forged_dreamstuff")
    item:replace_material("mc_steel", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_khopesh",
        copy_from = "khopesh",
        looks_like = "khopesh",
        name = ccb.content.plural_text("dreamforged khopesh", "dreamforged khopeshes"),
        description = ccb.content.text("A light khopesh, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 0.3, stab = 0.8 } }
    item:replace_material("bronze", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "dreamforged_lucerne",
        copy_from = "lucern_hammer",
        looks_like = "lucern_hammer",
        name = ccb.content.plural_text("dreamforged lucerne hammer", "dreamforged lucerne hammers"),
        description = ccb.content.text("A lucerne hammer, forged entirely from dreamdross.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 1.1, stab = 0.9 } }
    item:replace_material("steel", "forged_dreamstuff")
    item:replace_material("wood", "forged_dreamstuff")
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_troll_club",
        name = ccb.content.plural_text("gigantic club", "gigantic club"),
        description = ccb.content.text("An enormous club, almost two and a half meters long, once wielded by a troll."),
        mass_milligrams = 21600000,
        longest_side_mm = 2500,
        melee_to_hit = 0,
        color = "brown",
        looks_like = "2h_club_kanabo_studded",
        symbol = "/",
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        volume_ml = 23000,
        price_cents = 50000,
        price_postapoc_cents = 500,
    }
    item:material("wood", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("ALWAYS_TWOHAND")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 44)
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_troll_giant_mace",
        looks_like = "mace_pipe",
        name = ccb.content.plural_text("gigantic mace", "gigantic maces"),
        description = ccb.content.text("A weapon consisting of a wood handle with a heavy metal head.  This one was once wielded by a troll and is as long as a spear, with an enormous knob of metal thicker than a human body on the end.  You could probably smash down a door in a single blow with this, if you could wield it without collapsing under its weight."),
        mass_milligrams = 15000000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP" },
        weapon_categories = { "MACES" },
        volume_ml = 8000,
        longest_side_mm = 2800,
        melee_to_hit = 2,
        price_cents = 50000,
        price_postapoc_cents = 1500,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("moon_tears", 2)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("ALWAYS_TWOHAND")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 70)
    item:fault_group("handle_long", {  })
    content.add(item)
end
