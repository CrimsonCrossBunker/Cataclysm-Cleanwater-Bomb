local content = require("ccb").content

local MODERATE_EXERCISE = 4

-- Powder load for round shot was roughly 1/4 to 1/3 the weight of the cannonball
content.add(content.Recipe {
    id = "cannon_shot",
    result = "cannon_shot",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cannonball_4lb", 1)
    :component("cotton_patchwork", 1)
    :component("chem_black_powder", 3000)
    :component("fuse", 1)
    :quality("CUT", 2, 1)
    :requires_skill("gun", 1)
    :batch_discount(60, 5)
    :result_charges(1)
)
