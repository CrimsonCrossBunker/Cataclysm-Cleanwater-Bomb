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
