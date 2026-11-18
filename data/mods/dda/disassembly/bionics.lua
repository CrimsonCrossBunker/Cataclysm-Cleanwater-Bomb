local content = require("ccb").content

local MODERATE_EXERCISE = 4

local function disassembly(result, moves, activity, options)
    options = options or {}
    options.id = "uncraft_" .. result
    options.result = result
    options.uncraft = true
    options.reversible = true
    options.autolearn = false
    options.duration_moves = moves
    options.activity_level = activity
    return content.Recipe(options)
end

content.add(disassembly("bio_power_storage", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 6 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 6)
    :component("amplifier", 4)
    :component("light_battery_cell", 1)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_power_storage_mkII", 90000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 10 })
    :requirement("soldering_standard", 32)
    :quality("SCREW", 1, 1)
    :component("power_supply", 10)
    :component("amplifier", 6)
    :component("light_battery_cell", 1)
    :component("light_battery_cell", 1)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_batteries", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 7 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_ups", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 6 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 2)
    :component("recharge_station", 1)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_evap", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 7 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 2)
    :component("hose", 1)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_flashlight", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 6 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 1)
    :component("amplifier", 1)
    :component("lens", 2)
    :component("burnt_out_bionic", 1)
)

content.add(disassembly("bio_water_extractor", 60000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 7 })
    :requirement("soldering_standard", 20)
    :quality("SCREW", 1, 1)
    :component("power_supply", 2)
    :component("element", 1)
    :component("hose", 1)
    :component("burnt_out_bionic", 1)
)
