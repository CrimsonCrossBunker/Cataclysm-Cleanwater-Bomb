local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

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

content.add(disassembly("matrix_crystal_biokinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_biokin_dust", 10)
)

content.add(disassembly("matrix_crystal_biokinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_biokin_dust", 10)
)

content.add(disassembly("matrix_crystal_clairsentience", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_clair_dust", 10)
)

content.add(disassembly("matrix_crystal_clairsentience_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_clair_dust", 10)
)

content.add(disassembly("matrix_crystal_electrokinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_electrokin_dust", 10)
)

content.add(disassembly("matrix_crystal_electrokinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_electrokin_dust", 10)
)

content.add(disassembly("matrix_crystal_photokinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_photokin_dust", 10)
)

content.add(disassembly("matrix_crystal_photokinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_photokin_dust", 10)
)

content.add(disassembly("matrix_crystal_pyrokinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_pyrokin_dust", 10)
)

content.add(disassembly("matrix_crystal_pyrokinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_pyrokin_dust", 10)
)

content.add(disassembly("matrix_crystal_telekinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_telekin_dust", 10)
)

content.add(disassembly("matrix_crystal_telekinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_telekin_dust", 10)
)

content.add(disassembly("matrix_crystal_telepathy", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_telepath_dust", 10)
)

content.add(disassembly("matrix_crystal_teleportation", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_teleport_dust", 10)
)

content.add(disassembly("matrix_crystal_teleportation_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_teleport_dust", 10)
)

content.add(disassembly("matrix_crystal_vitakinesis", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_vitakin_dust", 10)
)

content.add(disassembly("matrix_crystal_vitakinesis_artifact", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_vitakin_dust", 10)
)

content.add(disassembly("matrix_crystal_drained", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_drained_dust", 10)
)

content.add(disassembly("matrix_shard", 270000, BRISK_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :component("matrix_crystal_drained_dust", 25)
)

content.add(disassembly("psionic_transporter_remote", 270000, LIGHT_EXERCISE, { difficulty = 4 })
    :quality("SCREW", 1, 1)
    :component("matrix_channeling_tool", 1)
    :component("e_scrap", 1)
    :component("RAM", 2)
    :component("amplifier", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("small_lcd_screen", 1)
)

content.add(disassembly("psionic_transporter_remote_on", 270000, LIGHT_EXERCISE, { difficulty = 4 })
    :quality("SCREW", 1, 1)
    :component("matrix_channeling_tool", 1)
    :component("e_scrap", 1)
    :component("RAM", 2)
    :component("amplifier", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("small_lcd_screen", 1)
)

content.add(disassembly("psionic_transporter_remote_broken", 270000, LIGHT_EXERCISE, { difficulty = 4 })
    :quality("SCREW", 1, 1)
    :component("matrix_crystal_drained", 1)
    :component("e_scrap", 5)
    :component("cable", 1)
)
