local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "armor_faux_farmor",
    result = "armor_faux_farmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_faux_fur_patchwork", 14)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 2)
    :byproduct("scrap_faux_fur", 6)
)

content.add(content.Recipe {
    id = "armor_faux_farmor_xs",
    result = "armor_faux_farmor_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_faux_fur_patchwork", 11)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 5)
    :byproduct("scrap_faux_fur", 5)
)

content.add(content.Recipe {
    id = "xl_armor_faux_farmor",
    result = "xl_armor_faux_farmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_faux_fur_patchwork", 16)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
)

content.add(content.Recipe {
    id = "wetsuit",
    result = "wetsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 33)
    :requirement("tailoring_nylon_patchwork", 55)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit",
    result = "xs_wetsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 25)
    :requirement("tailoring_nylon_patchwork", 40)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit",
    result = "xl_wetsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 45)
    :requirement("tailoring_nylon_patchwork", 75)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "wetsuit_thick",
    result = "wetsuit_thick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 55)
    :requirement("tailoring_nylon_patchwork", 110)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit_thick",
    result = "xs_wetsuit_thick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 42)
    :requirement("tailoring_nylon_patchwork", 85)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit_thick",
    result = "xl_wetsuit_thick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_neoprene_patchwork", 75)
    :requirement("tailoring_nylon_patchwork", 160)
    :requirement("fastener_small", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)
