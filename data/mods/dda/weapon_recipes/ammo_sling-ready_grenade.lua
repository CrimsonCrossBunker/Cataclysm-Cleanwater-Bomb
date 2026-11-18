local content = require("ccb").content

local NO_EXERCISE = 1
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "sling-ready_molotov",
    result = "sling-ready_molotov",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("molotov", 1)
    :component("fuse", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling-ready_grenade",
    result = "sling-ready_grenade",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("grenade", 1)
    :component("fuse", 1)
    :quality("DRILL", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling-ready_small_homemade_grenade",
    result = "sling-ready_small_homemade_grenade",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("small_homemade_grenade", 1)
    :component("fuse", 1)
    :quality("DRILL", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling-ready_homemade_grenade",
    result = "sling-ready_homemade_grenade",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("homemade_grenade", 1)
    :component("fuse", 1)
    :quality("DRILL", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling-ready_small_homemade_grenade_2",
    result = "sling-ready_small_homemade_grenade_2",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("military_explosive_small_grenade", 1)
    :component("fuse", 1)
    :quality("DRILL", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling-ready_homemade_grenade_2",
    result = "sling-ready_homemade_grenade_2",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("military_explosive_grenade", 1)
    :component("fuse", 1)
    :quality("DRILL", 1, 1)
    :result_charges(1)
)
