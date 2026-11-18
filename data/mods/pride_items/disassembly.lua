local content = require("ccb").content

local NO_EXERCISE = 1

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

content.add(disassembly("pride_flag", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("sheet", 7)
    :component("sheet_cotton", 6)
)
