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

content.add(disassembly("broken_laserturret", 360000, MODERATE_EXERCISE, { skill = "electronics", difficulty = 4 })
    :requirement("soldering_standard", 10)
    :quality("SCREW", 1, 1)
    :component("ai_module", 1)
    :component("gun_module", 1)
    :component("targeting_module", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("v29_turret", 1)
    :component("medium_storage_battery", 1)
    :component("solar_cell", 4)
    :component("power_supply", 1)
    :component("robot_controls", 1)
    :component("turret_chassis", 1)
)

content.upsert_uncraft(disassembly("reverse_jointed_legs", 2400000, MODERATE_EXERCISE, { skill = "mechanics", difficulty = 4 })
    :requirement("soldering_standard", 5)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :component("motor_tiny", 6)
    :component("power_supply", 6)
    :component("cable", 4)
    :component("steel_chunk_any", 6, true)
)
