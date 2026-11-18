local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "grass_sheet",
    result = "grass_sheet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("grass_yarn", 5)
    :requirement("sewing_simple", 10)
)

content.add(content.Recipe {
    id = "grass_blanket",
    result = "grass_blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("grass_yarn", 10)
    :requirement("sewing_simple", 30)
)

content.add(content.Recipe {
    id = "grass_blanket_from_sheet",
    result = "grass_blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("grass_sheet", 2)
    :requirement("sewing_simple", 20)
)

content.add(content.Recipe {
    id = "blanket_blanket_makeshift",
    result = "blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    variant = "blanket_makeshift",
}
    :requirement("tailoring_cotton_patchwork_simple", 33)
    :byproduct("cotton_patchwork", 6)
    :byproduct("scrap_cotton", 2)
)

-- Patchwork quilts are quicker to make because the crafter is primarily concerned about warmth, not beauty.
-- Similar filling calculation as the quilt recipe.
content.add(content.Recipe {
    id = "quilt_patchwork",
    result = "quilt_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "cotton_ball", count = 150 },
            { id = "gambeson_batting", count = 75 }
        })
    :component_any({
            { id = "sheet_felt", count = 33 },
            { id = "sheet_felt_patchwork", count = 33 },
            { id = "scrap_felt", count = 264 }
        })
    :component("filament", 165, true)
    :quality("SEW", 1, 1)
    :quality("FABRIC_CUT", 1, 1)
    :proficiency("prof_quilting", { required = false, max_experience_turns = 7200 })
    :byproduct("felt_patch", 6)
    :byproduct("scrap_felt", 2)
)

content.add(content.Recipe {
    id = "electric_blanket",
    result = "electric_blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("plastic_chunk", 4)
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 12 }
        })
    :component("cable", 4)
    :component("amplifier", 1)
    :requirement("tailoring_nylon_patchwork", 33)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 2)
    :book("textbook_tailor", 2)
    :book("manual_tailor", 2)
    :proficiency("prof_elec_soldering")
    :byproduct("sheet_nylon_patchwork", 6)
    :byproduct("scrap_nylon", 2)
)

content.add(content.Recipe {
    id = "down_blanket",
    result = "down_blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 510000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("down_feather", 10)
    :requirement("tailoring_cotton_patchwork_simple", 33)
    :byproduct("scrap_cotton", 2)
)

content.add(content.Recipe {
    id = "fur_blanket",
    result = "fur_blanket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork_simple", 33)
    :requirement("tailoring_fur_patchwork_simple", 10)
    :requires_skill("survival", 1)
    :learn_by_disassembly("tailor", 0)
    :proficiency("prof_leatherworking_basic")
    :byproduct("cotton_patchwork", 6)
    :byproduct("scrap_cotton", 2)
    :byproduct("fur", 3)
)

content.add(content.Recipe {
    id = "fur_cat_tail",
    result = "fur_cat_tail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("fur", 4)
    :component("cordage", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 10 },
            { id = "plastic_bottles_4l", count = 1, requirement = true }
        })
    :requirement("sewing_standard", 10)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "faux_fur_cat_tail",
    result = "faux_fur_cat_tail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("faux_fur", 4)
    :component("cordage", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 10 },
            { id = "plastic_bottles_4l", count = 1, requirement = true }
        })
    :requirement("sewing_standard", 10)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 2)
)

content.add(content.Recipe {
    id = "fur_collar",
    result = "fur_collar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_any({
            { id = "soldering_standard", charges = 10, requirement = true },
            { id = "surface_heat", charges = 10, requirement = true }
        })
    :component("fur", 2)
    :component("scrap", 1)
    :requirement("sewing_standard", 5)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "faux_fur_collar",
    result = "faux_fur_collar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_any({
            { id = "soldering_standard", charges = 10, requirement = true },
            { id = "surface_heat", charges = 10, requirement = true }
        })
    :component("faux_fur", 2)
    :component("scrap", 1)
    :requirement("sewing_standard", 5)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 3)
)

content.add(content.Recipe {
    id = "leather_cat_tail",
    result = "leather_cat_tail",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("leather", 4)
    :component("cordage", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 10 },
            { id = "plastic_bottles_4l", count = 1, requirement = true }
        })
    :requirement("sewing_standard", 10)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "leather_collar",
    result = "leather_collar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :tool_any({
            { id = "soldering_standard", charges = 10, requirement = true },
            { id = "surface_heat", charges = 10, requirement = true }
        })
    :component("leather", 2)
    :component("scrap", 1)
    :requirement("sewing_standard", 5)
    :book("mag_animecon", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- Quicklime is slaked with KOH solution (1 part KOH per 2 parts CaO, I assume mass), after that water is
-- evaporated, the resulting mix is heated up in a crucible and resulting chunks are broken into granules
content.add(content.Recipe {
    id = "rebreather_filler_soda_lime",
    result = "rebreather_filler_soda_lime",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 60, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("material_quicklime", 70)
    :component_any({
            { id = "lye_potassium", count = 4 },
            { id = "lye", count = 4 }
        })
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :requirement("forging_standard", 6)
    :book("textbook_fireman", 4)
    :book("atomic_survival", 4)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(90)
)

-- Potassium is just heated up until it reacts with the oxygen in air
content.add(content.Recipe {
    id = "rebreather_filler_ko2",
    result = "rebreather_filler_ko2",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 50, true)
    :component("chem_potassium", 350)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :book("textbook_fireman", 4)
    :book("atomic_survival", 4)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 4)
    :result_charges(90)
)

content.add(content.Recipe {
    id = "rebreather_cartridge_air_ground_up",
    result = "rebreather_cartridge_air",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "FULL_MAGAZINE" },
}
    :component("hose", 2)
    :component("rebreather_filler_soda_lime", 90)
    :component("wire_mesh", 1)
    :component_any({
            { id = "scrap", count = 8 },
            { id = "can_food", count = 4 },
            { id = "can_drink", count = 4 },
            { id = "canister_empty", count = 4 }
        })
    :component_any({
            { id = "small_scuba_tank", count = 1 },
            { id = "oxygen_tank", count = 1 }
        })
    :quality("PRESSURIZATION", 1, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("glue_waterproof", 10)
    :book("textbook_fireman", 4)
    :book("atomic_survival", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 4)
    :book("manual_swimming", 3)
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "rebreather_cartridge_o2_ground_up",
    result = "rebreather_cartridge_o2",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "FULL_MAGAZINE" },
}
    :tool_charges("pseudo_app_oxygen_concentrator", 1620)
    :tool_charges("pseudo_app_hd_compressor_unit", 1350)
    :component("hose", 2)
    :component("rebreather_filler_soda_lime", 180)
    :component("wire_mesh", 1)
    :component_any({
            { id = "scrap", count = 8 },
            { id = "can_food", count = 4 },
            { id = "can_drink", count = 4 },
            { id = "canister_empty", count = 4 }
        })
    :component_any({
            { id = "small_scuba_tank", count = 1 },
            { id = "oxygen_tank", count = 1 }
        })
    :quality("FABRIC_CUT", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("glue_waterproof", 10)
    :book("textbook_fireman", 4)
    :book("atomic_survival", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 4)
    :book("manual_swimming", 3)
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "rebreather_cartridge_air_refill",
    result = "rebreather_cartridge_air",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "FULL_MAGAZINE" },
}
    :component("rebreather_filler_soda_lime", 90)
    :component_any({
            { id = "rebreather_cartridge_air", count = 1 },
            { id = "rebreather_cartridge_o2", count = 1 }
        })
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "rebreather_cartridge_o2_refill",
    result = "rebreather_cartridge_o2",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "FULL_MAGAZINE" },
}
    :tool_charges("pseudo_app_oxygen_concentrator", 1620)
    :tool_charges("pseudo_app_hd_compressor_unit", 1350)
    :component("rebreather_filler_soda_lime", 180)
    :component_any({
            { id = "rebreather_cartridge_air", count = 1 },
            { id = "rebreather_cartridge_o2", count = 1 }
        })
)

content.add(content.Recipe {
    id = "rebreather_cartridge_regen_ground_up",
    result = "rebreather_cartridge_regen",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "FULL_MAGAZINE" },
}
    :component("hose", 2)
    :component("rebreather_filler_ko2", 360)
    :component("wire_mesh", 1)
    :component_any({
            { id = "scrap", count = 10 },
            { id = "can_food", count = 5 },
            { id = "can_drink", count = 5 },
            { id = "canister_empty", count = 5 }
        })
    :quality("FABRIC_CUT", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("glue_waterproof", 10)
    :book("textbook_fireman", 4)
    :book("atomic_survival", 4)
    :book("emergency_book", 3)
    :book("textbook_gaswarfare", 4)
    :book("manual_swimming", 3)
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "rebreather_cartridge_regen_refill",
    result = "rebreather_cartridge_regen",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "FULL_MAGAZINE" },
}
    :component("rebreather_cartridge_regen", 1)
    :component("rebreather_filler_ko2", 360)
)

content.add(content.Recipe {
    id = "gasfilter_sm",
    result = "gasfilter_sm",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("charcoal", 5)
    :component("paper", 2)
    :component_any({
            { id = "plastic_sheet_small", count = 1 },
            { id = "bottle_plastic_small", count = 1 }
        })
)

content.add(content.Recipe {
    id = "gasfilter_med",
    result = "gasfilter_med",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("charcoal", 10)
    :component("paper", 2)
    :component_any({
            { id = "plastic_sheet_small", count = 1 },
            { id = "bottle_plastic_small", count = 1 }
        })
)

content.add(content.Recipe {
    id = "sleeping_bag_roll",
    result = "sleeping_bag_roll",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 28)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "sleeping_bag_fur_roll",
    result = "sleeping_bag_fur_roll",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "sheet_fur_patchwork", count = 3 },
            { id = "tanned_pelt", count = 3 },
            { id = "wool_staple", count = 12 }
        })
    :requirement("tailoring_cotton_patchwork", 17)
    :requirement("sewing_standard", 10)
    :requires_skill("survival", 1)
    :learn_by_disassembly("tailor", 4)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("cotton_patchwork", 1)
)

content.add(content.Recipe {
    id = "sleeping_bag_improvised",
    result = "sleeping_bag_improvised",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("bag_body_bag", 1)
    :component_any({
            { id = "withered", count = 180 },
            { id = "straw_pile", count = 180 }
        })
)

content.add(content.Recipe {
    id = "survivor_belt_notools",
    result = "survivor_belt_notools",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather", count = 6 },
            { id = "tanned_hide", count = 1 },
            { id = "leather_belt", count = 1 }
        })
    :component("duct_tape", 100)
    :component("sheath", 1)
    :component_any({
            { id = "legrig", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "dump_pouch", count = 1 },
            { id = "leather_pouch", count = 4 }
        })
    :component_any({
            { id = "sholster", count = 1 },
            { id = "holster", count = 1 }
        })
    :requirement("sewing_standard", 160)
    :requires_skill("fabrication", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "towel_knitting",
    result = "towel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("cotton_patchwork", 11)
    :requirement("sewing_standard", 7)
)

content.add(content.Recipe {
    id = "makeshift_ear_plugs_off",
    result = "makeshift_ear_plugs_off",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "lighter", charges = 5 },
            { id = "ref_lighter", charges = 5 },
            { id = "surface_heat", charges = 2, requirement = true }
        })
    :component_any({
            { id = "wax_any", count = 1, requirement = true },
            { id = "candle", count = 1 }
        })
    :component("cordage_short", 1, true)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "belt_loop_small",
    result = "belt_loop_small",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("nylon", 1)
    :requirement("sewing_standard", 10)
)

content.add(content.Recipe {
    id = "belt_loop_medium",
    result = "belt_loop_medium",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("belt_loop_small", 2)
    :requirement("sewing_standard", 10)
)

content.add(content.Recipe {
    id = "belt_loop_large",
    result = "belt_loop_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("belt_loop_medium", 2)
    :requirement("sewing_standard", 10)
)
