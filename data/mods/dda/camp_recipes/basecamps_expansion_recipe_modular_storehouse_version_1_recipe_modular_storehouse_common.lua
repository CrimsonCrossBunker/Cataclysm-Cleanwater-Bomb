local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_storehouse_0",
    result = "faction_base_storehouse_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a storehouse area."),
}
    :camp_blueprint {
        update = "faction_base_storehouse_0",
        name = content.text("Storehouse survey"),
        provides = {
            { id = "fbms_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_furniture1_west",
    result = "faction_base_modular_furniture1_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use some storage containers.  Let's build some bookcases to in the western alcove."),
}
    :camp_blueprint {
        update = "fbms_furniture1_west",
        name = content.text("bookcases, west"),
        provides = {
            { id = "fbms_west" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_west", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_furniture2_east",
    result = "faction_base_modular_furniture2_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use some storage containers.  Let's build some lockers in the eastern alcove."),
}
    :camp_blueprint {
        update = "fbms_furniture2_east",
        name = content.text("lockers, east"),
        provides = {
            { id = "fbms_east" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_east", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_furniture3_center",
    result = "faction_base_modular_furniture3_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use some storage containers.  Let's build some tables."),
}
    :camp_blueprint {
        update = "fbms_furniture3_center",
        name = content.text("tables, center"),
        provides = {
            { id = "fbms_center" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_center", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_decorative1_northwest",
    result = "faction_base_modular_decorative1_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Some benches around the outside would be nice.  Build some to the northwest."),
}
    :camp_blueprint {
        update = "fbms_decorative1_northwest",
        name = content.text("benches, northwest"),
        provides = {
            { id = "fbms_northwest" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_northwest", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_decorative2_northeast",
    result = "faction_base_modular_decorative2_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Some benches around the outside would be nice.  Build some to the northeast."),
}
    :camp_blueprint {
        update = "fbms_decorative2_northeast",
        name = content.text("benches, northeast"),
        provides = {
            { id = "fbms_northeast" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_northeast", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_decorative3_southeast",
    result = "faction_base_modular_decorative3_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Some benches around the outside would be nice.  Build some to the southeast."),
}
    :camp_blueprint {
        update = "fbms_decorative3_southeast",
        name = content.text("benches, southeast"),
        provides = {
            { id = "fbms_southeast" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_southeast", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_decorative4_southwest",
    result = "faction_base_modular_decorative4_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Some benches around the outside would be nice.  Build some to the southwest."),
}
    :camp_blueprint {
        update = "fbms_decorative4_southwest",
        name = content.text("benches, southwest"),
        provides = {
            { id = "fbms_southwest" },
        },
        requires = {
            { id = "fbms_center" },
        },
        excludes = {
            { id = "fbms_southwest", amount = 2 },
        },
    }
)
