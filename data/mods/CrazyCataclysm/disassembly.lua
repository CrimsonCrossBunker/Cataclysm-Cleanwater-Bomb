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

content.add(disassembly("battletorch_done", 12000, MODERATE_EXERCISE)
    :component("bat", 1)
    :component("nomex", 5)
)
