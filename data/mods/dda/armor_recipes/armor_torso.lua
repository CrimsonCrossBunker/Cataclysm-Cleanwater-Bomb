local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "apron_leather",
    result = "apron_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "apron_plastic",
    result = "apron_plastic",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("waterproofing_plastic_sheets", 8)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "apron_cut_resistant",
    result = "apron_cut_resistant",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_kevlar_fabric", 6)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "armor_lamellar",
    result = "armor_lamellar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cordage_superior", 4, true)
    :requirement("tailoring_cotton_small", 4)
    :requirement("tailoring_leather_patchwork", 8)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xs_armor_lamellar",
    result = "xs_armor_lamellar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cordage_superior", 3, true)
    :requirement("tailoring_cotton_small", 3)
    :requirement("tailoring_leather_patchwork", 6)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_armor_lamellar",
    result = "xl_armor_lamellar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cordage_superior", 6, true)
    :requirement("tailoring_cotton_small", 5)
    :requirement("tailoring_leather_patchwork", 9)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "bikini_top_leather",
    result = "bikini_top_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_patchwork", 1)
    :book("mag_animecon", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "carpet_cuirass",
    result = "carpet_cuirass",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "y_carpet", count = 1 },
            { id = "r_carpet", count = 1 },
            { id = "p_carpet", count = 1 },
            { id = "g_carpet", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 8, requirement = true },
            { id = "duct_tape", count = 200 }
        })
    :quality("CUT", 2, 1)
)

-- Average ichcahuipilli was around 1 inch (~2.5 cm) thick. As cotton padding constituted the majority of its
-- protective qualities, I'll consider the quilted part 0.5 cm thick.
-- This leaves us with 20 layers of cotton sheets, taking the thickness of a cotton sheet as 0.25 mm.
-- Average length of a human male is around 170 cm. Average weight of a human (in North America) is 80 kg.
-- BSA calculation and rule of the nines gives us about 0,68 m^2 or 7,3 sq feet.
-- I'll round that down to 7 for ease, as well as compensating for average woman being shorter and thinner
-- and Americans being exceptionally fat.
-- Our cotton sheets are 1x2 feet. 20 layers x 7 sq ft / 2 sq ft of the sheets = 70 sheets. I know the outer
-- layer of quilting would require more sheets because of the padding inbetween but I won't bother doing the
-- maths for it
-- Cotton padding inbetween would make 0.065 ft (2 cm of cotton) x 7 sq ft of torso = 0,455 cube ft which is
-- about 12,88 liters of cotton. Once again this calculation is off but again, I can't do the maths.
-- That's about… a lot of cotton, 1288 patches or 429 balls or 257 sheets to be precise. Byproducts I made
-- up.
-- That's 70x0,04 + 1288x0,01 = 15,6 kgs and some more for leather and salt wtf
-- And 70x0,05 + 1288x0,01 = 16,3 L.
content.add(content.Recipe {
    id = "armor_aztec",
    result = "armor_aztec",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 39600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :tool("metal_tank", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1288 },
            { id = "scrap_cotton", count = 6000 },
            { id = "cotton_ball", count = 429 },
            { id = "sheet_cotton", count = 257 },
            { id = "sheet_cotton_patchwork", count = 257 }
        })
    :component("salt_water", 80)
    :component_any({
            { id = "sheet_leather", count = 5 },
            { id = "sheet_leather_patchwork", count = 5 }
        })
    :quality("SEW", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_cotton_patchwork", 70)
    :requirement("filament", 100)
    :requires_skill("chemistry", 2)
    :book("textbook_mesoam", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_cotton", 250)
    :byproduct("cotton_patchwork", 40)
)

content.add(content.Recipe {
    id = "chestguard_metal_sheets",
    result = "chestguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 2)
    :component("leather_belt", 2)
    :component_any({
            { id = "nuts_bolts", count = 12 },
            { id = "nails", count = 12, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "ch_chestguard_metal_sheets",
    result = "ch_chestguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("chestguard_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "chestguard_metal_sheets_heavy",
    result = "chestguard_metal_sheets_heavy",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2640000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 4)
    :component("leather_belt", 2)
    :component_any({
            { id = "nuts_bolts", count = 12 },
            { id = "nails", count = 12, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "ch_chestguard_metal_sheets_heavy",
    result = "ch_chestguard_metal_sheets_heavy",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 128)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("chestguard_metal_sheets_heavy", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 5)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "chestguard_metal_sheets_light",
    result = "chestguard_metal_sheets_light",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("leather_belt", 2)
    :component_any({
            { id = "nuts_bolts", count = 12 },
            { id = "nails", count = 12, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "ch_chestguard_metal_sheets_light",
    result = "ch_chestguard_metal_sheets_light",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 32)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("chestguard_metal_sheets_light", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "bookplate",
    result = "bookplate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("paper", 1200)
    :component("duct_tape", 150)
    :quality("CUT", 2, 1)
    :book("recipe_melee", 2)
)

content.add(content.Recipe {
    id = "bellyband",
    result = "bellyband",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 150)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "bellywrap",
    result = "bellywrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("cotton_patchwork", 24)
)

content.add(content.Recipe {
    id = "bellywrap_fur",
    result = "bellywrap_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("fur", 24)
)

content.add(content.Recipe {
    id = "bellywrap_leather",
    result = "bellywrap_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("leather", 24)
)

content.add(content.Recipe {
    id = "bellywrap_wool",
    result = "bellywrap_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("felt_patch", 40)
)

content.add(content.Recipe {
    id = "chestwrap",
    result = "chestwrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sheet_cotton", count = 3 },
            { id = "sheet_cotton_patchwork", count = 3 }
        })
)

content.add(content.Recipe {
    id = "chestwrap_fur",
    result = "chestwrap_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "tanned_pelt", count = 1 },
            { id = "sheet_fur_patchwork", count = 1 }
        })
)

content.add(content.Recipe {
    id = "chestwrap_leather",
    result = "chestwrap_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
)

content.add(content.Recipe {
    id = "chestwrap_wool",
    result = "chestwrap_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sheet_felt_patchwork", count = 4 },
            { id = "sheet_felt", count = 4 }
        })
    :requirement("fabric_felt", 9)
)

content.add(content.Recipe {
    id = "coat_gut",
    result = "coat_gut",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "stomach_sealed", count = 16 },
            { id = "large_stomach_sealed", count = 10 }
        })
    :component("filament", 60, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 5)
    :book("trappers_companion", 6)
    :book("survival_book", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "coat_rain",
    result = "coat_rain",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("fastener_large", 1)
    :requirement("fabric_standard_nostretch", 10)
    :requirement("waterproofing_plastic_sheets", 10)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "coat_straw",
    result = "coat_straw",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 69120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("straw_pile", 40)
    :component("cordage", 3, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("survival", 8)
    :book("tailor_japanese", 6)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "cuirass_lightplate",
    result = "cuirass_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_leather_patchwork", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xs_cuirass_lightplate",
    result = "xs_cuirass_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_leather_patchwork", 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_cuirass_lightplate",
    result = "xl_cuirass_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3660000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_leather_small", 6)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "cuirass_scrap",
    result = "cuirass_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 8)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 2)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "xs_cuirass_scrap",
    result = "xs_cuirass_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 6)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "xl_cuirass_scrap",
    result = "xl_cuirass_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 10)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 3)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "cuirass_tire",
    result = "cuirass_tire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 8)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xs_cuirass_tire",
    result = "xs_cuirass_tire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 6)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 2)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_cuirass_tire",
    result = "xl_cuirass_tire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 330000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 10)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "duster_leather",
    result = "duster_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("sewing_standard", 60)
    :requirement("tailoring_leather_patchwork", 9)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_duster_leather",
    result = "xs_duster_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("sewing_standard", 45)
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_duster_leather",
    result = "xl_duster_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("sewing_standard", 80)
    :requirement("tailoring_leather_patchwork", 12)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "flotation_vest_ms",
    result = "flotation_vest_ms",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("rope_natural_short", 2, true)
    :requirement("sewing_standard", 360)
    :requirement("fabric_leather_fur_hide", 9)
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "garter_belt",
    result = "garter_belt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("clasps", 4, true)
    :requirement("tailoring_cotton", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "greatcoat",
    result = "greatcoat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("sewing_standard", 160)
    :requirement("fabric_felt", 33)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "haori",
    result = "haori",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_cotton_patchwork", 24)
    :book("tailor_japanese", 5)
)

content.add(content.Recipe {
    id = "hoodie_cropped_cutting",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("hoodie", 1)
    :quality("FABRIC_CUT", 1, 1)
)

content.add(content.Recipe {
    id = "sweatshirt",
    result = "sweatshirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 38)
)

content.add(content.Recipe {
    id = "house_coat",
    result = "house_coat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 36)
)

content.add(content.Recipe {
    id = "cloth_shirt_padded",
    result = "cloth_shirt_padded",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "hoodie", count = 1 },
            { id = "sweatshirt", count = 1 }
        })
    :requirement("tailoring_cotton_patchwork", 20)
)

content.add(content.Recipe {
    id = "cloth_vest_padded",
    result = "cloth_vest_padded",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("cloth_shirt_padded", 1)
    :quality("CUT", 2, 1)
    :byproduct("cloth_arms_padded", 1)
)

content.add(content.Recipe {
    id = "jacket_jean",
    result = "jacket_jean",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_denim_patchwork", 10)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 2)
    :book("manual_tailor", 1)
    :proficiency("prof_closures")
    :byproduct("denim_patch", 6)
)

content.add(content.Recipe {
    id = "vest_jean_from_patchwork",
    result = "vest_jean",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_denim_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 2)
    :book("manual_tailor", 1)
    :proficiency("prof_closures")
    :byproduct("denim_patch", 4)
)

content.add(content.Recipe {
    id = "vest_jean_from_jacket",
    result = "vest_jean",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("jacket_jean", 1)
    :requirement("sewing_standard", 10)
    :byproduct("denim_patch", 6)
)

content.add(content.Recipe {
    id = "jacket_leather",
    result = "jacket_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("sewing_standard", 30)
    :requirement("tailoring_leather_patchwork", 5)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_police_jacket",
    result = "leather_police_jacket",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("sewing_standard", 40)
    :requirement("tailoring_leather_patchwork", 7)
    :requirement("fastener_large", 2)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "jacket_leather_mod",
    result = "jacket_leather_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("leather_police_jacket", 1)
    :component("sheet_metal_small", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 100)
    :requirement("fastener_large", 1)
    :requires_skill("tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "jacket_jean_mod",
    result = "jacket_jean_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("jacket_jean", 1)
    :component("sheet_metal_small", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 100)
    :requirement("fastener_large", 1)
    :requires_skill("tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "vest_jean_mod",
    result = "vest_jean_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("jacket_jean", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requirement("fastener_large", 1)
    :requires_skill("tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "jacket_leather_mod_ch",
    result = "jacket_leather_mod_ch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 120)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("leather_police_jacket", 1)
    :component("sheet_metal_small", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 100)
    :requirement("fastener_large", 1)
    :requirement("carbon", 10)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "jacket_jean_mod_ch",
    result = "jacket_jean_mod_ch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 120)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("jacket_jean", 1)
    :component("sheet_metal_small", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 100)
    :requirement("fastener_large", 1)
    :requirement("carbon", 10)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "vest_jean_mod_ch",
    result = "vest_jean_mod_ch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 70)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("vest_jean", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requirement("fastener_large", 1)
    :requirement("carbon", 6)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "jacket_leather_tire",
    result = "jacket_leather_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("leather_police_jacket", 1)
    :component("rubber_tire_chunk", 8)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("sewing_standard", 50)
    :requirement("fastener_large", 1)
    :requirement("adhesive_rubber", 10)
    :requires_skill("fabrication", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leotard",
    result = "leotard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 990000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 13)
    :requirement("fabric_lycra", 8)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 6)
)

content.add(content.Recipe {
    id = "long_undertop",
    result = "long_undertop",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 630000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 16)
)

content.add(content.Recipe {
    id = "long_undertop_sleeveless",
    result = "long_undertop_sleeveless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 8)
)

content.add(content.Recipe {
    id = "long_undertop_sleeveless_cutting",
    result = "long_undertop_sleeveless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("long_undertop", 1)
    :quality("CUT", 1, 1)
    :byproduct("cotton_patchwork", 4)
)

content.add(content.Recipe {
    id = "longshirt",
    result = "longshirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 8)
)

content.add(content.Recipe {
    id = "denim_shirt",
    result = "denim_shirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("button_plastic", 5)
    :requirement("sewing_standard", 30)
    :requirement("tailoring_denim_patchwork", 8)
)

content.add(content.Recipe {
    id = "scrap_esapi_plate",
    result = "scrap_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cotton_patchwork", 3)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
)

content.add(content.Recipe {
    id = "lc_esapi_plate",
    result = "lc_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 34560000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("recipe_melee", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_esapi_plate",
    result = "mc_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 34560000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_esapi_plate",
    result = "hc_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 34560000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_esapi_plate",
    result = "ch_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("carbon", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_esapi_plate",
    result = "qt_esapi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 47520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "scrap_esbi_plate",
    result = "scrap_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cotton_patchwork", 2)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
)

content.add(content.Recipe {
    id = "lc_esbi_plate",
    result = "lc_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_esbi_plate",
    result = "mc_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_esbi_plate",
    result = "hc_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_esbi_plate",
    result = "ch_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("carbon", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_esbi_plate",
    result = "qt_esbi_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("recipe_melee", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "peacoat",
    result = "peacoat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_felt_patchwork", 36)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "shirt_straw",
    result = "shirt_straw",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :tool("loom_frame", 1)
    :tool("shed_stick", 1)
    :component("grass_yarn", 5)
    :quality("CUT", 2, 1)
    :proficiency("prof_weaving")
)

content.add(content.Recipe {
    id = "poncho",
    result = "poncho",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 210000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_felt_patchwork", 18)
)

content.add(content.Recipe {
    id = "poncho_knitted",
    result = "poncho",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_wool_knitting", 910)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster",
    result = "sleeveless_duster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2448000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 32)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_from_duster",
    result = "sleeveless_duster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("duster", 1)
    :quality("CUT", 2, 1)
    :byproduct("canvas_patch", 8)
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_fur",
    result = "sleeveless_duster_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_fur_patchwork", 8)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_faux_fur",
    result = "sleeveless_duster_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_faux_fur_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 1)
    :byproduct("scrap_faux_fur", 6)
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_fur_from_duster_fur",
    result = "sleeveless_duster_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("duster_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("fur", 4)
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_faux_fur_from_duster_faux_fur",
    result = "sleeveless_duster_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("duster_faux_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("faux_fur", 4)
    :byproduct("scrap_faux_fur", 4)
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_leather",
    result = "sleeveless_duster_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2754000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_leather_from_duster_leather",
    result = "sleeveless_duster_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("duster_leather", 1)
    :quality("CUT", 2, 1)
    :byproduct("leather", 4)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_from_trenchcoat",
    result = "sleeveless_trenchcoat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("trenchcoat", 1)
    :quality("CUT", 2, 1)
    :byproduct("canvas_patch", 8)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat",
    result = "sleeveless_trenchcoat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 27)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_fur_from_trenchcoat_fur",
    result = "sleeveless_trenchcoat_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("trenchcoat_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("fur", 4)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_faux_fur_from_trenchcoat_faux_fur",
    result = "sleeveless_trenchcoat_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("trenchcoat_faux_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("faux_fur", 4)
    :byproduct("scrap_faux_fur", 4)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_fur",
    result = "sleeveless_trenchcoat_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_fur_patchwork", 8)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_faux_fur",
    result = "sleeveless_trenchcoat_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("fabric_fauxfur", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 1)
    :byproduct("scrap_faux_fur", 3)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_leather_from_trenchcoat_leather",
    result = "sleeveless_trenchcoat_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("trenchcoat_leather", 1)
    :quality("CUT", 2, 1)
    :byproduct("leather", 4)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_leather",
    result = "sleeveless_trenchcoat_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "sleeveless_tunic_cutting",
    result = "sleeveless_tunic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("tunic", 1)
    :quality("CUT", 1, 1)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "sleeveless_tunic",
    result = "sleeveless_tunic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 8)
    :requirement("tailoring_cotton_patchwork", 8)
)

content.add(content.Recipe {
    id = "sports_bra",
    result = "sports_bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 2)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 3)
)

content.add(content.Recipe {
    id = "xssports_bra",
    result = "xssports_bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 1)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 2)
)

content.add(content.Recipe {
    id = "xlsports_bra",
    result = "xlsports_bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 4)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 2)
)

content.add(content.Recipe {
    id = "sundress",
    result = "sundress",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 6)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
)

content.add(content.Recipe {
    id = "maid_dress",
    result = "maid_dress",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 8)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_dress_xl",
    result = "maid_dress_xl",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 12)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_dress_xs",
    result = "maid_dress_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 4)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_dress_short",
    result = "maid_dress_short",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 42000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 6)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_dress_short_xl",
    result = "maid_dress_short_xl",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 8)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "maid_dress_short_xs",
    result = "maid_dress_short_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 42000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton", 3)
    :book("mag_animecon", 1)
)

content.add(content.Recipe {
    id = "sweater",
    result = "sweater",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_wool_knitting", 550)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "turtleneck",
    result = "turtleneck",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2520000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_wool_knitting", 478)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "turtleneck_shirt",
    result = "turtleneck_shirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 14)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
)

content.add(content.Recipe {
    id = "tank_top",
    result = "tank_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 228000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :byproduct("scrap_cotton", 22)
)

content.add(content.Recipe {
    id = "tireplate",
    result = "tireplate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 16)
    :component("duct_tape", 16)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "thermal_shirt",
    result = "thermal_shirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 8)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 6)
)

content.add(content.Recipe {
    id = "trenchcoat",
    result = "trenchcoat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 30)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "trenchcoat_fur",
    result = "trenchcoat_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_fur_patchwork", 12)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "trenchcoat_faux_fur",
    result = "trenchcoat_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_faux_fur_patchwork", 12)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 2)
    :byproduct("scrap_faux_fur", 4)
)

content.add(content.Recipe {
    id = "trenchcoat_leather",
    result = "trenchcoat_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 12)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "tshirt",
    result = "tshirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
)

content.add(content.Recipe {
    id = "tshirt_cropped",
    result = "tshirt_cropped",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "tshirt_cropped_cutting",
    result = "tshirt_cropped",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("tshirt", 1)
    :quality("FABRIC_CUT", 1, 1)
)

content.add(content.Recipe {
    id = "tshirt_cutting",
    result = "tshirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("longshirt", 1)
    :quality("CUT", 1, 1)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "tunic",
    result = "tunic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 8)
)

content.add(content.Recipe {
    id = "under_armor",
    result = "under_armor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 4)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 3)
)

content.add(content.Recipe {
    id = "undershirt",
    result = "undershirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
)

content.add(content.Recipe {
    id = "unitard",
    result = "unitard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_lycra_patchwork", 10)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 7)
)

content.add(content.Recipe {
    id = "kevlar",
    result = "kevlar",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :quality("SEW", 2, 1)
    :requirement("armor_kevlar_layered", 4)
    :requirement("tailoring_nylon_patchwork", 12)
    :learn_by_disassembly("tailor", 6)
    :proficiency("prof_polymerworking", { required = false, time_multiplier = 1.25 })
)

content.add(content.Recipe {
    id = "xlkevlar",
    result = "xlkevlar",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 27000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :quality("SEW", 2, 1)
    :requirement("armor_kevlar_layered", 12)
    :requirement("tailoring_nylon_patchwork", 30)
    :learn_by_disassembly("tailor", 6)
    :proficiency("prof_polymerworking", { required = false, time_multiplier = 1.25 })
)

content.add(content.Recipe {
    id = "vest_leather_from_patches",
    result = "vest_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 840000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "vest_leather",
    result = "vest_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("leather_police_jacket", 1)
    :quality("CUT", 2, 1)
    :byproduct("leather", 4)
)

content.add(content.Recipe {
    id = "vest_leather_mod",
    result = "vest_leather_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1152000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("vest_leather", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requirement("fastener_large", 1)
    :requires_skill("tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "vest_leather_mod_ch",
    result = "vest_leather_mod_ch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("vest_leather", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requirement("fastener_large", 1)
    :requirement("carbon", 5)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "jacket_windbreaker",
    result = "jacket_windbreaker",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 7)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
    :byproduct("scrap_nylon", 50)
)

content.add(content.Recipe {
    id = "wool_hoodie",
    result = "wool_hoodie",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 240000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_felt_patchwork", 20)
)

content.add(content.Recipe {
    id = "armor_lamellar_lc",
    result = "armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 864)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 110)
    :requirement("fabric_leather_fur_hide", 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xs_armor_lamellar_lc",
    result = "xs_armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 648)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 90)
    :requirement("fabric_leather_fur_hide", 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lamellar_lc",
    result = "xl_armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 1080)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 140)
    :requirement("fabric_leather_fur_hide", 2)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_lamellar_lc_repair",
    result = "armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 18)
    :component("armor_lamellar_lc", 1)
    :requirement("cordage", 6)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xs_armor_lamellar_lc_repair",
    result = "xs_armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 12)
    :component("xs_armor_lamellar_lc", 1)
    :requirement("cordage", 4)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_armor_lamellar_lc_repair",
    result = "xl_armor_lamellar_lc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_lc", 24)
    :component("xl_armor_lamellar_lc", 1)
    :requirement("cordage", 8)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "armor_lamellar_ch",
    result = "armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 864)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 110)
    :requirement("fabric_leather_fur_hide", 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xs_armor_lamellar_ch",
    result = "xs_armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 648)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 90)
    :requirement("fabric_leather_fur_hide", 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lamellar_ch",
    result = "xl_armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 1080)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 140)
    :requirement("fabric_leather_fur_hide", 2)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_lamellar_ch_repair",
    result = "armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 18)
    :component("armor_lamellar_ch", 1)
    :requirement("cordage", 6)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xs_armor_lamellar_ch_repair",
    result = "xs_armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 12)
    :component("xs_armor_lamellar_ch", 1)
    :requirement("cordage", 4)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_armor_lamellar_ch_repair",
    result = "xl_armor_lamellar_ch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_ch", 24)
    :component("xl_armor_lamellar_ch", 1)
    :requirement("cordage", 8)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "lc_chainmail_vest",
    result = "lc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 7)
    :component("lc_chain_link", 175)
    :component("lc_wire", 1)
    :requirement("chainmail_standard", 7)
    :requirement("tailoring_cotton_patchwork", 6)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_vest",
    result = "xs_lc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 5)
    :component("lc_chain_link", 131)
    :component("lc_wire", 1)
    :requirement("chainmail_standard", 5)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_vest",
    result = "xl_lc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 10)
    :component("lc_chain_link", 210)
    :component("lc_wire", 2)
    :requirement("chainmail_standard", 10)
    :requirement("tailoring_cotton_patchwork", 9)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_vest",
    result = "mc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 7)
    :component("mc_chain_link", 175)
    :component("mc_wire", 1)
    :requirement("chainmail_standard", 7)
    :requirement("tailoring_cotton_patchwork", 6)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_vest",
    result = "xs_mc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 5)
    :component("mc_chain_link", 131)
    :component("mc_wire", 1)
    :requirement("chainmail_standard", 5)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_vest",
    result = "xl_mc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("mc_link_sheet", 10)
    :component("mc_chain_link", 210)
    :component("mc_wire", 2)
    :requirement("chainmail_standard", 10)
    :requirement("tailoring_cotton_patchwork", 9)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_vest",
    result = "hc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 7)
    :component("hc_chain_link", 175)
    :component("hc_wire", 1)
    :requirement("chainmail_standard", 7)
    :requirement("tailoring_cotton_patchwork", 6)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_vest",
    result = "xs_hc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 5)
    :component("hc_chain_link", 131)
    :component("hc_wire", 1)
    :requirement("chainmail_standard", 5)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_vest",
    result = "xl_hc_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("hc_link_sheet", 10)
    :component("hc_chain_link", 210)
    :component("hc_wire", 2)
    :requirement("chainmail_standard", 10)
    :requirement("tailoring_cotton_patchwork", 9)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_vest",
    result = "ch_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 7)
    :component("ch_chain_link", 175)
    :component("ch_wire", 1)
    :requirement("chainmail_standard", 7)
    :requirement("tailoring_cotton_patchwork", 6)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_vest",
    result = "xs_ch_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 5)
    :component("ch_chain_link", 131)
    :component("ch_wire", 1)
    :requirement("chainmail_standard", 5)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_vest",
    result = "xl_ch_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("ch_link_sheet", 10)
    :component("ch_chain_link", 210)
    :component("ch_wire", 2)
    :requirement("chainmail_standard", 10)
    :requirement("tailoring_cotton_patchwork", 9)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_vest",
    result = "qt_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 7)
    :component("qt_chain_link", 175)
    :component("qt_wire", 1)
    :requirement("chainmail_standard", 7)
    :requirement("tailoring_cotton_patchwork", 6)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_vest",
    result = "xs_qt_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 5)
    :component("qt_chain_link", 131)
    :component("qt_wire", 1)
    :requirement("chainmail_standard", 5)
    :requirement("tailoring_cotton_patchwork", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_vest",
    result = "xl_qt_chainmail_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_link_sheet", 10)
    :component("qt_chain_link", 210)
    :component("qt_wire", 2)
    :requirement("chainmail_standard", 10)
    :requirement("tailoring_cotton_patchwork", 9)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "armor_cuirass",
    result = "armor_cuirass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 28)
    :requirement("forging_standard", 14)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 5)
    :book("textbook_armwest", 8)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xs_armor_cuirass",
    result = "xs_armor_cuirass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 21)
    :requirement("forging_standard", 10)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 5)
    :book("textbook_armwest", 8)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xl_armor_cuirass",
    result = "xl_armor_cuirass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 38)
    :requirement("forging_standard", 20)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 5)
    :book("textbook_armwest", 8)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "cuirass_bronze",
    result = "cuirass_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 22)
    :requirement("forging_standard", 12)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xs_cuirass_bronze",
    result = "xs_cuirass_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 15)
    :requirement("forging_standard", 8)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "xl_cuirass_bronze",
    result = "xl_cuirass_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3960000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 32)
    :requirement("forging_standard", 18)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "armor_lc_light_chestplate",
    result = "armor_lc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 86400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "xl_armor_lc_light_chestplate",
    result = "xl_armor_lc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 97632000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "armor_mc_light_chestplate",
    result = "armor_mc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 86400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "xl_armor_mc_light_chestplate",
    result = "xl_armor_mc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 97632000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "armor_hc_light_chestplate",
    result = "armor_hc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 86400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "xl_armor_hc_light_chestplate",
    result = "xl_armor_hc_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 97632000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
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
    id = "armor_ch_light_chestplate",
    result = "armor_ch_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 95040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
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
    id = "xl_armor_ch_light_chestplate",
    result = "xl_armor_ch_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 107394000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("carbon", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_light_chestplate",
    result = "armor_qt_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 99360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
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
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_light_chestplate",
    result = "xl_armor_qt_light_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 112272000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
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
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_chestplate",
    result = "armor_lc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 95040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
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
    id = "xl_armor_lc_chestplate",
    result = "xl_armor_lc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 107394000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_chestplate",
    result = "armor_mc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 95040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
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
    id = "xl_armor_mc_chestplate",
    result = "xl_armor_mc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 107394000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_chestplate",
    result = "armor_hc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 95040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
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
    id = "xl_armor_hc_chestplate",
    result = "xl_armor_hc_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 107394000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 24)
    :requirement("hc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_chestplate",
    result = "armor_ch_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 104544000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
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
    id = "xl_armor_ch_chestplate",
    result = "xl_armor_ch_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 118134000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :requirement("carbon", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_chestplate",
    result = "armor_qt_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 109296000,
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
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_chestplate",
    result = "xl_armor_qt_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 123504000,
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
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_heavy_chestplate",
    result = "armor_lc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 103680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_heavy_chestplate",
    result = "xl_armor_lc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 117156000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 28)
    :requirement("lc_steel_standard", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_heavy_chestplate",
    result = "armor_mc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 103680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_heavy_chestplate",
    result = "xl_armor_mc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 117156000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 28)
    :requirement("mc_steel_standard", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_heavy_chestplate",
    result = "armor_hc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 103680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("hc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_heavy_chestplate",
    result = "xl_armor_hc_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 117156000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 28)
    :requirement("hc_steel_standard", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_heavy_chestplate",
    result = "armor_ch_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 114048000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
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
    id = "xl_armor_ch_heavy_chestplate",
    result = "xl_armor_ch_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 128874000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 28)
    :requirement("lc_steel_standard", 7)
    :requirement("carbon", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_heavy_chestplate",
    result = "armor_qt_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 119232000,
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
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_heavy_chestplate",
    result = "xl_armor_qt_heavy_chestplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 134730000,
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
    :requirement("blacksmithing_standard", 28)
    :requirement("mc_steel_standard", 7)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "load_bearing_vest_sling",
    result = "load_bearing_vest_sling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("load_bearing_vest", 1)
    :component("single_sling", 1)
)

content.add(content.Recipe {
    id = "heavy_load_bearing_vest_sling",
    result = "heavy_load_bearing_vest_sling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("heavy_load_bearing_vest", 1)
    :component("single_sling", 1)
)

content.add(content.Recipe {
    id = "migo_plate",
    result = "migo_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("water", 10)
    :component("migo_plate_overgrown", 1)
    :quality("GRIND", 2, 1)
    :quality("FILE", 1, 1)
    :book("recipe_migo_plate", 1)
)

content.add(content.Recipe {
    id = "migo_sideplate",
    result = "migo_sideplate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("water", 10)
    :component("migo_sideplate_overgrown", 1)
    :quality("GRIND", 2, 1)
    :quality("FILE", 1, 1)
    :book("recipe_migo_plate", 1)
)

content.add(content.Recipe {
    id = "poncho_makeshift",
    result = "poncho_makeshift",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("bag_garbage", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "suspenders_cloth",
    result = "suspenders_cloth",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :requirement("clasps", 3)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "suspenders_leather",
    result = "suspenders_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("clasps", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_larmor_chest",
    result = "armor_larmor_chest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 5)
)

content.add(content.Recipe {
    id = "armor_larmor_chest_xs",
    result = "armor_larmor_chest_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 6)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "xl_armor_larmor_chest",
    result = "xl_armor_larmor_chest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 9)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "armor_lc_brigandine",
    result = "armor_lc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_lc_brigandine",
    result = "xl_armor_lc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_lc_brigandine_xs",
    result = "armor_lc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_mc_brigandine",
    result = "armor_mc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_mc_brigandine",
    result = "xl_armor_mc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_mc_brigandine_xs",
    result = "armor_mc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_hc_brigandine",
    result = "armor_hc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_hc_brigandine",
    result = "xl_armor_hc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("hc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_hc_brigandine_xs",
    result = "armor_hc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_ch_brigandine",
    result = "armor_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 5)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_armor_ch_brigandine",
    result = "xl_armor_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 6)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_ch_brigandine_xs",
    result = "armor_ch_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 4)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_brigandine",
    result = "armor_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_brigandine",
    result = "xl_armor_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 16200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_qt_brigandine_xs",
    result = "armor_qt_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_coat_brigandine",
    result = "armor_lc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 12)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_lc_coat_brigandine",
    result = "xl_armor_lc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("lc_steel_standard", 7)
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_lc_coat_brigandine_xs",
    result = "armor_lc_coat_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_mc_coat_brigandine",
    result = "armor_mc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 12)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_mc_coat_brigandine",
    result = "xl_armor_mc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("mc_steel_standard", 7)
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_mc_coat_brigandine_xs",
    result = "armor_mc_coat_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_hc_coat_brigandine",
    result = "armor_hc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("hc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 12)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_armor_hc_coat_brigandine",
    result = "xl_armor_hc_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("hc_steel_standard", 7)
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_hc_coat_brigandine_xs",
    result = "armor_hc_coat_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_ch_coat_brigandine",
    result = "armor_ch_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 12)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 5)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_armor_ch_coat_brigandine",
    result = "xl_armor_ch_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 16200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("lc_steel_standard", 7)
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 6)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_ch_coat_brigandine_xs",
    result = "armor_ch_coat_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :requirement("carbon", 4)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_coat_brigandine",
    result = "armor_qt_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 6)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_coat_brigandine",
    result = "xl_armor_qt_coat_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("mc_steel_standard", 7)
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_qt_coat_brigandine_xs",
    result = "armor_qt_coat_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :requirement("tailoring_canvas_patchwork", 10)
    :requirement("fastener_large", 1)
    :requirement("strap_large", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_brigandine_shoulders",
    result = "armor_lc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_lc_brigandine", 1)
    :component("lc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_lc_brigandine_shoulders",
    result = "xl_armor_lc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_lc_brigandine", 1)
    :component("xl_lc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_lc_brigandine_shoulders_xs",
    result = "armor_lc_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_lc_brigandine_xs", 1)
    :component("lc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_mc_brigandine_shoulders",
    result = "armor_mc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_mc_brigandine", 1)
    :component("mc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_mc_brigandine_shoulders",
    result = "xl_armor_mc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_mc_brigandine", 1)
    :component("xl_mc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_mc_brigandine_shoulders_xs",
    result = "armor_mc_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_mc_brigandine_xs", 1)
    :component("mc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_hc_brigandine_shoulders",
    result = "armor_hc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_hc_brigandine", 1)
    :component("hc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_hc_brigandine_shoulders",
    result = "xl_armor_hc_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_hc_brigandine", 1)
    :component("xl_hc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_hc_brigandine_shoulders_xs",
    result = "armor_hc_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_hc_brigandine_xs", 1)
    :component("hc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_ch_brigandine_shoulders",
    result = "armor_ch_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_ch_brigandine", 1)
    :component("ch_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_ch_brigandine_shoulders",
    result = "xl_armor_ch_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_ch_brigandine", 1)
    :component("xl_ch_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_ch_brigandine_shoulders_xs",
    result = "armor_ch_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_ch_brigandine_xs", 1)
    :component("ch_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_qt_brigandine_shoulders",
    result = "armor_qt_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_qt_brigandine", 1)
    :component("qt_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_qt_brigandine_shoulders",
    result = "xl_armor_qt_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_qt_brigandine", 1)
    :component("xl_qt_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_qt_brigandine_shoulders_xs",
    result = "armor_qt_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_qt_brigandine_xs", 1)
    :component("qt_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_lc_coat_brigandine_shoulders",
    result = "armor_lc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_lc_coat_brigandine", 1)
    :component("lc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_lc_coat_brigandine_shoulders",
    result = "xl_armor_lc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_lc_coat_brigandine", 1)
    :component("xl_lc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_lc_coat_brigandine_shoulders_xs",
    result = "armor_lc_coat_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_lc_coat_brigandine_xs", 1)
    :component("lc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_mc_coat_brigandine_shoulders",
    result = "armor_mc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_mc_coat_brigandine", 1)
    :component("mc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_mc_coat_brigandine_shoulders",
    result = "xl_armor_mc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_mc_coat_brigandine", 1)
    :component("xl_mc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_mc_coat_brigandine_shoulders_xs",
    result = "armor_mc_coat_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_mc_coat_brigandine_xs", 1)
    :component("mc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_hc_coat_brigandine_shoulders",
    result = "armor_hc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_hc_coat_brigandine", 1)
    :component("hc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_hc_coat_brigandine_shoulders",
    result = "xl_armor_hc_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_hc_coat_brigandine", 1)
    :component("xl_hc_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_hc_coat_brigandine_shoulders_xs",
    result = "armor_hc_coat_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_hc_coat_brigandine_xs", 1)
    :component("hc_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_ch_coat_brigandine_shoulders",
    result = "armor_ch_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_ch_coat_brigandine", 1)
    :component("ch_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_ch_coat_brigandine_shoulders",
    result = "xl_armor_ch_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_ch_coat_brigandine", 1)
    :component("xl_ch_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_ch_coat_brigandine_shoulders_xs",
    result = "armor_ch_coat_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_ch_coat_brigandine_xs", 1)
    :component("ch_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_qt_coat_brigandine_shoulders",
    result = "armor_qt_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_qt_coat_brigandine", 1)
    :component("qt_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "xl_armor_qt_coat_brigandine_shoulders",
    result = "xl_armor_qt_coat_brigandine_shoulders",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("xl_armor_qt_coat_brigandine", 1)
    :component("xl_qt_shoulder_guards", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "armor_qt_coat_brigandine_shoulders_xs",
    result = "armor_qt_coat_brigandine_shoulders_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("armor_qt_coat_brigandine_xs", 1)
    :component("qt_shoulder_guards_xs", 1)
    :book("textbook_armwest", 0)
)

content.add(content.Recipe {
    id = "lc_shoulder_guards",
    result = "lc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_lc_shoulder_guards",
    result = "xl_lc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "lc_shoulder_guards_xs",
    result = "lc_shoulder_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_shoulder_guards",
    result = "mc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_mc_shoulder_guards",
    result = "xl_mc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_shoulder_guards_xs",
    result = "mc_shoulder_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_shoulder_guards",
    result = "hc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_hc_shoulder_guards",
    result = "xl_hc_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_shoulder_guards_xs",
    result = "hc_shoulder_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_shoulder_guards",
    result = "ch_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_shoulder_guards",
    result = "xl_ch_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "ch_shoulder_guards_xs",
    result = "ch_shoulder_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_shoulder_guards",
    result = "qt_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_qt_shoulder_guards",
    result = "xl_qt_shoulder_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "qt_shoulder_guards_xs",
    result = "qt_shoulder_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "lc_mirror_armor",
    result = "lc_mirror_armor",
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
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_lc_mirror_armor",
    result = "xs_lc_mirror_armor",
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
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_lc_mirror_armor",
    result = "xl_lc_mirror_armor",
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
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_weparabic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "mc_mirror_armor",
    result = "mc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
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
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_mc_mirror_armor",
    result = "xs_mc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
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
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_mc_mirror_armor",
    result = "xl_mc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
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
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "hc_mirror_armor",
    result = "hc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
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
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xs_hc_mirror_armor",
    result = "xs_hc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2592000,
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
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "xl_hc_mirror_armor",
    result = "xl_hc_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2910000,
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
            { id = "leather", count = 6 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
)

content.add(content.Recipe {
    id = "qt_mirror_armor",
    result = "qt_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("polisher", 1)
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
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xs_qt_mirror_armor",
    result = "xs_qt_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4032000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("polisher", 1)
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
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_mirror_armor",
    result = "xl_qt_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4350000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("polisher", 1)
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
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "ch_mirror_armor",
    result = "ch_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
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
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_mirror_armor",
    result = "xs_ch_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3672000,
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
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_mirror_armor",
    result = "xl_ch_mirror_armor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3990000,
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
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ballistic_vest",
    result = "xl_ballistic_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "heavy_load_bearing_vest", count = 1 },
            { id = "load_bearing_vest", count = 1 },
            { id = "molle_large_rucksack", count = 1 },
            { id = "molle_medium_rucksack", count = 1 }
        })
    :component_any({
            { id = "light_load_bearing_vest", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "molle_pack", count = 1 }
        })
    :quality("SEW", 2, 1)
    :requirement("armor_kevlar_layered", 20)
    :requirement("tailoring_nylon_patchwork", 30)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_ballistic_vest_lc",
    result = "xl_ballistic_vest_lc",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("xl_ballistic_vest", 1)
    :component("sheet_metal_small", 20)
)

content.add(content.Recipe {
    id = "xl_ballistic_vest_qt",
    result = "xl_ballistic_vest_qt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("xl_ballistic_vest", 1)
    :component("steel_ballistic_plate", 10)
)

content.add(content.Recipe {
    id = "abaya",
    result = "abaya",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 6)
)

content.add(content.Recipe {
    id = "armor_mercenary_top",
    result = "armor_mercenary_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "jacket_army", count = 1 },
            { id = "jacket_army_modern", count = 1 }
        })
    :component("sheet_kevlar_layered", 24)
    :component("ballistic_vest_esapi", 1)
    :requirement("sewing_standard", 100)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "armor_chitin_vest",
    result = "armor_chitin_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 35)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "xs_armor_chitin_vest",
    result = "xs_armor_chitin_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2070000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 26)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "xl_armor_chitin_vest",
    result = "xl_armor_chitin_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3678000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 45)
    :requirement("tailoring_leather_patchwork", 4)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "cheongsam",
    result = "cheongsam",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 7)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
)

content.add(content.Recipe {
    id = "armor_pipe_vest",
    result = "armor_pipe_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 21)
    :quality("CUT", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("rope_natural", 3)
)

content.add(content.Recipe {
    id = "makeshift_metal_plate_vest",
    result = "makeshift_metal_plate_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("jeans", 2)
    :component("sheet_metal_small", 10)
    :quality("SEW", 2, 1)
    :requirement("filament", 100)
)

content.add(content.Recipe {
    id = "crude_plastic_vest",
    result = "crude_plastic_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("trashcan_large", 1)
    :quality("CUT", 2, 1)
    :requirement("cordage", 8)
    :byproduct("plastic_chunk", 266)
)
