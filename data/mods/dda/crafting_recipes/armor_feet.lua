local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "boots_faux_fur",
    result = "boots_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 13)
    :requirement("tailoring_cotton_patchwork", 3)
    :requirement("tailoring_faux_fur_patchwork", 2)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 10)
)

content.add(content.Recipe {
    id = "xs_boots_faux_fur",
    result = "xs_boots_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 9)
    :requirement("tailoring_cotton_patchwork", 2)
    :requirement("tailoring_faux_fur_patchwork", 3)
    :requirement("fastener_shoes", 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 10)
)

content.add(content.Recipe {
    id = "xl_boots_faux_fur",
    result = "xl_boots_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 16)
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("tailoring_faux_fur_patchwork", 4)
    :requirement("fastener_shoes", 3)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 10)
)

content.add(content.Recipe {
    id = "boots_wsurvivor_nofur",
    result = "boots_wsurvivor_nofur",
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
            { id = "sheet_faux_fur_patchwork", count = 3 },
            { id = "sheet_faux_fur", count = 3 }
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
    id = "xs_boots_wsurvivor_nofur",
    result = "xs_boots_wsurvivor_nofur",
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
            { id = "sheet_faux_fur_patchwork", count = 3 },
            { id = "sheet_faux_fur", count = 3 }
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
    id = "xl_boots_wsurvivor_nofur",
    result = "xl_boots_wsurvivor_nofur",
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
            { id = "sheet_faux_fur_patchwork", count = 4 },
            { id = "sheet_faux_fur", count = 4 }
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
    id = "wetsuit_booties",
    result = "wetsuit_booties",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_neoprene_patchwork", 7)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("tailoring_nylon_patchwork", 10)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "xs_wetsuit_booties",
    result = "xs_wetsuit_booties",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_neoprene_patchwork", 6)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("tailoring_nylon_patchwork", 8)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "xl_wetsuit_booties",
    result = "xl_wetsuit_booties",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_neoprene_patchwork", 9)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("tailoring_nylon_patchwork", 15)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "wetsuit_booties_thick",
    result = "wetsuit_booties_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_neoprene_patchwork", 12)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("tailoring_nylon_patchwork", 20)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "xs_wetsuit_booties_thick",
    result = "xs_wetsuit_booties_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_neoprene_patchwork", 10)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requirement("tailoring_nylon_patchwork", 16)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)

content.add(content.Recipe {
    id = "xl_wetsuit_booties_thick",
    result = "xl_wetsuit_booties_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_neoprene_patchwork", 16)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requirement("tailoring_nylon_patchwork", 30)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_elastics")
    :proficiency("prof_cobbling")
)
