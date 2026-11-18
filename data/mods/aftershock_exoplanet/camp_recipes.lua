local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.replace(content.Recipe {
    id = "faction_base_modular_firestation1_workbench",
    result = "faction_base_modular_firestation1_workbench",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's get a nice workbench built to improve our work.  Place it next to the anvil."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_workbench",
        name = content.text("build a workbench"),
        provides = {
            { id = "fbmc_firestation1_workbench" },
            { id = "blacksmith_recipes_5" },
        },
        requires = {
            { id = "fbmc_firestation1_tools" },
        },
        excludes = {
            { id = "fbmc_firestation1_workbench" },
        },
    }
)

content.replace(content.Recipe {
    id = "faction_base_modular_shelter_craftspot",
    result = "faction_base_modular_shelter_craftspot",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a work bench."),
}
    :camp_blueprint {
        update = "fbmc_shelter_craftspot",
        name = content.text("build a work bench"),
        provides = {
            { id = "fbmc_shelter_craftspot" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_craftspot" },
        },
    }
)

content.replace(content.Recipe {
    id = "faction_base_modular_shelter_1_craftspot",
    result = "faction_base_modular_shelter_1_craftspot",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a work bench."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_craftspot",
        name = content.text("build a work bench"),
        provides = {
            { id = "fbmc_shelter_1_craftspot" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_craftspot" },
        },
    }
)
