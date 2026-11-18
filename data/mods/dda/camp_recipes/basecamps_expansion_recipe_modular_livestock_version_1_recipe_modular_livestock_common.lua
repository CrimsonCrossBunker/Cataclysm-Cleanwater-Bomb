local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_livestock_0",
    result = "faction_base_livestock_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a livestock area."),
}
    :camp_blueprint {
        update = "faction_base_livestock_0",
        name = content.text("Livestock survey"),
        provides = {
            { id = "fbml_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_coop_yard_chickenwire_east",
    result = "faction_base_modular_livestock_coop_yard_chickenwire_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a fence to contain our chickens and other birds, so build a chickenwire fence on the east side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_coop_yard_chickenwire_east",
        name = content.text("east coop yard"),
        provides = {
            { id = "fbml_east" },
        },
        requires = {
            { id = "fbml_northeast" },
        },
        excludes = {
            { id = "fbml_east" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_pasture0_splitrail",
    result = "faction_base_modular_livestock_pasture0_splitrail",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use paddock for the stable, so build a split-rail fence on the north side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_pasture0_splitrail_north",
        name = content.text("north paddock"),
        provides = {
            { id = "fbml_north" },
        },
        requires = {
            { id = "fbml_northwest" },
        },
        excludes = {
            { id = "fbml_north" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_pasture1_splitrail",
    result = "faction_base_modular_livestock_pasture1_splitrail",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use paddock for the stable, so build a split-rail fence in the center of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_pasture1_splitrail_center",
        name = content.text("center paddock"),
        provides = {
            { id = "fbml_center" },
        },
        requires = {
            { id = "fbml_north" },
        },
        excludes = {
            { id = "fbml_center" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_pasture2_splitrail",
    result = "faction_base_modular_livestock_pasture2_splitrail",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use paddock for the stable, so build a split-rail fence to close off the south end of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_pasture2_splitrail_south",
        name = content.text("center paddock"),
        provides = {
            { id = "fbml_south" },
        },
        requires = {
            { id = "fbml_center" },
        },
        excludes = {
            { id = "fbml_south" },
        },
    }
)
