local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_helipad_garage_0",
    result = "faction_base_helipad_garage_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey military helipad garage."),
}
    :camp_blueprint {
        update = "faction_base_helipad_garage_0",
        name = content.text("military helipad garage survey"),
        provides = {
            { id = "fbmc_helipad_garage_0" },
            { id = "tool_storage" },
            { id = "dismantling" },
            { id = "blacksmith" },
            { id = "power_saw_recipes" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "planer_tool", "drill_press_tool" },
        check_needs = false,
    }
)
