local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
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

content.add(disassembly("battery_car_clay", 30000, LIGHT_EXERCISE)
    :quality("HAMMER", 2, 1)
    :component("chem_sulphuric_acid", 13)
    :component("lead", 2247)
    :component("ceramic_shard", 3)
)

content.replace(disassembly("rock_large", 30000, MODERATE_EXERCISE, { skill = "fabrication" })
    :tool_any({
            { id = "pickaxe_list", charges = 1, requirement = true },
            { id = "jackhammer", charges = 1 },
            { id = "elec_jackhammer", charges = 50 }
        })
    :component("rock", 24)
)

content.add(disassembly("light_battery_cell", 30000, LIGHT_EXERCISE)
    :quality("PRY", 1, 1)
    :component("light_battery_shell", 1)
)

content.add(disassembly("sheet_fibercloth", 3000, NO_EXERCISE)
    :quality("CUT", 2, 1)
    :component("fibercloth_patchwork", 8)
)
