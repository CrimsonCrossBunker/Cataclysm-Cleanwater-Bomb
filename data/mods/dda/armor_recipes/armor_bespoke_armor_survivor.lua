local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "lsurvivor_jumpsuit",
    result = "lsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "sheet_felt", count = 80 },
            { id = "sheet_felt_patchwork", count = 80 }
        })
    :component_any({
            { id = "sheet_nomex", count = 40 },
            { id = "sheet_nomex_patchwork", count = 40 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 200)
    :component("thread_nomex", 200)
    :component("thread", 300)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :proficiency("prof_polymerworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_lsurvivor_jumpsuit",
    result = "xs_lsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 17280000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "sheet_felt", count = 64 },
            { id = "sheet_felt_patchwork", count = 64 }
        })
    :component_any({
            { id = "sheet_nomex", count = 32 },
            { id = "sheet_nomex_patchwork", count = 32 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 160)
    :component("thread_nomex", 160)
    :component("thread", 240)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :proficiency("prof_polymerworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_lsurvivor_jumpsuit",
    result = "xl_lsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "sheet_felt", count = 110 },
            { id = "sheet_felt_patchwork", count = 110 }
        })
    :component_any({
            { id = "sheet_nomex", count = 55 },
            { id = "sheet_nomex_patchwork", count = 55 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 280)
    :component("thread_nomex", 280)
    :component("thread", 400)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 2)
    :component("snapfastener_steel", 10)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :proficiency("prof_polymerworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "survivor_jumpsuit",
    result = "survivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 27000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_kevlar", count = 190 },
            { id = "sheet_kevlar_patchwork", count = 190 }
        })
    :component_any({
            { id = "sheet_nylon", count = 60 },
            { id = "sheet_nomex_patchwork", count = 60 }
        })
    :component("thread_kevlar", 1200)
    :component("thread_canvas", 300)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xssurvivor_jumpsuit",
    result = "xssurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_kevlar", count = 170 },
            { id = "sheet_kevlar_patchwork", count = 170 }
        })
    :component_any({
            { id = "sheet_nylon", count = 55 },
            { id = "sheet_nomex_patchwork", count = 55 }
        })
    :component("thread_kevlar", 1000)
    :component("thread_canvas", 250)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xlsurvivor_jumpsuit",
    result = "xlsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 32400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_kevlar", count = 240 },
            { id = "sheet_kevlar_patchwork", count = 240 }
        })
    :component_any({
            { id = "sheet_nylon", count = 75 },
            { id = "sheet_nomex_patchwork", count = 75 }
        })
    :component("thread_kevlar", 1450)
    :component("thread_canvas", 400)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 2)
    :component("snapfastener_steel", 10)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "hsurvivor_jumpsuit",
    result = "hsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "sheet_kevlar", count = 190 },
            { id = "sheet_kevlar_patchwork", count = 190 }
        })
    :component_any({
            { id = "sheet_canvas", count = 60 },
            { id = "sheet_canvas_patchwork", count = 60 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_kevlar", 1200)
    :component("thread_canvas", 300)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("fastener_small", 5)
    :requires_skill("chemistry", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_hsurvivor_jumpsuit",
    result = "xs_hsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_kevlar", count = 170 },
            { id = "sheet_kevlar_patchwork", count = 170 }
        })
    :component_any({
            { id = "sheet_canvas", count = 55 },
            { id = "sheet_canvas_patchwork", count = 55 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_kevlar", 1000)
    :component("thread_canvas", 250)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("vinylizing_standard", 220)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_hsurvivor_jumpsuit",
    result = "xl_hsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_kevlar", count = 240 },
            { id = "sheet_kevlar_patchwork", count = 240 }
        })
    :component_any({
            { id = "sheet_canvas", count = 75 },
            { id = "sheet_canvas_patchwork", count = 75 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_kevlar", 1450)
    :component("thread_canvas", 400)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 2)
    :component("snapfastener_steel", 10)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("vinylizing_standard", 300)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_polymerworking")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "wsurvivor_jumpsuit",
    result = "wsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 170 },
            { id = "sheet_cotton_patchwork", count = 170 }
        })
    :component_any({
            { id = "sheet_canvas", count = 20 },
            { id = "sheet_canvas_patchwork", count = 20 }
        })
    :component_any({
            { id = "tanned_pelt", count = 20 },
            { id = "sheet_fur_patchwork", count = 20 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 300)
    :component("thread", 750)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_wsurvivor_jumpsuit",
    result = "xs_wsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 130 },
            { id = "sheet_cotton_patchwork", count = 130 }
        })
    :component_any({
            { id = "sheet_canvas", count = 16 },
            { id = "sheet_canvas_patchwork", count = 16 }
        })
    :component_any({
            { id = "tanned_pelt", count = 16 },
            { id = "sheet_fur_patchwork", count = 16 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 250)
    :component("thread", 500)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_wsurvivor_jumpsuit",
    result = "xl_wsurvivor_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 220 },
            { id = "sheet_cotton_patchwork", count = 220 }
        })
    :component_any({
            { id = "sheet_canvas", count = 25 },
            { id = "sheet_canvas_patchwork", count = 25 }
        })
    :component_any({
            { id = "tanned_pelt", count = 25 },
            { id = "sheet_fur_patchwork", count = 25 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 400)
    :component("thread", 1000)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 2)
    :component("snapfastener_steel", 10)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "survivor_rig",
    result = "survivor_rig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("nylon", 10)
    :component("duct_tape", 200)
    :component_any({
            { id = "legrig", count = 1 },
            { id = "ragpouch", count = 6 },
            { id = "leather_pouch", count = 4 },
            { id = "dump_pouch", count = 2 }
        })
    :component_any({
            { id = "purse", count = 2 },
            { id = "fanny", count = 2 },
            { id = "mbag", count = 2 }
        })
    :requirement("sewing_standard", 100)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_shirt",
    result = "survivor_adhoc_leather_shirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "trenchcoat_leather", count = 1 },
            { id = "duster_leather", count = 1 },
            { id = "jacket_leather", count = 1 },
            { id = "leather_police_jacket", count = 1 }
        })
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 100)
    :requirement("adhesive", 8)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 28)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_shirt_sheets",
    result = "survivor_adhoc_leather_shirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :requirement("sewing_standard", 150)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("adhesive", 4)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_torso",
    result = "survivor_adhoc_leather_torso",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "trenchcoat_leather", count = 1 },
            { id = "duster_leather", count = 1 },
            { id = "sleeveless_trenchcoat_leather", count = 1 },
            { id = "sleeveless_duster_leather", count = 1 },
            { id = "jacket_leather", count = 1 },
            { id = "leather_police_jacket", count = 1 },
            { id = "vest_leather", count = 1 }
        })
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 60)
    :requirement("adhesive", 5)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("leather", 6)
    :byproduct("scrap_leather", 22)
    :byproduct("cotton_patchwork", 4)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_torso_sheets",
    result = "survivor_adhoc_leather_torso",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :requirement("sewing_standard", 90)
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("adhesive", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 2)
    :byproduct("cotton_patchwork", 4)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_sleeves",
    result = "survivor_adhoc_leather_sleeves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "trenchcoat_leather", count = 1 },
            { id = "duster_leather", count = 1 },
            { id = "jacket_leather", count = 1 },
            { id = "leather_police_jacket", count = 1 }
        })
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 40)
    :requirement("adhesive", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("leather", 15)
    :byproduct("scrap_leather", 18)
    :byproduct("cotton_patchwork", 12)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_sleeves_sheets",
    result = "survivor_adhoc_leather_sleeves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "sweatshirt", count = 1 },
            { id = "hoodie", count = 1 }
        })
    :requirement("sewing_standard", 60)
    :requirement("tailoring_leather_patchwork", 1)
    :requirement("adhesive", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 2)
    :byproduct("cotton_patchwork", 12)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_torso_cutting",
    result = "survivor_adhoc_leather_torso",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("survivor_adhoc_leather_shirt", 1)
    :quality("FABRIC_CUT", 1, 1)
    :byproduct("survivor_adhoc_leather_sleeves", 1)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_pants",
    result = "survivor_adhoc_leather_pants",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 216000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("pants_leather", 1)
    :component("technician_pants_gray", 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 80)
    :requirement("adhesive", 5)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("leather", 4)
    :byproduct("scrap_leather", 14)
)

content.add(content.Recipe {
    id = "survivor_adhoc_leather_pants_sheets",
    result = "survivor_adhoc_leather_pants",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("technician_pants_gray", 1)
    :requirement("sewing_standard", 120)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("adhesive", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 4)
)
