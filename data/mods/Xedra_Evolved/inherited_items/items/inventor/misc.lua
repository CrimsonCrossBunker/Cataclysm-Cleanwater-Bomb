local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "software_AI",
        copy_from = "abstract_software",
        looks_like = "abstract_software",
        name = ccb.content.plural_text("IA software", "IA software"),
        description = ccb.content.text("A simple intelligent agent to provide support in parsing big layers of information."),
        replace_qualities = true,
    }
    item:quality("AI_TOOL", 1)
    item:flag("INVENTOR_CRAFTED")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_water_purifier",
        name = ccb.content.plural_text("ThirstTrouncer Dispenser", "ThirstTrouncer Dispensers"),
        looks_like = "water_purifier",
        description = ccb.content.text("This turbocharged water purifier can turn any water into pure ThirstTrouncer.  Even sewage will be processed, purified and turned into the most hydrating substance ever made through clever application of the principles that rule the purification of water.  Warning: do not consume if hydrated."),
        longest_side_mm = 200,
        symbol = ";",
        volume_ml = 4000,
        mass_milligrams = 1760000,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ELECTRONIC")
    item:flag("INVENTOR_CRAFTED")
    item:fault_group("electronic_general", {  })
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "inventor_heavy_cell",
    }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_oxygen_jelly_machine",
        name = ccb.content.plural_text("Oxyjelly Machine", "Oxyjelly Machines"),
        looks_like = "pressure_cooker",
        description = ccb.content.text("This high-pressure device creates the perfect environment to jellify oxygen, resulting in a compact and light jelly carrying all the benefits of pure oxygen."),
        symbol = ")",
        volume_ml = 8000,
        mass_milligrams = 7000000,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ELECTRONIC")
    item:flag("INVENTOR_CRAFTED")
    item:fault_group("electronic_general", {  })
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "inventor_heavy_cell",
    }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_inventor_time_pierce_tool",
        name = ccb.content.plural_text("Time Piercing Device", "Time Piercing Devices"),
        description = ccb.content.text("A small remote with a sharp spike at the end.  You can activate this device while poking it into a zone of frozen time in order to unfreeze the area you're touching."),
        looks_like = "spike",
        mass_milligrams = 300000,
        volume_ml = 400,
        longest_side_mm = 300,
        symbol = ";",
        color = "white",
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("ELECTRONIC")
    item:flag("INVENTOR_CRAFTED")
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:cast_spell {
        spell = "xedra_inventor_time_pierce",
        no_fail = true,
        level = 1,
        need_wielding = true,
        mundane = true,
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 10)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 150, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_gaming_rig_on",
        copy_from = "inventor_gaming_rig",
        looks_like = "inventor_gaming_rig",
        name = ccb.content.plural_text("Oneiromantic gaming rig (on)", "Oneiromantic gaming rigs (on)"),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_gaming_rig" },
        message = ccb.content.text("The gaming rig powers down."),
        ammo_scale = 0,
    }
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "inventor_gaming_rig" }
    item:tool { power_milliwatts = 3000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "heater_tool",
        name = ccb.content.plural_text("\"Heater\"", "\"Heaters\""),
        description = ccb.content.text("An extremely small and light tool that creates and transfers the heat in an extremely effective way.  You think it would be interesting to develop it further."),
        mass_milligrams = 358000,
        volume_ml = 790,
        longest_side_mm = 250,
        symbol = ";",
        color = "green",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("INVENTOR_CRAFTED")
    item:quality("COOK", 2)
    item:quality("BOIL", 2)
    item:clear_use_actions()
    item:native_use("HOTPLATE")
    item:native_use("HEAT_FOOD")
    item:link_cable {
        cable_length = 10,
        ammo_scale = 0,
        charge_milliwatts = 100000,
        menu_text = ccb.content.text("Plug in / Unplug"),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:fault_group("electronic_general", {  })
    item:tool { charges_per_use = 20, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end
