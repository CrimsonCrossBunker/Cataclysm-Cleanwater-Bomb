local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "dynamite",
    result = "dynamite",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "paper", count = 5 },
            { id = "rolling_paper", count = 32 }
        })
    :component("chem_sulphuric_acid", 2)
    :component("chem_nitric_acid", 1)
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "methed_alcohol", count = 250 }
        })
    :component("chem_glycerol", 2)
    :quality("CHEM", 2, 1)
    :book("textbook_anarch", 5)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
)

content.add(content.Recipe {
    id = "EMPbomb",
    result = "EMPbomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 192000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("circuit", 1)
    :component("e_scrap", 3)
    :component("magnetron", 1)
    :component("flux_comp_gen", 1)
    :component("plut_cell", 1)
    :component("antenna", 1)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 15)
    :book("textbook_anarch", 5)
    :book("advanced_electronics", 5)
)

content.add(content.Recipe {
    id = "firecracker",
    result = "firecracker",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("thread", 10)
    :component_any({
            { id = "paper", count = 1 },
            { id = "rolling_paper", count = 6 }
        })
    :component_any({
            { id = "gunpowder", count = 50 },
            { id = "chem_black_powder", count = 50 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "firecracker_pack",
    result = "firecracker_pack",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("firecracker", 25)
    :component("paper", 5)
    :component("cordage_short", 1, true)
    :quality("CUT", 2, 1)
)

-- Displaces older teargas recipe.  Conventional teargas grenades generally aren't trichloramine.
content.add(content.Recipe {
    id = "gasbomb_makeshift",
    result = "gasbomb_makeshift",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component_any({
            { id = "bleach", count = 250 },
            { id = "oxy_powder", count = 200 }
        })
    :component_any({
            { id = "ammonia_liquid", count = 2 },
            { id = "lye_powder", count = 200 }
        })
    :component("glue_strong", 5)
    :quality("SCREW", 1, 1)
    :requirement("small_gas_canister_case", 1)
    :requires_skill("mechanics", 1)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "fungicidalbomb_makeshift",
    result = "fungicidalbomb_makeshift",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component_any({
            { id = "bleach", count = 250 },
            { id = "oxy_powder", count = 200 }
        })
    :component_any({
            { id = "triffid_fungicide", count = 1 },
            { id = "fungicide", count = 50 }
        })
    :component("chem_sulphur", 150)
    :component("small_gas_canister_case", 1, true)
    :component("glue_strong", 5)
    :quality("SCREW", 1, 1)
    :requires_skill("mechanics", 1)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "insecticidalbomb_makeshift",
    result = "insecticidalbomb_makeshift",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component_any({
            { id = "bleach", count = 250 },
            { id = "oxy_powder", count = 200 }
        })
    :component("insecticide", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component("small_gas_canister_case", 1, true)
    :component("glue_strong", 5)
    :quality("SCREW", 1, 1)
    :requires_skill("mechanics", 1)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "molotov",
    result = "molotov",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("cotton_patchwork", 1)
    :component_any({
            { id = "bottle_glass", count = 1 },
            { id = "jar_glass_sealed", count = 1 },
            { id = "bottle_glass_seasoning", count = 1 },
            { id = "clay_canister", count = 1 }
        })
    :requirement("accelerant_liquid", 500)
)

content.add(content.Recipe {
    id = "gelled_molotov",
    result = "gelled_molotov",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "gelled_gasoline", count = 500 },
            { id = "napalm", count = 500 }
        })
    :component("cotton_patchwork", 1)
    :component_any({
            { id = "bottle_glass", count = 1 },
            { id = "jar_glass_sealed", count = 1 },
            { id = "bottle_glass_seasoning", count = 1 },
            { id = "clay_canister", count = 1 }
        })
)

content.add(content.Recipe {
    id = "dynamite_bomb",
    result = "dynamite_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "welder", charges = 20 },
            { id = "welding_kit", charges = 20 },
            { id = "welder_crude", charges = 30 },
            { id = "integrated_welder", charges = 30 },
            { id = "soldering_iron", charges = 30 },
            { id = "soldering_iron_portable", charges = 30 },
            { id = "integrated_electrokit", charges = 30 }
        })
    :component("metal_tank_little", 1)
    :component_any({
            { id = "nails", count = 200, requirement = true },
            { id = "scrap", count = 16 }
        })
    :component("fuse", 1)
    :component("dynamite", 1)
    :quality("SAW_M", 1, 1)
    :quality("GLARE", 1, 1)
    :requires_skill("mechanics", 2)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "smokebomb",
    result = "smokebomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 45000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("sugar", 16)
    :component("chem_saltpetre", 24)
    :component("glue_strong", 5)
    :quality("SCREW", 1, 1)
    :requirement("small_gas_canister_case", 1)
    :requires_skill("mechanics", 1)
    :book("basic_chemistry", 2)
    :book("textbook_gaswarfare", 2)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :book("textbook_anarch", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "smokebomb_with_white_phosphorous",
    result = "smokebomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 45000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("white_phosphorous", 20)
    :component("glue_strong", 5)
    :quality("SCREW", 1, 1)
    :requirement("small_gas_canister_case", 1)
    :requires_skill("mechanics", 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :book("textbook_anarch", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "military_explosive_small_grenade",
    result = "military_explosive_small_grenade",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("delay_fuze", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component_any({
            { id = "nails", count = 50, requirement = true },
            { id = "scrap", count = 2 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("military_explosive", 46)
    :requirement("explosives_casting_standard", 1)
    :requirement("small_gas_canister_case", 1)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "military_explosive_grenade",
    result = "military_explosive_grenade",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("delay_fuze", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("can_medium", 1)
    :component_any({
            { id = "nails", count = 100, requirement = true },
            { id = "scrap", count = 4 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("military_explosive", 92)
    :requirement("explosives_casting_standard", 1)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "military_explosive_pipebomb_stable",
    result = "military_explosive_pipebomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("pipe", 1)
    :component("delay_fuze", 1)
    :quality("SAW_M", 1, 1)
    :requirement("military_explosive", 92)
    :requirement("explosives_casting_standard", 1)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "military_explosive_bomb",
    result = "military_explosive_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("delay_fuze", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("jug_plastic", 1)
    :component_any({
            { id = "nails", count = 750, requirement = true },
            { id = "scrap", count = 30 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("military_explosive", 697)
    :requirement("explosives_casting_standard", 1)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "military_explosive_half_barrel_bomb",
    result = "military_explosive_half_barrel_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("delay_fuze", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("keg_steel", 1)
    :requirement("explosives_casting_standard", 5)
    :requirement("military_explosive", 10000)
    :book("manual_launcher", 7)
    :book("textbook_anarch", 8)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "military_explosive_full_barrel_bomb",
    result = "military_explosive_full_barrel_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("delay_fuze", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("30gal_drum", 1)
    :requirement("explosives_casting_standard", 10)
    :requirement("military_explosive", 20000)
    :book("manual_launcher", 7)
    :book("textbook_anarch", 8)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "small_homemade_grenade",
    result = "small_homemade_grenade",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("small_gas_canister_case", 1, true)
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 }
        })
    :component_any({
            { id = "nails", count = 50, requirement = true },
            { id = "scrap", count = 2 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("stable_explosive", 14)
    :requirement("volatile_explosive", 1)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "homemade_grenade",
    result = "homemade_grenade",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("can_medium", 1)
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 }
        })
    :component_any({
            { id = "nails", count = 100, requirement = true },
            { id = "scrap", count = 4 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("stable_explosive", 29)
    :requirement("volatile_explosive", 1)
    :proficiency("prof_handloading")
)

-- You cut the tube to make the bomb.
content.add(content.Recipe {
    id = "pipebomb",
    result = "pipebomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 1)
    :component("fuse", 1)
    :quality("SAW_M", 1, 1)
    :requirement("stable_explosive", 29)
    :requirement("volatile_explosive", 1)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "pipebomb_volatile",
    result = "pipebomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 1)
    :component("fuse", 1)
    :quality("SAW_M", 1, 1)
    :requirement("volatile_explosive", 30)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "homemade_bomb",
    result = "homemade_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("jug_plastic", 1)
    :component_any({
            { id = "nails", count = 750, requirement = true },
            { id = "scrap", count = 30 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("stable_explosive", 226)
    :requirement("volatile_explosive", 6)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "homemade_demolition_charge",
    result = "homemade_demolition_charge",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("jug_plastic", 1)
    :quality("SAW_M", 1, 1)
    :requirement("stable_explosive", 253)
    :requirement("volatile_explosive", 6)
    :book("manual_launcher", 4)
    :book("textbook_anarch", 5)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "half_barrel_bomb",
    result = "half_barrel_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("keg_steel", 1)
    :requirement("volatile_explosive", 86)
    :requirement("stable_explosive", 3354)
    :book("manual_launcher", 7)
    :book("textbook_anarch", 8)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "full_barrel_bomb",
    result = "full_barrel_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fuse", 1)
    :component_any({
            { id = "glue_strong", count = 4 },
            { id = "duct_tape", count = 10 },
            { id = "cordage", count = 1, requirement = true }
        })
    :component("30gal_drum", 1)
    :requirement("volatile_explosive", 173)
    :requirement("stable_explosive", 6747)
    :book("manual_launcher", 7)
    :book("textbook_anarch", 8)
    :proficiency("prof_handloading")
)
