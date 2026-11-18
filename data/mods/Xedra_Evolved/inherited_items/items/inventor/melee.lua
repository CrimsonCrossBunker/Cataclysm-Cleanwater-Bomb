local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "combatsaw_spear_on",
        copy_from = "combatsaw_spear_off",
        looks_like = "combatsaw_spear_off",
        name = ccb.content.plural_text("chainsaw spear (on)", "chainsaw spears (on)"),
        description = ccb.content.text("A lightweight, handheld cordless circular saw.  It is currently on and the blade is spinning; use this item to turn it off."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 36)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "combatsaw_spear_off" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn off the %s."),
    }
    item:flag("MESSY")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "combatsaw_spear_off" }
    item:tool { power_milliwatts = 350000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "megachette",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("megachette (extended)", "megachettes (extended)"),
        description = ccb.content.text("A completely flat, single-edged blade.  While very visually appealing, it is no less deadly.  It can be folded more times than makes sense."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "megachette_folded" },
        menu_text = ccb.content.text("Fold"),
        message = ccb.content.text("With a few moves, the megachette is folded."),
    }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "mc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_plasma_axe_off",
        category = "weapons",
        name = ccb.content.plural_text("\"Neon Angle\" (off)", "\"Neon Angles\" (off)"),
        description = ccb.content.text("A light, hollow aluminum bar with an installed plasma torch on the end in the form of a circle, emitting 28000 centrigrades of heat on demand.  This probably violates dozens of OSHA regulations."),
        mass_milligrams = 1883000,
        volume_ml = 2221,
        longest_side_mm = 1000,
        melee_to_hit = 2,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP", "PLASMA_AXE_WIDE" },
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
        replace_pockets = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_plasma_axe" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:flag("MUNDANE")
    item:flag("INVENTOR_CRAFTED")
    item:tool { ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 20000,
        max_weight_milligrams = 20000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_plasma_axe",
        copy_from = "inventor_plasma_axe_off",
        looks_like = "inventor_plasma_axe_off",
        name = ccb.content.plural_text("\"Neon Angle\" (on)", "\"Neon Angles\" (on)"),
        description = ccb.content.text("A light, hollow aluminum bar with an installed plasma torch on the end in the form of a circle, emitting 28000 centrigrades of heat on demand.  This probably violates dozens of OSHA regulations."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("heat", 46)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_plasma_axe_off" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("You turn off the %s."),
    }
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "inventor_plasma_axe_off" }
    item:tool { power_milliwatts = 900000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "combatsaw_spear_off",
        category = "weapons",
        name = ccb.content.plural_text("chainsaw spear (off)", "chainsaw spears (off)"),
        description = ccb.content.text("A hand-made lightened engine, with chain blades on a long stick.  The only reason it works without falling apart is because your calculations can't be wrong."),
        mass_milligrams = 3300000,
        volume_ml = 2250,
        longest_side_mm = 2200,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        weapon_categories = { "POLEARMS", "SPEARS" },
        techniques = { "SWEEP", "IMPALE", "SPIN" },
        replace_pockets = true,
        charged_qualities = { { id = "CUT", level = 1 }, { id = "SAW_W", level = 2 }, { id = "BUTCHER", level = -50 } },
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 1)
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "combatsaw_spear_on" },
        message = ccb.content.text("You turn on the %s."),
        need_charges = 1,
        need_charges_message = ccb.content.text("The batteries are dead."),
    }
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("DURABLE_MELEE")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("MUNDANE")
    item:flag("INVENTOR_CRAFTED")
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 20000,
        max_weight_milligrams = 20000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end
