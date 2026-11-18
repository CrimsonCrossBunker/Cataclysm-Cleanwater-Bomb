local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "duster_faux_fur",
    result = "duster_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 60)
    :requirement("fabric_standard_nostretch", 25)
    :requirement("fabric_fauxfur", 20)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 7)
)

content.add(content.Recipe {
    id = "xs_duster_faux_fur",
    result = "xs_duster_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 45)
    :requirement("fabric_standard_nostretch", 18)
    :requirement("fabric_fauxfur", 15)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 7)
)

content.add(content.Recipe {
    id = "xl_duster_faux_fur",
    result = "xl_duster_faux_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4050000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 80)
    :requirement("fabric_standard_nostretch", 25)
    :requirement("fabric_fauxfur", 30)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 7)
)

content.add(content.Recipe {
    id = "lsurvivor_armor",
    result = "lsurvivor_armor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1890000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("combat_shirt", 1)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 1 },
            { id = "fanny", count = 1 }
        })
    :component("kevlar", 1)
    :component("filament_durable", 30, true)
    :quality("FABRIC_CUT", 2, 1)
    :requirement("tailoring_kevlar_fabric", 30)
    :requirement("armor_kevlar_layered", 2)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_lsurvivor_armor",
    result = "xl_lsurvivor_armor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("combat_shirt", 2)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 1 },
            { id = "fanny", count = 1 }
        })
    :component("kevlar", 1)
    :component("filament_durable", 60, true)
    :quality("FABRIC_CUT", 2, 1)
    :requirement("tailoring_kevlar_fabric", 50)
    :requirement("armor_kevlar_layered", 4)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xs_lsurvivor_armor",
    result = "xs_lsurvivor_armor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1470000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("combat_shirt", 1)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 1 },
            { id = "fanny", count = 1 }
        })
    :component("kevlar", 1)
    :component("filament_durable", 27, true)
    :quality("FABRIC_CUT", 2, 1)
    :requirement("tailoring_kevlar_fabric", 24)
    :requirement("armor_kevlar_layered", 2)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)
