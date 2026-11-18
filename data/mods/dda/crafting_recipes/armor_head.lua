local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "hood_wsurvivor_nofur",
    result = "hood_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_faux_fur_patchwork", 2)
    :requirement("vinylizing_standard", 22)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_hood_wsurvivor_nofur",
    result = "xs_hood_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_faux_fur_patchwork", 2)
    :requirement("vinylizing_standard", 18)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_hood_wsurvivor_nofur",
    result = "xl_hood_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("tailoring_faux_fur_patchwork", 3)
    :requirement("vinylizing_standard", 30)
    :requires_skill("fabrication", 5)
    :proficiency("prof_millinery")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "wetsuit_hood",
    result = "wetsuit_hood",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 10)
    :requirement("tailoring_neoprene_patchwork", 6)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit_hood",
    result = "xl_wetsuit_hood",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 15)
    :requirement("tailoring_neoprene_patchwork", 9)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit_hood",
    result = "xs_wetsuit_hood",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 8)
    :requirement("tailoring_neoprene_patchwork", 5)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "wetsuit_hood_thick",
    result = "wetsuit_hood_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 20)
    :requirement("tailoring_neoprene_patchwork", 12)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit_hood_thick",
    result = "xl_wetsuit_hood_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 30)
    :requirement("tailoring_neoprene_patchwork", 18)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit_hood_thick",
    result = "xs_wetsuit_hood_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 16)
    :requirement("tailoring_neoprene_patchwork", 10)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)
