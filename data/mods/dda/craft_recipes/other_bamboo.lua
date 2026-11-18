local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "bamboo_stalk_dry",
    result = "bamboo_stalk_dry",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component("bamboo_stalk", 1)
)
