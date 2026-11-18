local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ion_gun",
        name = ccb.content.plural_text("ion rifle", "ion rifles"),
        description = ccb.content.text("Something something ion, something something wide area.  Don't even ask."),
        mass_milligrams = 2260000,
        volume_ml = 3130,
        longest_side_mm = 780,
        symbol = "|",
        color = "blue",
        replace_pockets = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("MUNDANE")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:cast_spell { spell = "ion_shot_1", no_fail = true, level = 0, need_wielding = true }
    item:tool { charges_per_use = 30, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_grenade_noise_expl",
        name = ccb.content.plural_text("inventor's noise grenade", "inventor's noise grenades"),
        description = ccb.content.text("A small energy grenade with an additional timer slapped onto it.  When triggered, the timer will start to count to 70 seconds.  As it ends a massive explosion will rip your enemies apart."),
        mass_milligrams = 300000,
        volume_ml = 450,
        symbol = "*",
        color = "blue",
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_grenade_noise_expl_act", timer_turns = 70 },
        need_wielding = true,
        menu_text = ccb.content.text("Activate"),
        message = ccb.content.text("You trigger the mechanism, and it starts to whistle!"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_grenade_noise_emp",
        name = ccb.content.plural_text("inventor's noise EMP grenade", "inventor's noise EMP grenades"),
        description = ccb.content.text("A small energy grenade with an additional timer and a whistle slapped onto it.   When triggered, the timer will start to count to 70 seconds.  As it ends a huge EMP explosion will cover the zone."),
        mass_milligrams = 300000,
        volume_ml = 450,
        symbol = "*",
        color = "blue",
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_grenade_noise_emp_act", timer_turns = 70 },
        need_wielding = true,
        menu_text = ccb.content.text("Activate"),
        message = ccb.content.text("You trigger the mechanism, and it starts to whistle!"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_grenade_noise_fire",
        name = ccb.content.plural_text("inventor's noise fire grenade", "inventor's noise fire grenades"),
        description = ccb.content.text("A small energy grenade with an additional timer slapped onto it.  When triggered, the timer will start to count to 70 seconds.  As it ends a massive fire explosion will rip your enemies apart."),
        mass_milligrams = 300000,
        volume_ml = 450,
        symbol = "*",
        color = "blue",
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_grenade_noise_fire_act", timer_turns = 70 },
        need_wielding = true,
        menu_text = ccb.content.text("Activate"),
        message = ccb.content.text("You trigger the mechanism, and it starts to whistle!"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "heater_gun",
        name = ccb.content.plural_text("\"Boiler\"", "\"Boilers\""),
        description = ccb.content.text("A rifle-sized tool that can concentrate heat in a huge range.  It lost its ability to work as a tool as you don't want to accidentally evaporate your materials, but the damage output pays for this with interest."),
        mass_milligrams = 1908000,
        volume_ml = 3130,
        longest_side_mm = 1160,
        symbol = "|",
        color = "blue",
        replace_pockets = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:cast_spell { spell = "heat_expl_gun", no_fail = true, level = 0, need_wielding = true }
    item:tool { charges_per_use = 50, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end
