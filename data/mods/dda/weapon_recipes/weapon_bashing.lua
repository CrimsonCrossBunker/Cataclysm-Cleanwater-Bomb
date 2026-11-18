local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "bat_with_lathe",
    result = "bat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("fake_lathe", 1)
    :component("wooden_post", 1)
    :quality("SAW_W", 1, 1)
    :quality("FILE", 1, 1)
    :quality("CHISEL_WOOD", 2, 1)
    :proficiency("prof_carving", { time_multiplier = 2 })
    :byproduct("splinter", 30)
)

content.add(content.Recipe {
    id = "homemade_polehammer",
    result = "homemade_polehammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "hammer", count = 1 },
            { id = "homemade_polehammer_makeshift", count = 1 }
        })
    :component("nails", 3, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "homemade_polehammer_makeshift",
    result = "homemade_polehammer_makeshift",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "long_pole", count = 1 }
        })
    :component("hammer", 1)
    :component("glue_strong", 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "cudgel",
    result = "cudgel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :quality("CUT", 1, 1)
    :requires_skill("melee", 1)
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "club_wooden",
    result = "club_wooden",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "club_wooden_nails",
    result = "club_wooden_nails",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("club_wooden", 1)
    :component("nails", 30, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "club_wooden_bolted",
    result = "club_wooden_bolted",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("club_wooden", 1)
    :component("nuts_bolts", 30)
    :quality("DRILL", 1, 1)
    :quality("WRENCH", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "club_wooden_large",
    result = "club_wooden_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "club_wooden_large_nails",
    result = "club_wooden_large_nails",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("club_wooden_large", 1)
    :component("nails", 30, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "club_wooden_large_bolted",
    result = "club_wooden_large_bolted",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("club_wooden_large", 1)
    :component("nuts_bolts", 30)
    :quality("DRILL", 1, 1)
    :quality("WRENCH", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "nailboard",
    result = "nailboard",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :component("nails", 6, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "aztec_sword_scrap",
    result = "aztec_sword_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component("razor_blade", 20)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "glass_macuahuitl",
    result = "glass_macuahuitl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "glass_shard", count = 40 },
            { id = "ceramic_shard", count = 40 }
        })
    :component("2x4", 1)
    :quality("CUT", 1, 1)
    :requirement("adhesive", 5)
)

content.add(content.Recipe {
    id = "teeth_macuahuitl",
    result = "teeth_macuahuitl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("nm_teeth", 40)
    :component("2x4", 1)
    :quality("CUT", 1, 1)
    :requirement("adhesive", 5)
)

content.add(content.Recipe {
    id = "aztec_sword_stone",
    result = "aztec_sword_stone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "sharp_rock", count = 6 },
            { id = "flint", count = 6 }
        })
    :component("2x4", 1)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 5)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "aztec_spear_scrap",
    result = "aztec_spear_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stick", 1)
    :component("2x4", 1)
    :component("razor_blade", 8)
    :quality("CUT", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("adhesive", 3)
)

content.add(content.Recipe {
    id = "aztec_spear_glass",
    result = "aztec_spear_glass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stick", 1)
    :component("2x4", 1)
    :component_any({
            { id = "glass_shard", count = 14 },
            { id = "ceramic_shard", count = 14 }
        })
    :quality("CUT", 1, 1)
    :requirement("adhesive", 5)
)

content.add(content.Recipe {
    id = "aztec_spear_stone",
    result = "aztec_spear_stone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stick", 1)
    :component("2x4", 1)
    :component_any({
            { id = "rock", count = 8 },
            { id = "flint", count = 8 }
        })
    :quality("CUT", 1, 1)
    :requirement("adhesive", 5)
)

content.add(content.Recipe {
    id = "nailbat",
    result = "nailbat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bat", 1)
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bwirebat",
    result = "bwirebat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("bat", 1)
    :component("wire_barbed", 1)
)

content.add(content.Recipe {
    id = "nutboltbat",
    result = "nutboltbat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bat", 1)
    :component("nuts_bolts", 20)
    :quality("DRILL", 1, 1)
    :quality("WRENCH", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bat_metal_bolt",
    result = "bat_metal_bolt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bat_metal", 1)
    :component("nuts_bolts", 20)
    :quality("DRILL", 1, 1)
    :quality("WRENCH", 1, 1)
)

content.add(content.Recipe {
    id = "sword_wood_large",
    result = "sword_wood_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sword_nail",
    result = "sword_nail",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sword_wood", 1)
    :component("nails", 12, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "knuckle_steel",
    result = "knuckle_steel",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cotton_patchwork", 4)
    :component("scrap", 4)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("bashing", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "xl_knuckle_steel",
    result = "xl_knuckle_steel",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cotton_patchwork", 5)
    :component("scrap", 5)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("bashing", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "xs_knuckle_steel",
    result = "xs_knuckle_steel",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cotton_patchwork", 3)
    :component("scrap", 3)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("bashing", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "knuckle_steel_forged",
    result = "knuckle_steel_forged",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 5 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "xl_knuckle_steel_forged",
    result = "xl_knuckle_steel_forged",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "scrap", count = 7 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "xs_knuckle_steel_forged",
    result = "xs_knuckle_steel_forged",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 3 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "knuckle_brass",
    result = "knuckle_brass",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("copper", 100)
    :component("chem_zinc_powder", 500)
    :requirement("blacksmithing_standard", 4)
    :requirement("ppe_gas", 1)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "xl_knuckle_brass",
    result = "xl_knuckle_brass",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("copper", 150)
    :component("chem_zinc_powder", 600)
    :requirement("blacksmithing_standard", 4)
    :requirement("ppe_gas", 1)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "xs_knuckle_brass",
    result = "xs_knuckle_brass",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("copper", 80)
    :component("chem_zinc_powder", 400)
    :requirement("blacksmithing_standard", 4)
    :requirement("ppe_gas", 1)
    :requirement("metal_punch", 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "knuckle_nail",
    result = "knuckle_nail",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("nails", 16, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("cordage", 4)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_knuckle_nail",
    result = "xl_knuckle_nail",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("nails", 18, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("cordage", 4)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xs_knuckle_nail",
    result = "xs_knuckle_nail",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("nails", 14, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("cordage", 4)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "cestus",
    result = "cestus",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("leather", 4)
    :component("scrap", 8)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("sewing_standard", 5)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 1)
    :book("textbook_weapeast", 7)
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_cestus",
    result = "xl_cestus",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("leather", 6)
    :component("scrap", 10)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("sewing_standard", 5)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 1)
    :book("textbook_weapeast", 7)
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xs_cestus",
    result = "xs_cestus",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("leather", 3)
    :component("scrap", 6)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("sewing_standard", 5)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 1)
    :book("textbook_weapeast", 7)
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "rock_sock",
    result = "rock_sock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("rock", 1)
    :component_any({
            { id = "socks", count = 1 },
            { id = "socks_wool", count = 1 }
        })
)

content.add(content.Recipe {
    id = "tonfa",
    result = "tonfa",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("plastic_chunk", 8)
    :requirement("plastic_molding", 6)
    :requires_skill("melee", 1)
    :proficiency("prof_plasticworking", { skill_penalty = 4 })
)

content.add(content.Recipe {
    id = "tonfa_wood",
    result = "tonfa_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("melee", 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "shocktonfa_off",
    result = "shocktonfa_off",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("plastic_chunk", 8)
    :component("amplifier", 2)
    :component("power_supply", 1)
    :component("scrap", 2)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 6)
    :requires_skill("electronics", 3)
    :book("recipe_melee", 5)
    :proficiency("prof_elec_soldering", { skill_penalty = 0.5 })
    :proficiency("prof_shock_weapons")
    :proficiency("prof_plasticworking", { skill_penalty = 0.5 })
)

-- Bokken is a single piece of wood, and the stout branch just isn't large enough.
content.add(content.Recipe {
    id = "bokken",
    result = "bokken",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 2040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("stick_long", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "filament", count = 20, requirement = true }
        })
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("wood_sealant_any_small", 1)
    :book("textbook_weapeast", 2)
    :proficiency("prof_carving", { skill_penalty = 0.5 })
    :byproduct("splinter", 30)
)

content.add(content.Recipe {
    id = "lc_mace",
    result = "lc_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 2)
    :book("recipe_melee", 2)
    :book("textbook_weparabic", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mace",
    result = "mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 3)
    :book("recipe_melee", 3)
    :book("textbook_weparabic", 3)
    :book("textbook_armschina", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hc_mace",
    result = "hc_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 3)
    :book("recipe_melee", 3)
    :book("textbook_weparabic", 3)
    :book("textbook_armschina", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mace_simple",
    result = "mace_simple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("stick", 1)
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "pipe_fittings", count = 1 }
        })
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mace_trench",
    result = "mace_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stick", 1)
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "pipe_fittings", count = 1 }
        })
    :component("nails", 2, true)
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mace_pipe",
    result = "mace_pipe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("pipe", 1)
    :component("pipe_fittings", 1)
)

content.add(content.Recipe {
    id = "mace_pipe_large",
    result = "mace_pipe_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("pipe", 2)
    :component("pipe_fittings", 2)
)

content.add(content.Recipe {
    id = "staff_pipe",
    result = "staff_pipe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("pipe", 3)
    :component("pipe_fittings", 1)
)

content.add(content.Recipe {
    id = "mace_trench_from simple version",
    result = "mace_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("mace_simple", 1)
    :component("nails", 2, true)
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mace_bronze",
    result = "mace_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component("scrap_bronze", 3)
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 2)
    :book("bronze_mag", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "morningstar",
    result = "morningstar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "q_staff",
    result = "q_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stick_long", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

-- Significantly easier to make from a quarterstaff.
-- TODO: adjust crafting time down by 4 hours (240 minutes) when it's possible to separate the oiling time
-- from the crafting time easily.
-- Max experience set because waiting for oil to soak in isn't really teaching you anything.  Remove this
-- when crafting time reduced to only carving time.
content.add(content.Recipe {
    id = "bo_from quarterstaff",
    result = "bo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("q_staff", 1)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("FILE", 1, 1)
    :requirement("wood_sealant_any", 1)
    :proficiency("prof_carving", { skill_penalty = 0.2, max_experience_turns = 1800 })
)

content.add(content.Recipe {
    id = "i_staff",
    result = "i_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("bo", 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_weapwest", 2)
    :book("recipe_melee", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "lc_steel_staff",
    result = "lc_steel_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("bo", 1)
    :component("glue_strong", 5)
    :requirement("blacksmithing_standard", 3)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "mc_steel_staff",
    result = "mc_steel_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("bo", 1)
    :component("glue_strong", 5)
    :requirement("blacksmithing_standard", 3)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 2)
    :book("recipe_melee", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hc_steel_staff",
    result = "hc_steel_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("bo", 1)
    :component("glue_strong", 5)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weapwest", 2)
    :book("recipe_melee", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "i_staff_with sheet metal",
    result = "i_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal_small", 6)
    :component("nuts_bolts", 4)
    :component("bo", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "knuckle_impact",
    result = "knuckle_impact",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_knuckle_impact",
    result = "xl_knuckle_impact",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_knuckle_impact",
    result = "xs_knuckle_impact",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "crowbar_warhammer",
    result = "crowbar_warhammer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("drift", 1)
    :component("spear_shaft", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "goedendag_bat",
    result = "goedendag_bat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bat", 1)
    :component("pipe_fittings", 1)
    :component("spike", 1)
    :component("nuts_bolts", 2)
    :quality("HAMMER", 3, 1)
    :quality("CUT", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("DRILL", 3, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)
