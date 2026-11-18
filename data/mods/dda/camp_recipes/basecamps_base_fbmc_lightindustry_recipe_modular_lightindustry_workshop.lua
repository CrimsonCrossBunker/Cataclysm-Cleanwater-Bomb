local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_lightindustry_workshop_0",
    result = "faction_base_lightindustry_workshop_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey Light Industry Workshop."),
}
    :camp_blueprint {
        update = "faction_base_lightindustry_workshop_0",
        name = content.text("expansion survey"),
        provides = {
            { id = "dismantling" },
            { id = "blacksmith" },
            { id = "industrial_recipes_power_lathe" },
            { id = "industrial_recipes_drill_press" },
            { id = "industrial_recipes_hydraulic_press" },
            { id = "industrial_recipes_air_compressor" },
            { id = "fbmc_lightindustry_workshop" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "drill_press_tool", "hydraulic_press_tool", "air_compressor_tool", "fake_arc_furnace" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_workshop_drop_hammer",
    result = "faction_base_lightindustry_workshop_drop_hammer",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's add a drop hammer for even more crafting possibilities."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_workshop_drop_hammer",
        provides = {
            { id = "blacksmith_recipes_7" },
            { id = "fbmc_lightindustry_workshop_drop_hammer" },
        },
        requires = {
            { id = "fbmc_lightindustry_workshop" },
        },
    }
)
