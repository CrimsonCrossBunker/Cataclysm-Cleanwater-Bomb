local content = require("ccb").content

local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "adobe_pallet_full_active_obsolete",
    result = "adobe_pallet_full_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    name = content.text("%s with obsolete ingredient"),
}
    :component("soft_adobe_brick", 20)
    :component("frame_wood_light", 1)
    :requires_skill("survival", 1)
)
