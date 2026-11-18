local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_north",
    result = "faction_base_modular_hub_trench_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the north edge of the camp would provide some defense and generate building materials."),
}
    :camp_blueprint {
        update = "fbmh_trench_north",
        name = content.text("north trench"),
        provides = {
            { id = "fbmh_trench_north" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_south",
    result = "faction_base_modular_hub_trench_south",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the south edge of the camp would provide some defense and generate building materials."),
}
    :camp_blueprint {
        update = "fbmh_trench_south",
        name = content.text("south trench"),
        provides = {
            { id = "fbmh_trench_south" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_northeast",
    result = "faction_base_modular_hub_trench_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Digging a trench along the northeast corner of the camp would provide some defense and generate building materials.  If we have solid buildings all along the east side of the camp, we would only need to dig the trench long enough to reach the buildings."),
}
    :camp_blueprint {
        update = "fbmh_trench_corner_northeast",
        name = content.text("northeast trench"),
        provides = {
            { id = "fbmh_trench_northeast" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_northeast" },
            { id = "fbmh_trench_east" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_northwest",
    result = "faction_base_modular_hub_trench_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the northwest corner of the camp would provide some defense and generate building materials.  If we have solid buildings all along the west side of the camp, we would only need to dig the trench long enough to reach the buildings."),
}
    :camp_blueprint {
        update = "fbmh_trench_corner_northwest",
        name = content.text("northwest trench"),
        provides = {
            { id = "fbmh_trench_northwest" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_northwest" },
            { id = "fbmh_trench_west" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_southeast",
    result = "faction_base_modular_hub_trench_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the southeast corner of the camp would provide some defense and generate building materials.  If we have solid buildings all along the east side of the camp, we would only need to dig the trench long enough to reach the buildings."),
}
    :camp_blueprint {
        update = "fbmh_trench_corner_southeast",
        name = content.text("southeast trench"),
        provides = {
            { id = "fbmh_trench_southeast" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_southeast" },
            { id = "fbmh_trench_east" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_southwest",
    result = "faction_base_modular_hub_trench_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the southwest corner of the camp would provide some defense and generate building materials.  If we have solid buildings all along the west side of the camp, we would only need to dig the trench long enough to reach the buildings."),
}
    :camp_blueprint {
        update = "fbmh_trench_corner_southwest",
        name = content.text("southwest trench"),
        provides = {
            { id = "fbmh_trench_southwest" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_southwest" },
            { id = "fbmh_trench_west" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_east",
    result = "faction_base_modular_hub_trench_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the east edge of the camp would provide some defense and generate building materials.  We'll need to run the trench the length of the camp if we don't have solid buildings all along the east side."),
}
    :camp_blueprint {
        update = "fbmh_trench_east",
        name = content.text("east trench"),
        provides = {
            { id = "fbmh_trench_east" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_southeast" },
            { id = "fbmh_trench_northeast" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_trench_west",
    result = "faction_base_modular_hub_trench_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a trench along the west edge of the camp would provide some defense and generate building materials.  We'll need to run the trench the length of the camp if we don't have solid buildings all along the west side."),
}
    :camp_blueprint {
        update = "fbmh_trench_west",
        name = content.text("west trench"),
        provides = {
            { id = "fbmh_trench_west" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbm_no_dig" },
            { id = "fbmh_trench_southwest" },
            { id = "fbmh_trench_northwest" },
        },
    }
)
