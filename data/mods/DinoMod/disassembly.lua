local content = require("ccb").content

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

content.add(disassembly("boiled_egg_dino_large", 6000, LIGHT_EXERCISE)
    :component("boiled_egg_dino", 2)
)

content.add(disassembly("skull_dino_small", 1000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 4)
)

content.add(disassembly("skull_dino_med", 2000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 8)
)

content.add(disassembly("skull_dino_large", 4000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 16)
)

content.upsert_uncraft(disassembly("skull_dino_pred_small", 1000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 4)
)

content.upsert_uncraft(disassembly("skull_dino_pred_med", 2000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 8)
)

content.add(disassembly("skull_dino_pred_large", 4000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 16)
)
