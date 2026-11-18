local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.replace(content.Recipe {
    id = "lens_crude",
    result = "lens_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 5)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "magnifying_glass",
    result = "magnifying_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("2x4", 1)
    :component("lens_crude", 1)
    :component("glue_strong", 2)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("cordage_short", 3)
    :proficiency("prof_carving")
    :byproduct("splinter", 15)
)

content.replace(content.Recipe {
    id = "matrix_crystal_biokin_dust_refined",
    result = "matrix_crystal_biokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_biokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_clair_dust_refined",
    result = "matrix_crystal_clair_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_clair_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_electrokin_dust_refined",
    result = "matrix_crystal_electrokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_electrokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_photokin_dust_refined",
    result = "matrix_crystal_photokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_photokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_pyrokin_dust_refined",
    result = "matrix_crystal_pyrokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_pyrokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_telekin_dust_refined",
    result = "matrix_crystal_telekin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_telekin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_telepath_dust_refined",
    result = "matrix_crystal_telepath_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_telepath_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_teleport_dust_refined",
    result = "matrix_crystal_teleport_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_teleport_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_vitakin_dust_refined",
    result = "matrix_crystal_vitakin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_vitakin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.replace(content.Recipe {
    id = "matrix_crystal_drained_dust_refined",
    result = "matrix_crystal_drained_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "BLIND_HARD" },
}
    :tool("magnifying_glass", 1)
    :component("matrix_crystal_drained_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)
