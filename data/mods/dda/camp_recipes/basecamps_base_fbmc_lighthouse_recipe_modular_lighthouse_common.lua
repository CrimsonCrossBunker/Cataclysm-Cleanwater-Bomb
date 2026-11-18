local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_lighthouse_0",
    result = "faction_base_lighthouse_0",
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
        update = "fbmc_lighthouse_0",
        name = content.text("basic survey"),
        provides = {
            { id = "tool_storage" },
            { id = "sorting" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen_recipes_3" },
            { id = "saltworks_recipes_1" },
            { id = "fishing_recipes" },
            { id = "fbmc_lighthouse_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "fake_woodstove", "water_purifier", "oven" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_lighthouse_root_cellar",
    result = "faction_base_lighthouse_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will allow us to preserve fish and other foods."),
}
    :camp_blueprint {
        update = "fbmc_lighthouse_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "fbmc_lighthouse_root_cellar" },
            { id = "pantry" },
        },
        requires = {
            { id = "fbmc_lighthouse_0" },
        },
        excludes = {
            { id = "fbmc_lighthouse_root_cellar" },
        },
    }
)
