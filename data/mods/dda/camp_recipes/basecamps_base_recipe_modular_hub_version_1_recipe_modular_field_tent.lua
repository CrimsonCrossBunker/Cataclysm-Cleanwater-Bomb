local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_northeast",
    result = "faction_base_modular_hub_tent_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We need some shelter, so set up a tent on the northeast side of the camp."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_northeast",
        name = content.text("northeast tent"),
        provides = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_tent_northeast" },
        },
        requires = {
            { id = "fbmh_0" },
        },
        excludes = {
            { id = "fbmh_northeast" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_east",
    result = "faction_base_modular_hub_tent_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should expand our housing by putting up a tent on the east side, though doing so will mean we need more materials to build the central building."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_east",
        name = content.text("east tent"),
        provides = {
            { id = "fbmh_east", amount = 4 },
            { id = "fbmh_tent_east" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbmh_east" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_southeast",
    result = "faction_base_modular_hub_tent_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should expand our housing by putting up a tent on the southeast side, though doing so will mean we need more materials to build the central building."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_southeast",
        name = content.text("southeast tent"),
        provides = {
            { id = "fbmh_southeast", amount = 4 },
            { id = "fbmh_tent_southeast" },
        },
        requires = {
            { id = "fbmh_east", amount = 4 },
        },
        excludes = {
            { id = "fbmh_southeast" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_northwest",
    result = "faction_base_modular_hub_tent_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should expand our housing by putting up a tent on the northwest side, though doing so will mean we need more materials to build the central building."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_northwest",
        name = content.text("northwest tent"),
        provides = {
            { id = "fbmh_northwest", amount = 4 },
            { id = "fbmh_tent_northwest" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbmh_northwest" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_west",
    result = "faction_base_modular_hub_tent_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should expand our housing by putting up a tent on the west side, though doing so will mean we need more materials to build the central building."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_west",
        name = content.text("west tent"),
        provides = {
            { id = "fbmh_west", amount = 4 },
            { id = "fbmh_tent_west" },
        },
        requires = {
            { id = "fbmh_northwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_west" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_tent_southwest",
    result = "faction_base_modular_hub_tent_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should expand our housing by putting up a tent on the southwest side, though doing so will mean we need more materials to build the central building."),
}
    :component("large_tent_equivalent", 1, true)
    :camp_blueprint {
        update = "fbmh_tent_southwest",
        name = content.text("southwest tent"),
        provides = {
            { id = "fbmh_southwest", amount = 4 },
            { id = "fbmh_tent_southwest" },
        },
        requires = {
            { id = "fbmh_west", amount = 4 },
        },
        excludes = {
            { id = "fbmh_southwest" },
        },
        check_needs = false,
    }
)
