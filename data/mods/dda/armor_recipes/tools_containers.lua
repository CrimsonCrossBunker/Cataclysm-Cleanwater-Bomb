local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "dry_bag_large",
    result = "dry_bag_large",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("duct_tape", 400)
    :requirement("sewing_standard", 100)
    :requirement("tailoring_lycra_patchwork", 10)
    :requirement("clasps", 1)
    :requirement("waterproofing_plastic_sheets", 40)
    :requires_skill("fabrication", 2)
    :book("plastics_book", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :byproduct("scrap_lycra", 16)
)
