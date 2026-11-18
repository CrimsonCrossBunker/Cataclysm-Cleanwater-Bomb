local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_pottery_cottage_0",
    result = "faction_base_pottery_cottage_0",
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
        update = "fbmc_pottery_cottage_0",
        name = content.text("basic survey"),
        provides = {
            { id = "tool_storage" },
            { id = "pantry" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "sorting" },
            { id = "logging" },
            { id = "foraging" },
            { id = "trapping" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen_recipes_3" },
            { id = "saltworks_recipes_1" },
            { id = "saltworks_recipes_2" },
            { id = "saltworks_recipes_3" },
            { id = "primitive_camp_recipes_1" },
            { id = "clay_recipes_1" },
            { id = "fishing_recipes" },
            { id = "fbmc_pottery_cottage_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "oven", "fake_woodstove", "fake_char_kiln", "fake_clay_kiln" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_pottery_cottage_butchery_rack",
    result = "faction_base_pottery_cottage_butchery_rack",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a butchery rack, so we can start hunting large animals."),
}
    :camp_blueprint {
        update = "fbmc_pottery_cottage_butchery_rack",
        name = content.text("butchery rack"),
        provides = {
            { id = "hunting" },
            { id = "fbmc_pottery_cottage_butchery_rack" },
        },
        requires = {
            { id = "fbmc_pottery_cottage_0" },
        },
        excludes = {
            { id = "fbmc_pottery_cottage_butchery_rack" },
        },
    }
)
