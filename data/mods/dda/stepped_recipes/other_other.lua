local content = require("ccb").content

local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "firewood",
    result = "firewood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 10,
}
    :component("log", 1)
    :byproduct("splinter", 5)
    :step {
        name = content.text("Chopping the wood"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "AXE", level = 1, count = 1 } },
        },
    }
)
