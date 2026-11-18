local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "bastsandals",
    result = "bastsandals",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("filament", 140, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "boots",
    result = "boots",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 18000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 22)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_boots",
    result = "xs_boots",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 18000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 15)
    :requirement("fastener_shoes", 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_boots",
    result = "xl_boots",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4050000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 18000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 30)
    :requirement("fastener_shoes", 3)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "boots_chitin",
    result = "boots_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "xs_boots_chitin",
    result = "xs_boots_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 2)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "xl_boots_chitin",
    result = "xl_boots_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 3)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "boots_acidchitin",
    result = "boots_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 18)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_boots_acidchitin",
    result = "xs_boots_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 13)
    :requirement("strap_small", 3)
    :requirement("clasps", 1)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_boots_acidchitin",
    result = "xl_boots_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 23)
    :requirement("strap_small", 6)
    :requirement("clasps", 2)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "boots_fur",
    result = "boots_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 13)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("tailoring_fur_patchwork", 2)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_boots_fur",
    result = "xs_boots_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 9)
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_fur_patchwork", 3)
    :requirement("fastener_shoes", 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_boots_fur",
    result = "xl_boots_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 16)
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("tailoring_fur_patchwork", 4)
    :requirement("fastener_shoes", 3)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "boots_larmor",
    result = "boots_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("fastener_small", 2)
    :requirement("tailoring_leather_patchwork", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_boots_larmor",
    result = "xs_boots_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("fastener_small", 1)
    :requirement("tailoring_leather_patchwork", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_boots_larmor",
    result = "xl_boots_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("fastener_small", 2)
    :requirement("tailoring_leather_patchwork", 5)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "boots_plate",
    result = "boots_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :requirement("tailoring_leather_small", 16)
    :book("textbook_armwest", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_boots_plate",
    result = "xs_boots_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :requirement("tailoring_leather_small", 12)
    :book("textbook_armwest", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_boots_plate",
    result = "xl_boots_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :requirement("tailoring_leather_small", 20)
    :book("textbook_armwest", 4)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "boots_scrap",
    result = "boots_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 4)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_cobbling")
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_boots_scrap",
    result = "xs_boots_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 2)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_cobbling")
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_boots_scrap",
    result = "xl_boots_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 6)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 2)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_cobbling")
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "boots_survivor",
    result = "boots_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "wax_any", count = 3, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 4 },
            { id = "snapfastener_steel", count = 8 }
        })
    :component_any({
            { id = "sheet_leather", count = 6 },
            { id = "tanned_hide", count = 6 },
            { id = "sheet_leather_patchwork", count = 6 }
        })
    :component("thread_canvas", 50)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("vinylizing_standard", 32)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requires_skill("fabrication", 6)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "boots_xssurvivor",
    result = "boots_xssurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :tool_charges("surface_heat", 18, true)
    :component_any({
            { id = "wax_any", count = 3, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 4 },
            { id = "snapfastener_steel", count = 8 }
        })
    :component_any({
            { id = "sheet_leather", count = 5 },
            { id = "tanned_hide", count = 5 },
            { id = "sheet_leather_patchwork", count = 5 }
        })
    :component("thread_canvas", 45)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("vinylizing_standard", 28)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requires_skill("fabrication", 6)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "boots_survivor_hoof",
    result = "boots_survivor_hoof",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "wax_any", count = 4, requirement = true },
            { id = "any_tallow", count = 20, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 6 },
            { id = "snapfastener_steel", count = 12 }
        })
    :component_any({
            { id = "sheet_leather", count = 8 },
            { id = "tanned_hide", count = 8 },
            { id = "sheet_leather_patchwork", count = 8 }
        })
    :component("thread_canvas", 60)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("vinylizing_standard", 38)
    :requirement("blacksmithing_standard", 10)
    :requirement("hc_steel_standard", 2)
    :requires_skill("fabrication", 7)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "boots_western",
    result = "boots_western",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "boots_winter",
    result = "boots_winter",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_felt_patchwork", 4)
    :requirement("plastic_molding", 4)
    :requirement("waterproofing_plastic_sheets", 2)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "xs_boots_winter",
    result = "xs_boots_winter",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_felt_patchwork", 3)
    :requirement("plastic_molding", 3)
    :requirement("waterproofing_plastic_sheets", 1)
    :requirement("fastener_shoes", 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "xl_boots_winter",
    result = "xl_boots_winter",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_felt_patchwork", 6)
    :requirement("plastic_molding", 5)
    :requirement("waterproofing_plastic_sheets", 2)
    :requirement("fastener_shoes", 3)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "boots_wsurvivor",
    result = "boots_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "wax_any", count = 3, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 4 },
            { id = "snapfastener_steel", count = 8 }
        })
    :component_any({
            { id = "sheet_fur_patchwork", count = 3 },
            { id = "tanned_pelt", count = 3 }
        })
    :component_any({
            { id = "sheet_leather", count = 3 },
            { id = "tanned_hide", count = 3 },
            { id = "sheet_leather_patchwork", count = 3 }
        })
    :component("thread_canvas", 50)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("vinylizing_standard", 32)
    :requirement("blacksmithing_standard", 10)
    :requirement("hc_steel_standard", 2)
    :requires_skill("fabrication", 6)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_boots_wsurvivor",
    result = "xs_boots_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :tool_charges("surface_heat", 18, true)
    :component_any({
            { id = "wax_any", count = 3, requirement = true },
            { id = "any_tallow", count = 15, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 4 },
            { id = "snapfastener_steel", count = 8 }
        })
    :component_any({
            { id = "sheet_fur_patchwork", count = 3 },
            { id = "tanned_pelt", count = 3 }
        })
    :component_any({
            { id = "sheet_leather", count = 3 },
            { id = "tanned_hide", count = 3 },
            { id = "sheet_leather_patchwork", count = 3 }
        })
    :component("thread_canvas", 45)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("fastener_small", 6)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("vinylizing_standard", 28)
    :requirement("blacksmithing_standard", 10)
    :requirement("hc_steel_standard", 2)
    :requires_skill("fabrication", 6)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_boots_wsurvivor",
    result = "xl_boots_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "wax_any", count = 4, requirement = true },
            { id = "any_tallow", count = 20, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 6 },
            { id = "snapfastener_steel", count = 12 }
        })
    :component_any({
            { id = "sheet_fur_patchwork", count = 4 },
            { id = "tanned_pelt", count = 4 }
        })
    :component_any({
            { id = "sheet_leather", count = 4 },
            { id = "tanned_hide", count = 4 },
            { id = "sheet_leather_patchwork", count = 4 }
        })
    :component("thread_canvas", 60)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("vinylizing_standard", 40)
    :requirement("blacksmithing_standard", 15)
    :requirement("hc_steel_standard", 3)
    :requires_skill("fabrication", 6)
    :requires_skill("chemistry", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "boots_xlsurvivor",
    result = "boots_xlsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 16200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "wax_any", count = 4, requirement = true },
            { id = "any_tallow", count = 20, requirement = true }
        })
    :component_any({
            { id = "buckle_steel", count = 6 },
            { id = "snapfastener_steel", count = 12 }
        })
    :component_any({
            { id = "sheet_leather", count = 8 },
            { id = "tanned_hide", count = 8 },
            { id = "sheet_leather_patchwork", count = 8 }
        })
    :component("thread_canvas", 60)
    :quality("OVEN", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("vinylizing_standard", 40)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :requires_skill("fabrication", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "clogs",
    result = "clogs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 2 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "geta",
    result = "geta",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component("strap_small", 2, true)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :book("tailor_japanese", 2)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "tabi_dress",
    result = "tabi_dress",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 2)
    :book("tailor_japanese", 2)
    :byproduct("scrap_cotton", 4)
)

content.add(content.Recipe {
    id = "footrags",
    result = "footrags",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :requirement("tailoring_cotton_patchwork_simple", 2)
)

content.add(content.Recipe {
    id = "footrags_fur",
    result = "footrags_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sheet_fur_patchwork", count = 2 },
            { id = "tanned_pelt", count = 2 }
        })
)

content.add(content.Recipe {
    id = "footrags_faux_fur",
    result = "footrags_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("sheet_faux_fur_patchwork", 2)
    :byproduct("scrap_faux_fur", 6)
)

content.add(content.Recipe {
    id = "footrags_leather",
    result = "footrags_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("sheet_leather_patchwork", 2)
)

content.add(content.Recipe {
    id = "footrags_wool",
    result = "footrags_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("sheet_felt_patchwork", 2)
)

content.add(content.Recipe {
    id = "leathersandals",
    result = "leathersandals",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_leather_patchwork", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "mocassins",
    result = "mocassins",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_leather_patchwork", 1)
    :book("textbook_survival", 0)
    :book("pocket_survival", 0)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "jikatabi",
    result = "jikatabi",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_leather_patchwork", 1)
    :book("tailor_japanese", 0)
    :book("textbook_armeast", 0)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "nomex_socks",
    result = "nomex_socks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 7)
    :book("textbook_fireman", 6)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_polymerworking")
    :byproduct("nomex", 1)
)

content.add(content.Recipe {
    id = "xsnomex_socks",
    result = "xsnomex_socks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 5)
    :book("textbook_fireman", 6)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_polymerworking")
    :byproduct("nomex", 1)
)

content.add(content.Recipe {
    id = "xlnomex_socks",
    result = "xlnomex_socks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 222000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 10)
    :book("textbook_fireman", 6)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "shoes_birchbark",
    result = "shoes_birchbark",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("birchbark", 3)
    :quality("CUT", 2, 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "socks",
    result = "socks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork", 1)
    :byproduct("scrap_cotton", 3)
)

content.add(content.Recipe {
    id = "xssocks",
    result = "xssocks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork", 1)
    :byproduct("scrap_cotton", 1)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "xlsocks",
    result = "xlsocks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 432000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork", 2)
    :byproduct("scrap_cotton", 2)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "socks_bag",
    result = "socks_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    flags = { "BLIND_HARD" },
}
    :component("plastic_shopping_bag", 2)
)

content.add(content.Recipe {
    id = "socks_wool",
    result = "socks_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 40)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xlsocks_wool",
    result = "xlsocks_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 864000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 80)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xssocks_wool",
    result = "xssocks_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 864000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 30)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "socks_ankle",
    result = "socks_ankle",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton", 1)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "stockings",
    result = "stockings",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :byproduct("cotton_patchwork", 3)
)

content.add(content.Recipe {
    id = "straw_sandals",
    result = "straw_sandals",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component_any({
            { id = "straw_pile", count = 4 },
            { id = "birchbark", count = 6 }
        })
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "swim_fins",
    result = "swim_fins",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("adhesive", 2)
    :requirement("strap_small", 2)
    :requirement("plastic_molding", 8)
    :requires_skill("tailor", 2)
    :book("mag_swimming", 3)
    :book("manual_swimming", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "thermal_socks",
    result = "thermal_socks",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "socks", count = 1 },
            { id = "socks_wool", count = 1 }
        })
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 3 }
        })
    :component("cable", 2)
    :requirement("sewing_standard", 6)
    :requirement("soldering_standard", 20)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "lc_chainmail_feet",
    result = "lc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_feet",
    result = "xs_lc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_feet",
    result = "xl_lc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 4)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_feet",
    result = "mc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_feet",
    result = "xs_mc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_feet",
    result = "xl_mc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 4)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_feet",
    result = "hc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_feet",
    result = "xs_hc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_feet",
    result = "xl_hc_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 4)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_feet",
    result = "ch_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_feet",
    result = "xs_ch_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_feet",
    result = "xl_ch_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 4)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_feet",
    result = "qt_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_feet",
    result = "xs_qt_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_feet",
    result = "xl_qt_chainmail_feet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 4)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_cobbling")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "roller_blades",
    result = "roller_blades",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 6480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :component("pipe", 1)
    :component("wheel_skate", 6)
    :component("scrap", 10)
    :component("bearing", 6)
    :requirement("blacksmithing_standard", 6)
    :requirement("plastic_molding", 8)
    :requirement("fastener_small", 1)
    :requires_skill("tailor", 2)
    :book("textbook_tailor", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_plasticworking")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "rollerskates",
    result = "rollerskates",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :component("wheel_skate", 8)
    :component("boots", 1)
    :component("pipe", 1)
    :component("scrap", 12)
    :component("bearing", 8)
    :requirement("blacksmithing_standard", 6)
    :book("textbook_tailor", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_cobbling")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "boots_combat",
    result = "boots_combat",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_small", 11)
    :requirement("tailoring_kevlar_fabric", 15)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("sewing_aramids", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "motorbike_boots",
    result = "motorbike_boots",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_cotton_patchwork", 27)
    :requirement("tailoring_kevlar_fabric", 36)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("sewing_aramids", 5)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_polymerworking")
    :byproduct("cotton_patchwork", 4)
    :byproduct("scrap_cotton", 3)
    :byproduct("scrap_kevlar", 14)
)

content.add(content.Recipe {
    id = "motor_police_boots",
    result = "motor_police_boots",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_leather_small", 36)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "boots_bunker",
    result = "boots_bunker",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 7,
}
    :component("thread_nomex", 10)
    :component("chunk_rubber", 10)
    :requirement("tailoring_nomex_patchwork", 43)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
    :proficiency("prof_polymerworking")
    :byproduct("nomex", 3)
)

content.add(content.Recipe {
    id = "sneakers",
    result = "sneakers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 6)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("tailoring_cotton_patchwork", 16)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "lc_sabaton",
    result = "lc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("armor_lc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_lc_sabaton",
    result = "xl_lc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("armor_lc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "sabaton_metal_sheets",
    result = "sabaton_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal_small", 4)
    :component("cordage_6_leather", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "ch_sabaton_metal_sheets",
    result = "ch_sabaton_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("sabaton_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "mc_sabaton",
    result = "mc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_mc_sabaton",
    result = "xl_mc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "hc_sabaton",
    result = "hc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 13320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :requirement("armor_hc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_sabaton",
    result = "xl_hc_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "ch_sabaton",
    result = "ch_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 13320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("armor_lc_chainmail_assembling", 1)
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
    id = "xl_ch_sabaton",
    result = "xl_ch_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("armor_lc_chainmail_assembling", 2)
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
    id = "qt_sabaton",
    result = "qt_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_sabaton",
    result = "xl_qt_sabaton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 16920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "espadrilles",
    result = "espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("filament", 900, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "espadrilles_from_rope",
    result = "espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("rope_natural_short", 1, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1)
    :proficiency("prof_basketweaving")
    :byproduct("string_36", 3)
)

content.add(content.Recipe {
    id = "xl_espadrilles",
    result = "xl_espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("filament", 1200, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1.5)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "xl_espadrilles_from_rope",
    result = "xl_espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("rope_natural_short", 1, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1.5)
    :proficiency("prof_basketweaving")
    :byproduct("string_36", 2)
)

content.add(content.Recipe {
    id = "xs_espadrilles",
    result = "xs_espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("filament", 600, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "xs_espadrilles_from_rope",
    result = "xs_espadrilles",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("rope_natural_short", 1, true)
    :quality("CUT", 2, 1)
    :requirement("tailoring_cotton", 1)
    :proficiency("prof_basketweaving")
    :byproduct("string_36", 4)
)
