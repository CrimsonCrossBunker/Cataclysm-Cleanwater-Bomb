local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_sealab_small_0",
    result = "faction_base_sealab_small_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the base site and set up a bulletin board."),
}
    :camp_blueprint {
        update = "fbmc_sealab_small_0",
        name = content.text("basic survey"),
        provides = {
            { id = "fbmc_sealab_small_0" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "saltworks_recipes_1" },
            { id = "fishing_recipes" },
            { id = "kitchen" },
            { id = "tool_storage" },
            { id = "sorting" },
            { id = "pantry" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "air_compressor_tool", "water_purifier" },
        check_needs = false,
    }
)
