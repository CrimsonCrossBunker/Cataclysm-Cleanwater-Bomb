local content = require("ccb").content

local MODERATE_EXERCISE = 4

-- The ability to create saltworks was removed 2025-06-13 on account of being magic.
-- The ability to use it once created in an old save remains, but should be removed eventually
content.add(content.Recipe {
    id = "faction_base_modular_brewery1_southwest",
    result = "faction_base_modular_brewery1_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could upgrade the workspace in the brewery to add a still, wood stove and work table."),
}
    :camp_blueprint {
        update = "fbmsw_brewery1_southwest",
        name = content.text("SW brewery still"),
        provides = {
            { id = "fbmsw_southwest1_still" },
        },
        requires = {
            { id = "fbmsw_southwest" },
            { id = "saltworks_recipes_2" },
        },
        excludes = {
            { id = "fbmsw_southwest1_still" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_brewery2_southwest",
    result = "faction_base_modular_brewery2_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use fill out the space with extra kegs and storage racks."),
}
    :camp_blueprint {
        update = "fbmsw_brewery2_southwest",
        name = content.text("SW brewery kegs"),
        provides = {
            { id = "fbmsw_southwest2_kegs" },
            { id = "saltworks_recipes_3" },
        },
        requires = {
            { id = "fbmsw_southwest1_still" },
        },
        excludes = {
            { id = "fbmsw_southwest2_kegs" },
        },
    }
)
