local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "balclava",
    result = "balclava",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "bandana",
    result = "bandana",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork_simple", 1)
)

content.add(content.Recipe {
    id = "headscarf",
    result = "headscarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork_simple", 1)
)

content.add(content.Recipe {
    id = "beret_wool",
    result = "beret_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_felt_small", 6)
)

content.add(content.Recipe {
    id = "makeshift_blindfold",
    result = "makeshift_blindfold",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 2,
}
    :component("withered", 10)
    :component("cordage_short", 2, true)
    :requires_skill("tailor", 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "blindfold_duct",
    result = "blindfold_duct",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("duct_tape", 50)
)

content.add(content.Recipe {
    id = "blindfold",
    result = "blindfold",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_EASY", "NO_RESIZE" },
}
    :component_any({
            { id = "bandana", count = 1 },
            { id = "scarf", count = 1 },
            { id = "scarf_long", count = 1 },
            { id = "patchwork_scarf", count = 1 },
            { id = "long_patchwork_scarf", count = 1 },
            { id = "scarf_fur", count = 1 },
            { id = "scarf_fur_long", count = 1 },
            { id = "knit_scarf", count = 1 },
            { id = "long_knit_scarf", count = 1 },
            { id = "scarf_loose", count = 1 },
            { id = "scarf_long_loose", count = 1 },
            { id = "patchwork_scarf_loose", count = 1 },
            { id = "long_patchwork_scarf_loose", count = 1 },
            { id = "scarf_fur_loose", count = 1 },
            { id = "scarf_fur_long_loose", count = 1 },
            { id = "knit_scarf_loose", count = 1 },
            { id = "long_knit_scarf_loose", count = 1 },
            { id = "bandages", count = 2 },
            { id = "bandages_makeshift", count = 2 },
            { id = "bandages_makeshift_bleached", count = 2 },
            { id = "bandages_makeshift_boiled", count = 2 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 }
        })
)

content.add(content.Recipe {
    id = "chaplet",
    result = "chaplet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component_any({
            { id = "straw_pile", count = 2 },
            { id = "withered", count = 2 }
        })
    :component("cordage_short", 1, true)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "counterweight_pouch",
    result = "counterweight_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("fastener_small", 1)
    :requirement("cordage_short", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "cowboy_hat",
    result = "cowboy_hat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 4)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "cowl_wool",
    result = "cowl_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 240000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_felt_patchwork", 11)
)

content.add(content.Recipe {
    id = "crown_golden_survivor",
    result = "crown_golden_survivor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("gold_small", 200)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "drinking_hat",
    result = "drinking_hat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "bottle_plastic_small", count = 1 },
            { id = "sippy_cup", count = 1 },
            { id = "clay_canister", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "beaker", count = 1 },
            { id = "flask_hip", count = 1 }
        })
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "bottle_plastic_small", count = 1 },
            { id = "sippy_cup", count = 1 },
            { id = "clay_canister", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "beaker", count = 1 },
            { id = "flask_hip", count = 1 }
        })
    :component("any_wire", 1, true)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :requirement("cordage_short", 2)
)

content.add(content.Recipe {
    id = "eyepatch_leather",
    result = "eyepatch_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("cordage_short", 1, true)
    :requirement("tailoring_leather_small", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "fur_cat_ears",
    result = "fur_cat_ears",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("fur", 2)
    :component("plastic_chunk", 3)
    :requirement("sewing_standard", 10)
    :book("mag_animecon", 3)
    :proficiency("prof_plasticworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "faux_fur_cat_ears",
    result = "faux_fur_cat_ears",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("faux_fur", 2)
    :component("plastic_chunk", 3)
    :requirement("sewing_standard", 10)
    :book("mag_animecon", 3)
    :proficiency("prof_plasticworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 4)
)

content.add(content.Recipe {
    id = "glasses_safety",
    result = "glasses_safety",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("cordage", 1, true)
    :component("plastic_bottles_any", 1, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "glass_goggles",
    result = "glass_goggles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal", count = 1 },
            { id = "sheet_metal_small", count = 1 }
        })
    :tool_charges("forge", 25)
    :component("cordage", 1, true)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "test_tube", count = 2 },
            { id = "marble", count = 25 }
        })
    :requirement("tailoring_leather_small", 1)
    :proficiency("prof_glassblowing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "hat_boonie",
    result = "hat_boonie",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :byproduct("cotton_patchwork", 2)
    :byproduct("scrap_cotton", 2)
)

content.add(content.Recipe {
    id = "hat_cotton",
    result = "hat_cotton",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :byproduct("cotton_patchwork", 5)
    :byproduct("scrap_cotton", 2)
)

content.add(content.Recipe {
    id = "maid_hat",
    result = "maid_hat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_small", 2)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_hat_xl",
    result = "maid_hat_xl",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_small", 3)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_hat_xs",
    result = "maid_hat_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_small", 1)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "hat_fur",
    result = "hat_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "hat_faux_fur",
    result = "hat_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_faux_fur_patchwork", 1)
    :book("textbook_tailor", 2)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 4)
)

content.add(content.Recipe {
    id = "hat_hard",
    result = "hat_hard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 7)
    :requirement("plastic_molding", 5)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "hat_hard_hooded",
    result = "hat_hard_hooded",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("sun_shield", 1)
    :component("hat_hard", 1)
)

content.add(content.Recipe {
    id = "hat_hunting",
    result = "hat_hunting",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_felt_patchwork", 9)
    :proficiency("prof_millinery")
    :byproduct("felt_patch", 7)
)

content.add(content.Recipe {
    id = "hat_knit",
    result = "hat_knit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 120)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "hat_noise_cancelling",
    result = "hat_noise_cancelling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_small", 16)
    :requirement("cordage", 2)
)

content.add(content.Recipe {
    id = "helmet_army",
    result = "helmet_army",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("helmet_mounting_brackets", 1)
    :component("helmet_army_stripped", 1)
    :quality("SCREW", 1, 1)
)

-- A log is required in this recipe, as I don't think you can bend 2x4s into the shape of an eagle.
content.add(content.Recipe {
    id = "helmet_aztec",
    result = "helmet_aztec",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 5760000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("log", 1)
    :component("2x4", 1)
    :component("feather", 50)
    :quality("CUT", 2, 1)
    :quality("CHISEL_WOOD", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_mesoam", 3)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_carving")
    :byproduct("splinter", 200)
)

content.add(content.Recipe {
    id = "helmet_barbute",
    result = "helmet_barbute",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "helmet_barbute_xs",
    result = "helmet_barbute_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("steel_standard", 7)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_helmet_barbute",
    result = "xl_helmet_barbute",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4860000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 5 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 60)
    :requirement("steel_standard", 15)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "helmet_chitin",
    result = "helmet_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1020000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_chitin", 9)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "helmet_chitin_xs",
    result = "helmet_chitin_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 780000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_chitin", 6)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "xl_helmet_chitin",
    result = "xl_helmet_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_chitin", 12)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "helmet_conical",
    result = "helmet_conical",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 8 },
            { id = "tanned_pelt", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 18)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_conical_xs",
    result = "helmet_conical_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "tanned_pelt", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 13)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_conical",
    result = "xl_helmet_conical",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4950000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 8 },
            { id = "tanned_pelt", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 23)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_acidchitin",
    result = "helmet_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("cordage_superior", 1, true)
    :component("acidchitin_piece", 12)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :requires_skill("fabrication", 4)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "helmet_acidchitin_xs",
    result = "helmet_acidchitin_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("cordage_superior", 1, true)
    :component("acidchitin_piece", 9)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :requires_skill("fabrication", 4)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "xl_helmet_acidchitin",
    result = "xl_helmet_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("cordage_superior", 2, true)
    :component("acidchitin_piece", 17)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :requires_skill("fabrication", 4)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "helmet_galea",
    result = "helmet_galea",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_galea_xs",
    result = "helmet_galea_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_galea",
    result = "xl_helmet_galea",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 4950000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 5 },
            { id = "leather", count = 5 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_kabuto",
    result = "helmet_kabuto",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 16 },
            { id = "tanned_pelt", count = 2 },
            { id = "leather", count = 16 },
            { id = "tanned_hide", count = 2 }
        })
    :component("cotton_patchwork", 16)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 48)
    :requirement("steel_standard", 12)
    :book("textbook_armeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_kabuto_xs",
    result = "helmet_kabuto_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 11 },
            { id = "tanned_pelt", count = 2 },
            { id = "leather", count = 11 },
            { id = "tanned_hide", count = 2 }
        })
    :component("cotton_patchwork", 11)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 36)
    :requirement("steel_standard", 9)
    :book("textbook_armeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_kabuto",
    result = "xl_helmet_kabuto",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4050000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 20 },
            { id = "tanned_pelt", count = 3 },
            { id = "leather", count = 20 },
            { id = "tanned_hide", count = 3 }
        })
    :component("cotton_patchwork", 20)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 64)
    :requirement("steel_standard", 16)
    :book("textbook_armeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_larmor",
    result = "helmet_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "helmet_larmor_xs",
    result = "helmet_larmor_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("leather", 6)
)

content.add(content.Recipe {
    id = "xl_helmet_larmor",
    result = "xl_helmet_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "helmet_skull",
    result = "helmet_skull",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_canis", 1)
    :quality("CUT", 2, 1)
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_carving")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 1)
    :byproduct("meal_bone", 1)
)

content.add(content.Recipe {
    id = "helmet_nasal",
    result = "helmet_nasal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_nasal_xs",
    result = "helmet_nasal_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_nasal",
    result = "xl_helmet_nasal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_plate",
    result = "helmet_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 56)
    :requirement("steel_standard", 14)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_plate_xs",
    result = "helmet_plate_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_plate",
    result = "xl_helmet_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3660000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 84)
    :requirement("steel_standard", 21)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_metal_sheets_full",
    result = "helmet_metal_sheets_full",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("gambeson_hood", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "ch_helmet_metal_sheets_full",
    result = "ch_helmet_metal_sheets_full",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("helmet_metal_sheets_full", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "helmet_metal_sheets",
    result = "helmet_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1470000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("gambeson_hood", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :proficiency("prof_metalworking")
    :byproduct("sheet_metal_small", 1)
)

content.add(content.Recipe {
    id = "ch_helmet_metal_sheets",
    result = "ch_helmet_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("helmet_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "helmet_scavenger",
    result = "helmet_scavenger",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 }
        })
    :component("mask_filter", 1)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 }
        })
    :component("sheet_kevlar_layered", 1)
    :requirement("sewing_aramids", 32)
    :requirement("soldering_standard", 8)
    :requires_skill("fabrication", 3)
    :proficiency("prof_millinery")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "helmet_scavenger_xs",
    result = "helmet_scavenger_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 }
        })
    :component("mask_filter", 1)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 }
        })
    :component("sheet_kevlar_layered", 1)
    :requirement("sewing_aramids", 24)
    :requirement("soldering_standard", 6)
    :requires_skill("fabrication", 3)
    :proficiency("prof_millinery")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "xl_helmet_scavenger",
    result = "xl_helmet_scavenger",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 }
        })
    :component("mask_filter", 1)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 }
        })
    :component("sheet_kevlar_layered", 2)
    :requirement("sewing_aramids", 42)
    :requirement("soldering_standard", 11)
    :requires_skill("fabrication", 3)
    :proficiency("prof_millinery")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "helmet_scrap",
    result = "helmet_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 4)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "helmet_scrap_xs",
    result = "helmet_scrap_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 2)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_helmet_scrap",
    result = "xl_helmet_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 6)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 2)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hood_rain",
    result = "hood_rain",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("cotton_patchwork", 2)
    :requirement("waterproofing_plastic_sheets", 2)
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "hood_survivor",
    result = "hood_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("vinylizing_standard", 22)
    :requires_skill("fabrication", 4)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "hood_xssurvivor",
    result = "hood_xssurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("vinylizing_standard", 18)
    :requires_skill("fabrication", 4)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "hood_wsurvivor",
    result = "hood_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_fur_patchwork", 2)
    :requirement("vinylizing_standard", 22)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_hood_wsurvivor",
    result = "xs_hood_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_fur_patchwork", 2)
    :requirement("vinylizing_standard", 18)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_hood_wsurvivor",
    result = "xl_hood_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("tailoring_fur_patchwork", 3)
    :requirement("vinylizing_standard", 22)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "hood_xlsurvivor",
    result = "hood_xlsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("vinylizing_standard", 30)
    :requires_skill("fabrication", 4)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "iggaak",
    result = "iggaak",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
            { id = "bone_sturdy", count = 1, requirement = true }
        })
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_fibers")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "keffiyeh",
    result = "keffiyeh",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("sheet", 1)
    :requirement("cordage", 1)
)

content.add(content.Recipe {
    id = "grass_keffiyeh",
    result = "grass_keffiyeh",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("grass_sheet", 1)
    :requirement("cordage", 1)
)

content.add(content.Recipe {
    id = "knit_scarf",
    result = "knit_scarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 100)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "leather_cat_ears",
    result = "leather_cat_ears",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("leather", 2)
    :requirement("sewing_standard", 10)
    :requirement("plastic_molding", 3)
    :book("mag_animecon", 3)
    :proficiency("prof_plasticworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "long_knit_scarf",
    result = "long_knit_scarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 190)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "long_patchwork_scarf",
    result = "long_patchwork_scarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork_simple", 4)
    :byproduct("cotton_patchwork", 4)
)

-- Airtight takes some skills.
content.add(content.Recipe {
    id = "mask_filter",
    result = "mask_filter",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "plastic_sheet_small", count = 2 },
            { id = "plastic_bottles_any", count = 1, requirement = true }
        })
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "bandana", count = 2 },
            { id = "paper", count = 10 }
        })
    :component("charcoal", 10)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "mask_fsurvivor",
    result = "mask_fsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "nomex", count = 4 },
            { id = "nomex_hood", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 10, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("sewing_aramids", 10)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 8)
    :book("textbook_fireman", 7)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "mask_fsurvivorxs",
    result = "mask_fsurvivorxs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "nomex", count = 3 },
            { id = "nomex_hood", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 5, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("sewing_aramids", 7)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 8)
    :book("textbook_fireman", 7)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "mask_fsurvivorxl",
    result = "mask_fsurvivorxl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "nomex", count = 6 },
            { id = "nomex_hood", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("sewing_aramids", 15)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 8)
    :book("textbook_fireman", 7)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "mask_gas",
    result = "mask_gas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "goggles_ski", count = 1 },
            { id = "goggles_swim", count = 2 }
        })
    :component("mask_filter", 3)
    :component("hose", 1)
    :component("charcoal", 20)
    :quality("WRENCH", 1, 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "mask_gas_xl",
    result = "mask_gas_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "goggles_ski", count = 1 },
            { id = "goggles_swim", count = 2 }
        })
    :component("mask_filter", 3)
    :component("hose", 1)
    :component("charcoal", 20)
    :quality("WRENCH", 1, 1)
    :requirement("plastic_molding", 4)
    :requires_skill("fabrication", 1)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_gas_xl_expand-existing",
    result = "mask_gas_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("mask_gas", 1)
    :component("mask_filter", 1)
    :quality("WRENCH", 1, 1)
    :requirement("plastic_molding", 3)
    :requires_skill("fabrication", 1)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_gas_xs",
    result = "mask_gas_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "goggles_ski", count = 1 },
            { id = "goggles_swim", count = 2 }
        })
    :component("mask_filter", 3)
    :component("hose", 1)
    :component("charcoal", 20)
    :quality("WRENCH", 1, 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "mask_gas_xs_shrink-existing",
    result = "mask_gas_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("mask_gas", 1)
    :component("mask_filter", 1)
    :quality("WRENCH", 1, 1)
    :requirement("plastic_molding", 3)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_fireman", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_h20survivor",
    result = "mask_h20survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("rebreather", 1)
    :component("goggles_swim", 1)
    :component_any({
            { id = "mask_bal", count = 1 },
            { id = "sheet_kevlar_layered", count = 4 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("adhesive", 2)
    :requirement("sewing_aramids", 10)
    :requirement("plastic_molding", 8)
    :requires_skill("tailor", 7)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_h20survivorxs",
    result = "mask_h20survivorxs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("rebreather", 1)
    :component("goggles_swim", 1)
    :component_any({
            { id = "mask_bal", count = 1 },
            { id = "sheet_kevlar_layered", count = 3 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("adhesive", 1)
    :requirement("sewing_aramids", 7)
    :requirement("plastic_molding", 7)
    :requires_skill("tailor", 7)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_h20survivorxl",
    result = "mask_h20survivorxl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("rebreather", 1)
    :component("goggles_swim", 1)
    :component_any({
            { id = "mask_bal", count = 1 },
            { id = "sheet_kevlar_layered", count = 5 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("adhesive", 2)
    :requirement("sewing_aramids", 15)
    :requirement("plastic_molding", 9)
    :requires_skill("tailor", 7)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mask_hsurvivor",
    result = "mask_hsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component("sheet_metal_small", 2)
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 10, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("sewing_standard", 10)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "mask_hsurvivorxs",
    result = "mask_hsurvivorxs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 7, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("sewing_standard", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "mask_hsurvivorxl",
    result = "mask_hsurvivorxl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component("sheet_metal_small", 3)
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("sewing_standard", 13)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "mask_lsurvivor",
    result = "mask_lsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 10, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 10)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 5)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "mask_lsurvivorxs",
    result = "mask_lsurvivorxs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 7, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("tailor", 5)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "mask_lsurvivorxl",
    result = "mask_lsurvivorxl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 13)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("tailor", 5)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "mask_rioter",
    result = "mask_rioter",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD", "NO_RESIZE" },
}
    :component_any({
            { id = "tshirt", count = 1 },
            { id = "technician_shirt_gray", count = 1 }
        })
)

content.add(content.Recipe {
    id = "mask_ski",
    result = "mask_ski",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_felt_patchwork", 4)
    :byproduct("felt_patch", 4)
)

content.add(content.Recipe {
    id = "mask_survivor",
    result = "mask_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 10, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 10)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "mask_survivorxs",
    result = "mask_survivorxs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "glasses_bal", count = 1 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "any_tallow", count = 7, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "mask_survivorxl",
    result = "mask_survivorxl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "glasses_bal", count = 2 },
            { id = "rigid_plastic_sheet", count = 1 },
            { id = "survivor_goggles", count = 1 }
        })
    :component_any({
            { id = "mask_gas", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "mask_gas_half", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 }
        })
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("OVEN", 1, 1)
    :requirement("sewing_standard", 13)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("tailor", 6)
    :book("atomic_survival", 8)
    :book("textbook_gaswarfare", 9)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "nomex_hood",
    result = "nomex_hood",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 7)
    :book("textbook_fireman", 6)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "patchwork_scarf",
    result = "patchwork_scarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork_simple", 2)
)

content.add(content.Recipe {
    id = "pot_helmet",
    result = "pot_helmet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 600,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("cotton_patchwork", 4)
    :component("pot", 1)
)

content.add(content.Recipe {
    id = "pot_helmet_xs",
    result = "pot_helmet_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 600,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("cotton_patchwork", 3)
    :component("pot", 1)
)

content.add(content.Recipe {
    id = "rebreather",
    result = "rebreather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 9,
}
    :tool_any({
            { id = "welder", charges = 56 },
            { id = "welding_kit", charges = 56 },
            { id = "welder_crude", charges = 84 },
            { id = "soldering_iron", charges = 84 },
            { id = "soldering_iron_portable", charges = 84 },
            { id = "integrated_electrokit", charges = 84 },
            { id = "integrated_welder", charges = 84 }
        })
    :component("mask_filter", 1)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("circuit", 2)
    :component("e_scrap", 8)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("plastic_molding", 4)
    :requires_skill("tailor", 1)
    :book("manual_swimming", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rebreather_xl",
    result = "rebreather_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 9,
}
    :tool_any({
            { id = "welder", charges = 56 },
            { id = "welding_kit", charges = 56 },
            { id = "welder_crude", charges = 84 },
            { id = "soldering_iron", charges = 84 },
            { id = "soldering_iron_portable", charges = 84 },
            { id = "integrated_electrokit", charges = 84 },
            { id = "integrated_welder", charges = 84 }
        })
    :component("mask_filter", 2)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("circuit", 2)
    :component("e_scrap", 8)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("plastic_molding", 8)
    :requires_skill("tailor", 3)
    :book("manual_swimming", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rebreather_xl_mod_existing",
    result = "rebreather_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :tool_any({
            { id = "welder", charges = 56 },
            { id = "welding_kit", charges = 56 },
            { id = "welder_crude", charges = 84 },
            { id = "soldering_iron", charges = 84 },
            { id = "soldering_iron_portable", charges = 84 },
            { id = "integrated_electrokit", charges = 84 },
            { id = "integrated_welder", charges = 84 }
        })
    :component("rebreather", 1)
    :component_any({
            { id = "mask_filter", count = 1 },
            { id = "mask_gas", count = 1 }
        })
    :component("power_supply", 1)
    :component("e_scrap", 4)
    :quality("SCREW", 1, 1)
    :requirement("plastic_molding", 4)
    :requires_skill("electronics", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rebreather_xs",
    result = "rebreather_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 9,
}
    :tool_any({
            { id = "welder", charges = 56 },
            { id = "welding_kit", charges = 56 },
            { id = "welder_crude", charges = 84 },
            { id = "soldering_iron", charges = 84 },
            { id = "soldering_iron_portable", charges = 84 },
            { id = "integrated_electrokit", charges = 84 },
            { id = "integrated_welder", charges = 84 }
        })
    :component("mask_filter", 1)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("circuit", 2)
    :component("e_scrap", 8)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("plastic_molding", 2)
    :requires_skill("tailor", 3)
    :book("manual_swimming", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rebreather_xs_mod_existing",
    result = "rebreather_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :tool_any({
            { id = "welder", charges = 56 },
            { id = "welding_kit", charges = 56 },
            { id = "welder_crude", charges = 84 },
            { id = "soldering_iron", charges = 84 },
            { id = "soldering_iron_portable", charges = 84 },
            { id = "integrated_electrokit", charges = 84 },
            { id = "integrated_welder", charges = 84 }
        })
    :component("rebreather", 1)
    :component_any({
            { id = "mask_filter", count = 1 },
            { id = "mask_gas", count = 1 }
        })
    :component("power_supply", 1)
    :component("e_scrap", 4)
    :quality("SCREW", 1, 1)
    :requirement("plastic_molding", 2)
    :requires_skill("electronics", 4)
    :book("manual_swimming", 3)
    :book("atomic_survival", 3)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "scarf",
    result = "scarf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 100)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "scarf_fur",
    result = "scarf_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_fur_patchwork_simple", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "scarf_fur_long_merge_scarves",
    result = "scarf_fur_long",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("scarf_fur", 2)
    :requirement("sewing_simple", 3)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

-- You try keeping 12 feet of fur sorted out!
content.add(content.Recipe {
    id = "scarf_fur_long",
    result = "scarf_fur_long",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork_simple", 2)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "scarf_long",
    result = "scarf_long",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 480000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_wool_knitting", 160)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "straw_fedora",
    result = "straw_fedora",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "straw_pile", count = 7 },
            { id = "birchbark", count = 10 }
        })
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
    :book("textbook_tailor", 0)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "straw_hat",
    result = "straw_hat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component_any({
            { id = "straw_pile", count = 3 },
            { id = "birchbark", count = 5 }
        })
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "survivor_goggles",
    result = "survivor_goggles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "goggles_ski", count = 1 },
            { id = "sunglasses", count = 1 },
            { id = "fitover_sunglasses", count = 1 }
        })
    :component_any({
            { id = "polycarbonate_chunk", count = 4 },
            { id = "glasses_bal", count = 2 }
        })
    :component("leather", 3)
    :component("sheet_kevlar_layered", 2)
    :quality("LEATHER_AWL", 1, 1)
    :quality("FABRIC_CUT", 2, 1)
    :requirement("adhesive", 1)
    :requirement("sewing_aramids", 10)
    :requires_skill("tailor", 4)
    :proficiency("prof_plasticworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "thermal_mask",
    result = "thermal_mask",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "scarf", count = 2 },
            { id = "scarf_long", count = 1 },
            { id = "balclava", count = 1 }
        })
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 3 }
        })
    :component("cable", 2)
    :requirement("sewing_standard", 8)
    :requirement("soldering_standard", 20)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "throat_guard_nylon",
    result = "throat_guard_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("fastener_small", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "throat_guard_canvas",
    result = "throat_guard_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_canvas_patchwork", 1)
    :requirement("fastener_small", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "throat_guard_mercenary",
    result = "throat_guard_mercenary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("iotv_neck_plate", 1)
    :component("filament_durable", 20, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "tinfoil_hat",
    result = "tinfoil_hat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("aluminum_foil", 4)
)

content.add(content.Recipe {
    id = "tricorne",
    result = "tricorne",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 390000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "any_tallow", count = 2, requirement = true },
            { id = "cooking_oil", count = 8 },
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "lamp_oil", count = 200 },
            { id = "motor_oil", count = 200 }
        })
    :requirement("tailoring_leather_patchwork", 1)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "turban",
    result = "turban",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :requirement("tailoring_cotton_patchwork_simple", 3)
)

content.add(content.Recipe {
    id = "welding_mask_crude",
    result = "welding_mask_crude",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("goggles_welding", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
)

content.add(content.Recipe {
    id = "lc_chainmail_hood",
    result = "lc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 50)
    :component("lc_wire", 1)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_hood",
    result = "xl_lc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 3)
    :component("lc_chain_link", 75)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 6)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_hood",
    result = "xs_lc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 50)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_hood",
    result = "mc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 50)
    :component("mc_wire", 1)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_hood",
    result = "xl_mc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 3)
    :component("mc_chain_link", 75)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 6)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_hood",
    result = "xs_mc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 50)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_hood",
    result = "hc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 50)
    :component("hc_wire", 1)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_hood",
    result = "xl_hc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 3)
    :component("hc_chain_link", 75)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 6)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_hood",
    result = "xs_hc_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 50)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_hood",
    result = "ch_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("ch_chain_link", 50)
    :component("ch_wire", 1)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_hood",
    result = "xs_ch_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("ch_chain_link", 38)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_hood",
    result = "xl_ch_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 3)
    :component("ch_chain_link", 75)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 6)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_hood",
    result = "qt_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 50)
    :component("qt_wire", 1)
    :component("cotton_patchwork", 4)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_hood",
    result = "xs_qt_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 38)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_hood",
    result = "xl_qt_chainmail_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 3)
    :component("qt_chain_link", 75)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 6)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "pot_xlhelmet",
    result = "pot_xlhelmet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("cotton_patchwork", 10)
    :component("pot_canning", 1)
)

content.add(content.Recipe {
    id = "helmet_corinthian",
    result = "helmet_corinthian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3300000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 7)
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :requirement("forging_standard", 3)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "helmet_corinthian_xs",
    result = "helmet_corinthian_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3300000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 5)
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xl_helmet_corinthian",
    result = "xl_helmet_corinthian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 10)
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :requirement("forging_standard", 4)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "helmet_bronze",
    result = "helmet_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3300000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 7)
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :requirement("forging_standard", 3)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xs_helmet_bronze",
    result = "xs_helmet_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3300000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 5)
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xl_helmet_bronze",
    result = "xl_helmet_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 10)
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :requirement("forging_standard", 4)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "helmet_armet",
    result = "helmet_armet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 48)
    :requirement("steel_standard", 12)
    :book("textbook_armwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_sallet",
    result = "helmet_sallet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :book("textbook_armwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "helmet_kettle",
    result = "helmet_kettle",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_helmet_kettle",
    result = "xl_helmet_kettle",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 3000000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "attached_ear_plugs_off",
    result = "attached_ear_plugs_off",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("ear_plugs", 1)
    :component_any({
            { id = "filament", count = 100, requirement = true },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "hood_gut",
    result = "hood_gut",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "stomach_sealed", count = 3 },
            { id = "large_stomach_sealed", count = 2 }
        })
    :component("filament", 12, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 5)
    :book("trappers_companion", 6)
    :book("survival_book", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "lc_lighthelm_close",
    result = "lc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_lc_lighthelm_close",
    result = "xl_lc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mc_lighthelm_close",
    result = "mc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_mc_lighthelm_close",
    result = "xl_mc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "hc_lighthelm_close",
    result = "hc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_lighthelm_close",
    result = "xl_hc_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "ch_lighthelm_close",
    result = "ch_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 47520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("carbon", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_lighthelm_close",
    result = "xl_ch_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 54720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("carbon", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_lighthelm_close",
    result = "qt_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_lighthelm_close",
    result = "xl_qt_lighthelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 56160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_helm_close",
    result = "lc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 47520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_lc_helm_close",
    result = "xl_lc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 52920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mc_helm_close",
    result = "mc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 47520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_mc_helm_close",
    result = "xl_mc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 52920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "hc_helm_close",
    result = "hc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 47520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_helm_close",
    result = "xl_hc_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 52920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "ch_helm_close",
    result = "ch_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 52200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("carbon", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_helm_close",
    result = "xl_ch_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("carbon", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_helm_close",
    result = "qt_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 53640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_helm_close",
    result = "xl_qt_helm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61560000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_heavyhelm_close",
    result = "lc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 51840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_lc_heavyhelm_close",
    result = "xl_lc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 57960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "mc_heavyhelm_close",
    result = "mc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 51840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_mc_heavyhelm_close",
    result = "xl_mc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 57960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "hc_heavyhelm_close",
    result = "hc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 51840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_heavyhelm_close",
    result = "xl_hc_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 57960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "ch_heavyhelm_close",
    result = "ch_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 56880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("carbon", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_heavyhelm_close",
    result = "xl_ch_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("carbon", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_heavyhelm_close",
    result = "qt_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 58680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_heavyhelm_close",
    result = "xl_qt_heavyhelm_close",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 63720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "stockpot_helmet",
    result = "stockpot_helmet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("stock_pot", 1)
    :component("string_36", 2)
    :component_any({
            { id = "blanket", count = 1 },
            { id = "down_blanket", count = 1 },
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SAW_M", 1, 1)
)

content.add(content.Recipe {
    id = "lc_helmet_nasal",
    result = "lc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_lc_helmet_nasal",
    result = "xs_lc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_lc_helmet_nasal",
    result = "xl_lc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "mc_helmet_nasal",
    result = "mc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_mc_helmet_nasal",
    result = "xs_mc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_mc_helmet_nasal",
    result = "xl_mc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "hc_helmet_nasal",
    result = "hc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_hc_helmet_nasal",
    result = "xs_hc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_hc_helmet_nasal",
    result = "xl_hc_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "qt_helmet_nasal",
    result = "qt_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xs_qt_helmet_nasal",
    result = "xs_qt_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_helmet_nasal",
    result = "xl_qt_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4350000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "ch_helmet_nasal",
    result = "ch_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_helmet_nasal",
    result = "xs_ch_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_helmet_nasal",
    result = "xl_ch_helmet_nasal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3990000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "lc_helmet_turban",
    result = "lc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_lc_helmet_turban",
    result = "xs_lc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_lc_helmet_turban",
    result = "xl_lc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "mc_helmet_turban",
    result = "mc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_mc_helmet_turban",
    result = "xs_mc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_mc_helmet_turban",
    result = "xl_mc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "hc_helmet_turban",
    result = "hc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_hc_helmet_turban",
    result = "xs_hc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_hc_helmet_turban",
    result = "xl_hc_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "qt_helmet_turban",
    result = "qt_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xs_qt_helmet_turban",
    result = "xs_qt_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_helmet_turban",
    result = "xl_qt_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4350000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "ch_helmet_turban",
    result = "ch_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_helmet_turban",
    result = "xs_ch_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_helmet_turban",
    result = "xl_ch_helmet_turban",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3990000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "fur", count = 4 },
            { id = "leather", count = 4 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "lc_chainmail_face",
    result = "lc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 30)
    :component("lc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_face",
    result = "xl_lc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 3)
    :component("lc_chain_link", 50)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_face",
    result = "xs_lc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 30)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_face",
    result = "mc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 30)
    :component("mc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_face",
    result = "xl_mc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 3)
    :component("mc_chain_link", 50)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_face",
    result = "xs_mc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 30)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_face",
    result = "hc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 30)
    :component("hc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_face",
    result = "xl_hc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 3)
    :component("hc_chain_link", 50)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_face",
    result = "xs_hc_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 30)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_face",
    result = "qt_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 30)
    :component("qt_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_face",
    result = "xl_qt_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 3)
    :component("qt_chain_link", 50)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_face",
    result = "xs_qt_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 30)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_face",
    result = "ch_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("ch_chain_link", 30)
    :component("ch_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_face",
    result = "xl_ch_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 3)
    :component("ch_chain_link", 50)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_face",
    result = "xs_ch_chainmail_face",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("ch_chain_link", 30)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "lc_chainmail_aventail",
    result = "lc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 40)
    :component("lc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_aventail",
    result = "xl_lc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 3)
    :component("lc_chain_link", 60)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_aventail",
    result = "xs_lc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 2)
    :component("lc_chain_link", 40)
    :component("lc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_aventail",
    result = "mc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 40)
    :component("mc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_aventail",
    result = "xl_mc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 3)
    :component("mc_chain_link", 60)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_aventail",
    result = "xs_mc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 2)
    :component("mc_chain_link", 40)
    :component("mc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_aventail",
    result = "hc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 40)
    :component("hc_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_aventail",
    result = "xl_hc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 3)
    :component("hc_chain_link", 60)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_aventail",
    result = "xs_hc_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 2)
    :component("hc_chain_link", 40)
    :component("hc_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_aventail",
    result = "qt_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 40)
    :component("qt_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_aventail",
    result = "xl_qt_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 3)
    :component("qt_chain_link", 60)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_aventail",
    result = "xs_qt_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 40)
    :component("qt_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_aventail",
    result = "ch_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("ch_chain_link", 40)
    :component("ch_wire", 1)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_aventail",
    result = "xl_ch_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 3)
    :component("ch_chain_link", 60)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 5)
    :requirement("chainmail_standard", 4)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_aventail",
    result = "xs_ch_chainmail_aventail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 2)
    :component("lc_chain_link", 40)
    :component("ch_wire", 2)
    :component("cotton_patchwork", 3)
    :requirement("chainmail_standard", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "lc_steel_facemask",
    result = "lc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_lc_steel_facemask",
    result = "xs_lc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_lc_steel_facemask",
    result = "xl_lc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "mc_steel_facemask",
    result = "mc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_mc_steel_facemask",
    result = "xs_mc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_mc_steel_facemask",
    result = "xl_mc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "hc_steel_facemask",
    result = "hc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xs_hc_steel_facemask",
    result = "xs_hc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xl_hc_steel_facemask",
    result = "xl_hc_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "qt_steel_facemask",
    result = "qt_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10872000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component("gold_small", 2)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xs_qt_steel_facemask",
    result = "xs_qt_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component("gold_small", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xl_qt_steel_facemask",
    result = "xl_qt_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4350000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component("gold_small", 3)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "ch_steel_facemask",
    result = "ch_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9432000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("gold_small", 2)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xs_ch_steel_facemask",
    result = "xs_ch_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("gold_small", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "xl_ch_steel_facemask",
    result = "xl_ch_steel_facemask",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3990000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("gold_small", 3)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "hijab",
    result = "hijab",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "niqab",
    result = "niqab",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "hat_hard_modified",
    result = "hat_hard_modified",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal_small", 2)
    :component("nuts_bolts", 12)
    :component_any({
            { id = "hat_hard", count = 1 },
            { id = "hat_hard_hooded", count = 1 }
        })
    :quality("DRILL", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "helmet_motor_modified",
    result = "helmet_motor_modified",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("helmet_mounting_brackets", 1)
    :component_any({
            { id = "helmet_motor", count = 1 },
            { id = "helmet_motor_raised", count = 1 }
        })
    :quality("DRILL", 2, 1)
    :quality("THREAD_CUT", 2, 1)
    :quality("SCREW", 1, 1)
)

content.add(content.Recipe {
    id = "xl_mask_dust",
    result = "xl_mask_dust",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
)
