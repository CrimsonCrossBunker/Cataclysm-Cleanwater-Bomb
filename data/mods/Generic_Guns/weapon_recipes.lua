local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "pistol_pipe_smg",
    result = "pistol_pipe_smg",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 5,
}
    :tool_any({
            { id = "pistol_ball", count = 1 },
            { id = "pistol_jhp", count = 1 },
            { id = "reloaded_pistol_ball", count = 1 },
            { id = "reloaded_pistol_jhp", count = 1 },
            { id = "bp_pistol_ball", count = 1 },
            { id = "bp_pistol_jhp", count = 1 },
            { id = "pistol_casing", count = 1 }
        })
    :component("pipe", 4)
    :component("spring", 1)
    :component("steel_chunk_any", 3, true)
    :component("scrap", 3)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("gun", 3)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "pistol_magnum_pipe_levergun",
    result = "pistol_magnum_pipe_levergun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 6,
}
    :tool_any({
            { id = "pistol_ball", count = 1 },
            { id = "pistol_jhp", count = 1 },
            { id = "reloaded_pistol_ball", count = 1 },
            { id = "reloaded_pistol_jhp", count = 1 },
            { id = "bp_pistol_ball", count = 1 },
            { id = "bp_pistol_jhp", count = 1 },
            { id = "pistol_magnum_ball", count = 1 },
            { id = "pistol_magnum_jhp", count = 1 },
            { id = "reloaded_pistol_magnum_ball", count = 1 },
            { id = "reloaded_pistol_magnum_jhp", count = 1 },
            { id = "bp_pistol_magnum_ball", count = 1 },
            { id = "bp_pistol_magnum_jhp", count = 1 },
            { id = "pistol_casing", count = 1 },
            { id = "pistol_magnum_casing", count = 1 }
        })
    :component("pipe", 2)
    :component("spring", 1)
    :component("steel_chunk_any", 3, true)
    :component("2x4", 1)
    :component("scrap", 3)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("gun", 3)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "black_powder_revolver",
    result = "black_powder_revolver",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("tongs", 1)
    :tool("swage", 1)
    :component("pipe", 1)
    :component("spring", 2)
    :component("steel_chunk_any", 2, true)
    :component("scrap", 2)
    :component("sharp_rock", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("GLARE", 1, 1)
    :requirement("blacksmithing_standard", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 6)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
)

content.add(content.Recipe {
    id = "pistol_tiny_zip",
    result = "pistol_tiny_zip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 72000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :tool_any({
            { id = "tiny_pistol_ball", count = 1 },
            { id = "tiny_pistol_jhp", count = 1 },
            { id = "bp_tiny_pistol_ball", count = 1 },
            { id = "bp_tiny_pistol_jhp", count = 1 },
            { id = "reloaded_tiny_pistol_ball", count = 1 },
            { id = "reloaded_tiny_pistol_jhp", count = 1 },
            { id = "pistol_tiny_casing", count = 1 }
        })
    :component("pipe", 1)
    :component("scrap", 1)
    :component("duct_tape", 50)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "pistol_magnum_pipe",
    result = "pistol_magnum_pipe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 84000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 3,
}
    :tool_any({
            { id = "pistol_ball", count = 1 },
            { id = "pistol_jhp", count = 1 },
            { id = "reloaded_pistol_ball", count = 1 },
            { id = "reloaded_pistol_jhp", count = 1 },
            { id = "bp_pistol_ball", count = 1 },
            { id = "bp_pistol_jhp", count = 1 },
            { id = "pistol_magnum_ball", count = 1 },
            { id = "pistol_magnum_jhp", count = 1 },
            { id = "reloaded_pistol_magnum_ball", count = 1 },
            { id = "reloaded_pistol_magnum_jhp", count = 1 },
            { id = "bp_pistol_magnum_ball", count = 1 },
            { id = "bp_pistol_magnum_jhp", count = 1 },
            { id = "pistol_casing", count = 1 },
            { id = "pistol_magnum_casing", count = 1 }
        })
    :component("pipe", 1)
    :component("scrap", 2)
    :component("steel_chunk_any", 1, true)
    :component("2x4", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "shot_pipe_double",
    result = "shot_pipe_double",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 108000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 3,
}
    :tool_any({
            { id = "shot_buck", count = 1 },
            { id = "shot_bean", count = 1 },
            { id = "shot_fowl", count = 1 },
            { id = "shot_foster", count = 1 },
            { id = "shot_pyro", count = 1 },
            { id = "bp_shot_junk", count = 1 },
            { id = "bp_shot_buck", count = 1 },
            { id = "bp_shot_fowl", count = 1 },
            { id = "bp_shot_foster", count = 1 },
            { id = "bp_shot_pyro", count = 1 },
            { id = "bp_shot_dart", count = 1 },
            { id = "reloaded_shot_junk", count = 1 },
            { id = "reloaded_shot_buck", count = 1 },
            { id = "reloaded_shot_fowl", count = 1 },
            { id = "reloaded_shot_foster", count = 1 },
            { id = "reloaded_shot_pyro", count = 1 },
            { id = "reloaded_shot_dart", count = 1 },
            { id = "shot_casing", count = 1 }
        })
    :component("pipe", 2)
    :component("scrap", 3)
    :component("2x4", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "black_powder_pistol",
    result = "black_powder_pistol",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("tongs", 1)
    :tool("swage", 1)
    :component("2x4", 1)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_standard", 3)
    :requires_skill("pistol", 4)
    :book("manual_pistol", 5)
    :book("mag_pistol", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "black_powder_rifle",
    result = "black_powder_rifle",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("swage", 1)
    :component("2x4", 1)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_standard", 1)
    :requires_skill("rifle", 3)
    :book("manual_rifle", 5)
    :book("mag_rifle", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "slamfire_shotgun",
    result = "slamfire_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
}
    :tool_any({
            { id = "shot_buck", count = 1 },
            { id = "shot_fowl", count = 1 },
            { id = "shot_pyro", count = 1 },
            { id = "shot_foster", count = 1 },
            { id = "shot_bean", count = 1 },
            { id = "reloaded_shot_buck", count = 1 },
            { id = "reloaded_shot_fowl", count = 1 },
            { id = "reloaded_shot_pyro", count = 1 },
            { id = "reloaded_shot_dart", count = 1 },
            { id = "reloaded_shot_foster", count = 1 },
            { id = "reloaded_shot_junk", count = 1 },
            { id = "bp_shot_buck", count = 1 },
            { id = "bp_shot_fowl", count = 1 },
            { id = "bp_shot_pyro", count = 1 },
            { id = "bp_shot_dart", count = 1 },
            { id = "bp_shot_foster", count = 1 },
            { id = "bp_shot_junk", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 2)
    :component("nails", 1, true)
    :component("scrap", 3)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 1)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.replace(content.Recipe {
    id = "slamfire_shotgun_without_welding",
    result = "slamfire_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :tool_any({
            { id = "shot_buck", count = 1 },
            { id = "shot_fowl", count = 1 },
            { id = "shot_pyro", count = 1 },
            { id = "shot_foster", count = 1 },
            { id = "shot_bean", count = 1 },
            { id = "reloaded_shot_buck", count = 1 },
            { id = "reloaded_shot_fowl", count = 1 },
            { id = "reloaded_shot_pyro", count = 1 },
            { id = "reloaded_shot_dart", count = 1 },
            { id = "reloaded_shot_foster", count = 1 },
            { id = "reloaded_shot_junk", count = 1 },
            { id = "bp_shot_buck", count = 1 },
            { id = "bp_shot_fowl", count = 1 },
            { id = "bp_shot_pyro", count = 1 },
            { id = "bp_shot_dart", count = 1 },
            { id = "bp_shot_foster", count = 1 },
            { id = "bp_shot_junk", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 2)
    :component("nails", 1, true)
    :component("pipe_fittings", 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.replace(content.Recipe {
    id = "slamfire_shotgun_d",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :tool_any({
            { id = "shot_buck", count = 1 },
            { id = "shot_fowl", count = 1 },
            { id = "shot_pyro", count = 1 },
            { id = "shot_foster", count = 1 },
            { id = "shot_bean", count = 1 },
            { id = "reloaded_shot_buck", count = 1 },
            { id = "reloaded_shot_fowl", count = 1 },
            { id = "reloaded_shot_pyro", count = 1 },
            { id = "reloaded_shot_dart", count = 1 },
            { id = "reloaded_shot_foster", count = 1 },
            { id = "reloaded_shot_junk", count = 1 },
            { id = "bp_shot_buck", count = 1 },
            { id = "bp_shot_fowl", count = 1 },
            { id = "bp_shot_pyro", count = 1 },
            { id = "bp_shot_dart", count = 1 },
            { id = "bp_shot_foster", count = 1 },
            { id = "bp_shot_junk", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 4)
    :component("nails", 2, true)
    :component("scrap", 5)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 1)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "slamfire_shotgun_d_welded_and_bolted",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :tool_any({
            { id = "shot_buck", count = 1 },
            { id = "shot_fowl", count = 1 },
            { id = "shot_pyro", count = 1 },
            { id = "shot_foster", count = 1 },
            { id = "shot_bean", count = 1 },
            { id = "reloaded_shot_buck", count = 1 },
            { id = "reloaded_shot_fowl", count = 1 },
            { id = "reloaded_shot_pyro", count = 1 },
            { id = "reloaded_shot_dart", count = 1 },
            { id = "reloaded_shot_foster", count = 1 },
            { id = "reloaded_shot_junk", count = 1 },
            { id = "bp_shot_buck", count = 1 },
            { id = "bp_shot_fowl", count = 1 },
            { id = "bp_shot_pyro", count = 1 },
            { id = "bp_shot_dart", count = 1 },
            { id = "bp_shot_foster", count = 1 },
            { id = "bp_shot_junk", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 4)
    :component("nails", 2, true)
    :component("pipe_fittings", 2)
    :component("scrap", 2)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 1)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.replace(content.Recipe {
    id = "slamfire_shotgun_d_welded_together",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component("slamfire_shotgun", 2)
    :component("scrap", 2)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "slamfire_shotgun_d_taped_together",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :component("slamfire_shotgun", 2)
    :component("duct_tape", 100)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "grenade_ammo_shot",
    result = "grenade_ammo_shot",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_GRENADES",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax", count = 1 }
        })
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_pistol", count = 30 },
            { id = "gunpowder_shotgun", count = 30 }
        })
    :quality("CUT", 2, 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 12)
    :requirement("req_grenade", -1)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "grenade_ammo_slug",
    result = "grenade_ammo_slug",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_GRENADES",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax", count = 1 }
        })
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_pistol", count = 30 },
            { id = "gunpowder_shotgun", count = 30 }
        })
    :quality("CUT", 2, 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 12)
    :requirement("req_grenade", -1)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_tiny_pistol_jhp",
    result = "reloaded_tiny_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "gunpowder", count = 2 },
            { id = "gunpowder_pistol", count = 2 },
            { id = "gunpowder_shotgun", count = 2 }
        })
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_tiny_pistol_jhp",
    result = "bp_tiny_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 2)
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_tiny_pistol_jhp",
    result = "matchhead_tiny_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("red_phosphorous", 2)
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_tiny_pistol_ball",
    result = "reloaded_tiny_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "gunpowder", count = 2 },
            { id = "gunpowder_pistol", count = 2 }
        })
    :component("copper", 1)
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_tiny_pistol_ball",
    result = "bp_tiny_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 2)
    :component("copper", 1)
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_tiny_pistol_ball",
    result = "matchhead_tiny_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("red_phosphorous", 2)
    :component("copper", 1)
    :requirement("req_pistol_tiny", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_pistol_jhp",
    result = "reloaded_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 4 },
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_pistol_jhp",
    result = "bp_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 4)
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_pistol_jhp",
    result = "matchhead_pistol_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("red_phosphorous", 4)
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_pistol_ball",
    result = "reloaded_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 4 },
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :component_any({
            { id = "copper", count = 1 },
            { id = "pistol_tiny_casing", count = 1 }
        })
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_pistol_ball",
    result = "bp_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 4)
    :component_any({
            { id = "copper", count = 1 },
            { id = "pistol_tiny_casing", count = 1 }
        })
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_pistol_ball",
    result = "matchhead_pistol_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("red_phosphorous", 4)
    :component_any({
            { id = "copper", count = 1 },
            { id = "pistol_tiny_casing", count = 1 }
        })
    :requirement("req_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 1)
    :book("manual_pistol", 2)
    :book("recipe_bullets", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_pistol_magnum_jhp",
    result = "reloaded_pistol_magnum_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_rifle", count = 6 },
            { id = "gunpowder_magnum_pistol", count = 6 }
        })
    :requirement("req_pistol_magnum", 1)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 3)
    :book("manual_pistol", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_pistol_magnum_jhp",
    result = "bp_pistol_magnum_jhp",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("chem_black_powder", 6)
    :requirement("req_pistol_magnum", 1)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 3)
    :book("manual_pistol", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_pistol_magnum_ball",
    result = "reloaded_pistol_magnum_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_rifle", count = 6 },
            { id = "gunpowder_magnum_pistol", count = 6 }
        })
    :component_any({
            { id = "copper", count = 2 },
            { id = "pistol_magnum_casing", count = 1 }
        })
    :requirement("req_pistol_magnum", 1)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 3)
    :book("manual_pistol", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_pistol_magnum_ball",
    result = "bp_pistol_magnum_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("chem_black_powder", 6)
    :component_any({
            { id = "copper", count = 2 },
            { id = "pistol_magnum_casing", count = 1 }
        })
    :requirement("req_pistol_magnum", 1)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 3)
    :book("manual_pistol", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "black_powder_ball",
    result = "black_powder_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 5)
    :component("paper", 1)
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 10)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "black_powder_shot",
    result = "black_powder_shot",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 5)
    :component("paper", 1)
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 10)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_ball",
    result = "reloaded_rifle_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 12 },
            { id = "gunpowder_magnum_pistol", count = 12 },
            { id = "gunpowder_rifle", count = 12 },
            { id = "gunpowder_large_rifle", count = 12 }
        })
    :requirement("req_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_ball_foreign",
    result = "reloaded_rifle_ball_foreign",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 12 },
            { id = "gunpowder_magnum_pistol", count = 12 },
            { id = "gunpowder_rifle", count = 12 },
            { id = "gunpowder_large_rifle", count = 12 }
        })
    :requirement("req_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_ball_foreign",
    result = "bp_rifle_ball_foreign",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 12)
    :requirement("req_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_AP_foreign",
    result = "reloaded_rifle_AP_foreign",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 12 },
            { id = "gunpowder_magnum_pistol", count = 12 },
            { id = "gunpowder_rifle", count = 12 },
            { id = "gunpowder_large_rifle", count = 12 }
        })
    :requirement("req_rifle", 1)
    :requirement("req_penetrator_rifle_alien", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_AP_foreign",
    result = "bp_rifle_AP_foreign",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 12)
    :requirement("req_rifle", 1)
    :requirement("req_penetrator_rifle_alien", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_ball",
    result = "bp_rifle_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 12)
    :requirement("req_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_AP",
    result = "reloaded_rifle_AP",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "gunpowder", count = 12 },
            { id = "gunpowder_magnum_pistol", count = 12 },
            { id = "gunpowder_rifle", count = 12 },
            { id = "gunpowder_large_rifle", count = 12 }
        })
    :component("copper", 3)
    :requirement("req_rifle", 1)
    :requirement("req_penetrator_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_AP",
    result = "bp_rifle_AP",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 12)
    :component("copper", 3)
    :requirement("req_rifle", 1)
    :requirement("req_penetrator_rifle", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_huge_ball",
    result = "reloaded_rifle_huge_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_large_rifle", count = 30 }
        })
    :requirement("req_rifle_huge", 1)
    :requirement("bullet_forming", 18)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 7)
    :book("recipe_bullets", 6)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_huge_ball",
    result = "bp_rifle_huge_ball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component("chem_black_powder", 30)
    :requirement("req_rifle_huge", 1)
    :requirement("bullet_forming", 18)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 7)
    :book("recipe_bullets", 6)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_rifle_huge_AP",
    result = "reloaded_rifle_huge_AP",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_large_rifle", count = 30 }
        })
    :component_any({
            { id = "copper", count = 6 },
            { id = "rifle_casing", count = 1 }
        })
    :requirement("req_rifle_huge", 1)
    :requirement("req_penetrator_rifle_huge", 1)
    :requirement("bullet_forming", 21)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 7)
    :book("recipe_bullets", 6)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_rifle_huge_AP",
    result = "bp_rifle_huge_AP",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_large_rifle", count = 30 }
        })
    :component_any({
            { id = "copper", count = 6 },
            { id = "rifle_casing", count = 1 }
        })
    :requirement("req_rifle_huge", 1)
    :requirement("req_penetrator_rifle_huge", 1)
    :requirement("bullet_forming", 21)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 7)
    :book("recipe_bullets", 6)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_buck",
    result = "reloaded_shot_buck",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_pistol", count = 6 },
            { id = "gunpowder_shotgun", count = 6 }
        })
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_buck",
    result = "bp_shot_buck",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component("chem_black_powder", 6)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_buck_with_dowel",
    result = "bp_shot_buck",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_fowl",
    result = "reloaded_shot_fowl",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 3 },
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_fowl",
    result = "bp_shot_fowl",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 3)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_fowl_with_dowel",
    result = "bp_shot_fowl",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 3)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_pyro",
    result = "reloaded_shot_pyro",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 3 },
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("magnesium", 5)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_pyro",
    result = "bp_shot_pyro",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component("chem_black_powder", 3)
    :component("magnesium", 5)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_pyro_with_dowel",
    result = "bp_shot_pyro",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_foster",
    result = "reloaded_shot_foster",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_pistol", count = 6 },
            { id = "gunpowder_shotgun", count = 6 }
        })
    :requirement("bullet_forming", 1)
    :requirement("ammo_bullet", 20)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_foster",
    result = "bp_shot_foster",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("press", 1)
    :component("chem_black_powder", 6)
    :requirement("bullet_forming", 1)
    :requirement("ammo_bullet", 20)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_foster_with_dowel",
    result = "bp_shot_foster",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_dart",
    result = "reloaded_shot_dart",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_pistol", count = 6 },
            { id = "gunpowder_shotgun", count = 6 }
        })
    :component("combatnail", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 4)
    :book("manual_shotgun", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_dart",
    result = "bp_shot_dart",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component("chem_black_powder", 6)
    :component("combatnail", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 4)
    :book("manual_shotgun", 4)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_dart_with_dowel",
    result = "bp_shot_dart",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_shot_junk",
    result = "reloaded_shot_junk",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder", count = 6 },
            { id = "gunpowder_pistol", count = 6 },
            { id = "gunpowder_shotgun", count = 6 }
        })
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 5, requirement = true },
            { id = "bb", count = 10 },
            { id = "solder_wire", count = 5 },
            { id = "platinum_small", count = 2 },
            { id = "gold_small", count = 2 },
            { id = "bearing", count = 2 },
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "bismuth", count = 3 },
            { id = "shrapnel", count = 2 }
        })
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_junk",
    result = "bp_shot_junk",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :component("chem_black_powder", 6)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 5, requirement = true },
            { id = "bb", count = 10 },
            { id = "solder_wire", count = 5 },
            { id = "platinum_small", count = 2 },
            { id = "gold_small", count = 2 },
            { id = "bearing", count = 2 },
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "bismuth", count = 3 },
            { id = "shrapnel", count = 2 }
        })
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_junk_with_dowel",
    result = "bp_shot_junk",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press_dowel", 1)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("req_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)
