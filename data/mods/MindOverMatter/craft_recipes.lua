local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "grenade_inferno",
    result = "grenade_inferno",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_WEAPONS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 75 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("small_gas_canister_case", 1, true)
    :component_any({
            { id = "matrix_crystal_pyrokin_dust", count = 5 },
            { id = "matrix_crystal_pyrokin_dust_refined", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :requirement("volatile_explosive", 20)
    :requirement("explosives_casting_standard", 1)
    :requires_skill("metaphysics", 3)
    :proficiency("prof_matrix_technology_beginner", { required = false })
)

content.add(content.Recipe {
    id = "psionic_anchoring_crown",
    result = "psionic_anchoring_crown",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_ARMOR",
    duration_moves = 1500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool("swage", 1)
    :component("matrix_crystal_telepath_dust_refined", 6)
    :component("matrix_crystal_teleport_dust_refined", 2)
    :component_any({
            { id = "matrix_crystal_teleportation", count = 1 },
            { id = "matrix_crystal_teleportation_artifact", count = 1 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "steel_lump_any", count = 1, requirement = true }
        })
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 1)
    :requires_skill("metaphysics", 5)
    :book("schematics_anchoring_crown", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_warping", { required = false })
)

content.add(content.Recipe {
    id = "psionic_telepathic_dampener",
    result = "psionic_telepathic_dampener",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_ARMOR",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool("swage", 1)
    :component("psionic_serum_base", 2)
    :component("matrix_crystal_telepath_dust_refined", 6)
    :component("matrix_crystal_telepathy", 1)
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "steel_lump_any", count = 2, requirement = true }
        })
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 1)
    :requires_skill("metaphysics", 6)
    :book("schematics_telepathic_dampener", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_warping", { required = false })
)

content.add(content.Recipe {
    id = "psionic_serum_base",
    result = "psionic_serum_base",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("ether", 100)
    :component_any({
            { id = "matrix_crystal_drained_dust", count = 3 },
            { id = "matrix_crystal_drained_dust_refined", count = 1 }
        })
    :component("water_clean", 5)
    :component("chem_aluminium_powder", 10)
    :component("chem_zinc_powder", 10)
    :requirement("serum_production_standard", 25)
    :book("schematics_reactant_liquid_base", 5)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "matrix_crystal_biokin_dust_refined",
    result = "matrix_crystal_biokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_biokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_biokin_dust_potion",
    result = "matrix_crystal_biokin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_biokin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_clair_dust_refined",
    result = "matrix_crystal_clair_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_clair_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_clair_dust_potion",
    result = "matrix_crystal_clair_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_clair_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_electrokin_dust_refined",
    result = "matrix_crystal_electrokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_electrokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_electrokin_dust_potion",
    result = "matrix_crystal_electrokin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_electrokin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_photokin_dust_refined",
    result = "matrix_crystal_photokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_photokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_photokin_dust_potion",
    result = "matrix_crystal_photokin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_photokin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_pyrokin_dust_refined",
    result = "matrix_crystal_pyrokin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_pyrokin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_pyrokin_dust_potion",
    result = "matrix_crystal_pyrokin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_pyrokin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_telekin_dust_refined",
    result = "matrix_crystal_telekin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_telekin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_telekin_dust_potion",
    result = "matrix_crystal_telekin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_telekin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_telepath_dust_refined",
    result = "matrix_crystal_telepath_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_telepath_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_telepath_dust_potion",
    result = "matrix_crystal_telepath_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_telepath_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_teleport_dust_refined",
    result = "matrix_crystal_teleport_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_teleport_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_teleport_dust_potion",
    result = "matrix_crystal_teleport_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_teleport_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_vitakin_dust_refined",
    result = "matrix_crystal_vitakin_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_vitakin_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "matrix_crystal_vitakin_dust_potion",
    result = "matrix_crystal_vitakin_dust_potion",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("matrix_crystal_vitakin_dust_refined", 1)
    :component("water_clean", 1)
    :learn_automatically("chemistry", 5)
    :learn_automatically("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 1)
    :book("recipe_survivor_matrix_crystal_ground", 1)
)

content.add(content.Recipe {
    id = "matrix_crystal_drained_dust_refined",
    result = "matrix_crystal_drained_dust_refined",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET", "BLIND_HARD" },
}
    :tool("microscope", 1)
    :component("matrix_crystal_drained_dust", 3)
    :quality("FINE_GRIND", 1, 1)
    :quality("BOIL", 1, 1)
    :requirement("any_strong_acid", 2)
    :requirement("surface_heat", 30)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_crystal_ground", 5)
    :book("recipe_survivor_matrix_crystal_ground", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_inorganic_chemistry", { required = false })
)

content.add(content.Recipe {
    id = "psionic_instability_remover",
    result = "psionic_instability_remover",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_MEDICAL",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("psionic_serum_base", 10)
    :component("matrix_crystal_biokin_dust", 4)
    :component("matrix_crystal_vitakin_dust_refined", 4)
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("serum_production_standard", 25)
    :requires_skill("metaphysics", 4)
    :book("schematics_instability_remover", 7)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_pharmaceutical", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_morphic", { required = false })
    :proficiency("prof_psionic_minimum_requirements_vitakinesis", { required = true })
    :batch_discount(80, 3)
)

content.add(content.Recipe {
    id = "psionic_purifier_vita",
    result = "psionic_purifier_vita",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_MEDICAL",
    duration_moves = 2100000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("psionic_serum_base", 5)
    :component("matrix_crystal_biokin_dust_refined", 3)
    :component("matrix_crystal_pyrokin_dust", 2)
    :component("matrix_crystal_vitakin_dust_refined", 3)
    :component_any({
            { id = "mutagen_chelator", count = 1 },
            { id = "iv_purifier", count = 1 }
        })
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("serum_production_standard", 25)
    :requires_skill("metaphysics", 5)
    :book("schematics_psionic_purifier", 8)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_pharmaceutical", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = true })
    :proficiency("prof_psionic_morphic", { required = false })
    :proficiency("prof_psionic_minimum_requirements_vitakinesis", { required = true })
)

content.add(content.Recipe {
    id = "psi_noetic_resilience_treatment",
    result = "psi_noetic_resilience_treatment",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_MEDICAL",
    duration_moves = 1680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("psionic_serum_base", 3)
    :component("thorazine", 2)
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("serum_production_standard", 25)
    :requirement("matrix_dust_refined", 4)
    :requires_skill("metaphysics", 3)
    :book("schematics_noetic_resilience", 6)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_pharmaceutical", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_warping", { required = false })
)

content.add(content.Recipe {
    id = "panacea",
    result = "panacea",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_MEDICAL",
    duration_moves = 1680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("psionic_serum_base", 5)
    :component("thorazine", 2)
    :component_any({
            { id = "antifungal", count = 2 },
            { id = "antiparasitic", count = 2 }
        })
    :component_any({
            { id = "antibiotics", count = 2 },
            { id = "weak_antibiotic", count = 5 },
            { id = "strong_antibiotic", count = 1 }
        })
    :component_any({
            { id = "acetaminophen", count = 1 },
            { id = "aspirin", count = 1 },
            { id = "ibuprofen", count = 1 }
        })
    :component("matrix_crystal_vitakin_dust_refined", 5)
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("serum_production_standard", 25)
    :requires_skill("metaphysics", 5)
    :book("schematics_panaceus", 6)
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_pharmaceutical", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_minimum_requirements_vitakinesis", { required = true })
)

content.add(content.Recipe {
    id = "matrix_channeling_tool",
    result = "matrix_channeling_tool",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool_charges("angle_grinder", 50)
    :component("matrix_crystal_drained", 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :quality("VISE", 1, 1)
    :requirement("soldering_standard", 15)
    :requirement("steel_chunk_any", 5)
    :requires_skill("metaphysics", 3)
    :book("schematics_matrix_channeling", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_matrix_technology_beginner", { required = false })
)

content.add(content.Recipe {
    id = "matrix_aligning_tool",
    result = "matrix_aligning_tool",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool("swage", 1)
    :component("matrix_shard", 6)
    :component("matrix_crystal_drained_dust_refined", 5)
    :component_any({
            { id = "gold_small", count = 15 },
            { id = "silver_small", count = 25 }
        })
    :quality("HAMMER_FINE", 1, 1)
    :quality("GRIND", 2, 1)
    :quality("CHISEL", 3, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :requirement("soldering_standard", 15)
    :requirement("steel_chunk_any", 5)
    :requires_skill("metaphysics", 6)
    :book("schematics_matrix_aligning", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_matrix_technology_beginner", { required = false })
    :proficiency("prof_fine_metalsmithing", { required = false })
)

content.add(content.Recipe {
    id = "telepathic_focusing_tool",
    result = "telepathic_focusing_tool",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool("swage", 1)
    :component("matrix_shard", 12)
    :component("matrix_crystal_telepath_dust_refined", 5)
    :component("matrix_crystal_telepathy", 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("GRIND", 2, 1)
    :quality("CHISEL", 3, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :requirement("soldering_standard", 15)
    :requirement("steel_chunk_any", 15)
    :requires_skill("metaphysics", 5)
    :book("schematics_telepathic_focusing_tool", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = false })
    :proficiency("prof_fine_metalsmithing", { required = false })
)

content.add(content.Recipe {
    id = "pyrokinetic_flashlight",
    result = "pyrokinetic_flashlight",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("amplifier", 1)
    :component_any({
            { id = "scrap_aluminum", count = 4 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "bottle_glass", count = 1 },
            { id = "plastic_bottles_any", count = 1, requirement = true }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("matrix_crystal_electrokin_dust_refined", 2)
    :component("psionic_serum_base", 1)
    :component("cable", 4)
    :quality("MATRIX_CHANNEL", 1, 1)
    :learn_by_disassembly("electronics", 0)
    :book("schematics_everglow_lamp", 1)
    :proficiency("prof_matrix_technology_beginner")
)

content.add(content.Recipe {
    id = "pyrokinetic_lamp",
    result = "pyrokinetic_lamp",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("plastic_chunk", 2)
    :component("glue_strong", 1)
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("matrix_crystal_electrokin_dust_refined", 2)
    :component("psionic_serum_base", 2)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :requires_skill("metaphysics", 2)
    :learn_by_disassembly("electronics", 1)
    :book("schematics_everglow_lamp", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_matrix_technology_beginner")
)

content.add(content.Recipe {
    id = "standing_pyrokinetic_lamp",
    result = "standing_pyrokinetic_lamp",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("pyrokinetic_lamp", 1)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
)

content.add(content.Recipe {
    id = "psionic_transporter_beacon",
    result = "psionic_transporter_beacon",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 9,
    flags = { "SECRET", "BLIND_HARD" },
}
    :component("psionic_serum_base", 10)
    :component("matrix_shard", 8)
    :component("matrix_crystal_drained", 1)
    :component("matrix_crystal_teleport_dust_refined", 8)
    :component("matrix_crystal_pyrokin_dust_refined", 3)
    :component("matrix_crystal_clair_dust_refined", 8)
    :component("memory_card", 2)
    :component("plastic_chunk", 4)
    :component("glue_strong", 1)
    :component("RAM", 4)
    :component("amplifier", 2)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("e_scrap", 3)
    :component("betavoltaic", 1)
    :component_any({
            { id = "beaker", count = 2 },
            { id = "flask_glass", count = 2 },
            { id = "bottle_glass", count = 2 }
        })
    :quality("SCREW", 1, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("metaphysics", 4)
    :requires_skill("computer", 5)
    :book("schematics_transporters", 9)
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_warping", { required = false })
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_circuits", { required = true })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_integrated_circuits", { required = true })
    :batch_discount(80, 3)
)

content.add(content.Recipe {
    id = "psionic_transporter_remote",
    result = "psionic_transporter_remote",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("psionic_serum_base", 2)
    :component("matrix_crystal_teleport_dust_refined", 1)
    :component("matrix_crystal_clair_dust_refined", 1)
    :component("matrix_channeling_tool", 1)
    :component("plastic_chunk", 1)
    :component("e_scrap", 1)
    :component("RAM", 2)
    :component("amplifier", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("small_lcd_screen", 1)
    :component("test_tube", 2)
    :quality("SCREW", 1, 1)
    :quality("MATRIX_CHANNEL", 1, 1)
    :quality("MATRIX_FOCUS", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("metaphysics", 4)
    :requires_skill("computer", 4)
    :book("schematics_transporters", 6)
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_warping", { required = false })
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_circuits", { required = true })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_integrated_circuits")
    :batch_discount(80, 3)
)

content.add(content.Recipe {
    id = "grenade_inferno_makeshift",
    result = "grenade_inferno_makeshift",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_WEAPONS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 75 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("small_gas_canister_case", 1, true)
    :component_any({
            { id = "matrix_crystal_pyrokin_dust", count = 5 },
            { id = "matrix_crystal_pyrokin_dust_refined", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("volatile_explosive", 20)
    :requires_skill("metaphysics", 2)
    :book("schematics_grenade_inferno", 3)
    :proficiency("prof_matrix_technology_beginner", { required = false })
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "pyrokinetic_matrix_crystal_bomb",
    result = "pyrokinetic_matrix_crystal_bomb",
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_WEAPONS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "metaphysics",
    difficulty = 6,
}
    :component_any({
            { id = "matrix_crystal_pyrokinesis", count = 1 },
            { id = "matrix_crystal_pyrokinesis_artifact", count = 1 }
        })
    :book("schematics_grenade_inferno", 6)
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_minimum_requirements_pyrokinesis", { required = true })
)
