local content = require("ccb").content

local NO_EXERCISE = 1
local MODERATE_EXERCISE = 4
local ACTIVE_EXERCISE = 8
local EXTRA_EXERCISE = 10

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

content.add(disassembly("broken_claygolem", 1440000, ACTIVE_EXERCISE, { skill = "spellcraft", difficulty = 2 })
    :quality("HAMMER", 1, 1)
    :component("clay_lump", 231)
)

content.add(disassembly("broken_stonegolem", 1440000, ACTIVE_EXERCISE, { skill = "spellcraft", difficulty = 4 })
    :quality("HAMMER", 1, 1)
    :component("rock", 222)
    :component("sharp_rock", 33)
)

content.add(disassembly("broken_irongolem", 2160000, EXTRA_EXERCISE, { skill = "spellcraft", difficulty = 6 })
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :component("scrap", 800)
    :component("lc_steel_lump", 200)
)

content.add(disassembly("broken_forgeborn", 2160000, EXTRA_EXERCISE, { skill = "spellcraft", difficulty = 8 })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("orichalcum_sliver", 80)
    :component("orichalcum_lump", 20)
)

content.add(disassembly("broken_eshaper_golem", 1440000, EXTRA_EXERCISE, { skill = "spellcraft", difficulty = 4 })
    :quality("HAMMER", 1, 1)
    :component("rock", 190)
    :component("sharp_rock", 27)
)

content.add(disassembly("bundle_black_scale", 0, NO_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("CUT", 1, 1)
    :component("dragon_black_scale", 10)
    :component("cotton_patchwork", 3)
)

content.add(disassembly("bundle_black_hide", 0, NO_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("CUT", 1, 1)
    :component("black_dragon_tanned_hide", 10)
)

content.add(disassembly("orrery_item", 720000, MODERATE_EXERCISE, { skill = "fabrication", difficulty = 5, flags = { "BLIND_HARD" } })
    :quality("SCREW", 1, 1)
    :quality("PRY", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("HAMMER", 2, 1)
    :component("clockworks", 30)
    :component("scrap", 20)
    :component("pipe", 9)
    :component("wire", 20)
    :component("hinge", 3)
)
