local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_mansion_+1_0",
    result = "faction_base_mansion_+1_0",
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
        update = "fbmc_mansion_+1",
        name = content.text("basic survey"),
        provides = {
            { id = "fbmc_mansion_+1" },
            { id = "primitive_camp_recipes_1" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_+1_garden",
    result = "faction_base_mansion_+1_garden",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's remove plants from garden and plow a few plots."),
}
    :camp_blueprint {
        update = "fbmc_mansion_+1_farm",
        name = content.text("prepare garden"),
        provides = {
            { id = "fbmc_mansion_+1_farm" },
            { id = "farming" },
            { id = "farm_recipes_1" },
        },
        requires = {
            { id = "fbmc_mansion_+1" },
        },
        excludes = {
            { id = "fbmc_mansion_+1_farm" },
        },
        check_needs = false,
        needs = {
            duration_moves = 2520000,
            tools = {
            },
            qualities = {
                { { id = "DIG", level = 1, count = 1 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_+1_radio",
    result = "faction_base_mansion_+1_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_mansion_+1_radio",
        name = content.text("build a radio tower and console"),
        provides = {
            { id = "fbmc_mansion_+1_radio" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_mansion_+1_farm" },
        },
        excludes = {
            { id = "fbmc_mansion_+1_radio" },
        },
    }
)
