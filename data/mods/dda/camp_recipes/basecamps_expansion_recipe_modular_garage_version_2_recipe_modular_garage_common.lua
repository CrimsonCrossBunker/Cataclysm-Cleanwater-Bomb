local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_garage_2_0",
    result = "faction_base_garage_2_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Survey land for a garage."),
}
    :camp_blueprint {
        update = "faction_base_garage_2_0",
        name = content.text("garage survey"),
        provides = {
            { id = "fbmg_2" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_3",
    result = "fbmg_2_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's connect the two walls with the missing roof piece."),
}
    :camp_blueprint {
        update = "fbmg_2_3",
        name = content.text("build the missing roof section"),
        provides = {
            { id = "fbmg_2_3" },
        },
        requires = {
            { id = "fbmg_2_2" },
        },
        excludes = {
            { id = "fbmg_2_3" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_furniture",
    result = "fbmg_2_furniture",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Now that we have some cover, let's build some counters and racks for tools and parts, allowing us to use the Chop Shop."),
}
    :camp_blueprint {
        update = "fbmg_2_furniture",
        name = content.text("build some furniture"),
        provides = {
            { id = "fbmg_2_furniture" },
            { id = "dismantling" },
        },
        requires = {
            { id = "fbmg_2_1" },
        },
        excludes = {
            { id = "fbmg_2_furniture" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_6",
    result = "fbmg_2_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's connect the two walls with the missing roof piece."),
}
    :camp_blueprint {
        update = "fbmg_2_6",
        name = content.text("build the missing roof section"),
        provides = {
            { id = "fbmg_2_6" },
        },
        requires = {
            { id = "fbmg_2_5" },
        },
        excludes = {
            { id = "fbmg_2_6" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_gate_2",
    result = "fbmg_2_gate_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("The garage is big enough.  Let's build a palisade gate to allow us to close off the outer end."),
}
    :camp_blueprint {
        update = "fbmg_2_gate_2",
        name = content.text("build an outer palisade gate"),
        provides = {
            { id = "fbmg_2_gate_2" },
        },
        requires = {
            { id = "fbmg_2_6" },
        },
        excludes = {
            { id = "fbmg_2_gate_2" },
            { id = "fbmg_2_7" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_9",
    result = "fbmg_2_9",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's connect the two walls with the missing roof piece."),
}
    :camp_blueprint {
        update = "fbmg_2_9",
        name = content.text("build the missing roof section"),
        provides = {
            { id = "fbmg_2_9" },
        },
        requires = {
            { id = "fbmg_2_8" },
        },
        excludes = {
            { id = "fbmg_2_9" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_gate_3",
    result = "fbmg_2_gate_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("The garage is big enough.  Let's build a palisade gate to allow us to close off the outer end."),
}
    :camp_blueprint {
        update = "fbmg_2_gate_3",
        name = content.text("build an outer palisade gate"),
        provides = {
            { id = "fbmg_2_gate_3" },
        },
        requires = {
            { id = "fbmg_2_9" },
        },
        excludes = {
            { id = "fbmg_2_gate_3" },
            { id = "fbmg_2_10" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_12",
    result = "fbmg_2_12",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's connect the two walls with the missing roof piece."),
}
    :camp_blueprint {
        update = "fbmg_2_12",
        name = content.text("build the missing roof section"),
        provides = {
            { id = "fbmg_2_12" },
        },
        requires = {
            { id = "fbmg_2_11" },
        },
        excludes = {
            { id = "fbmg_2_12" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_gate_4",
    result = "fbmg_2_gate_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's finish the garage by building a palisade gate to allow us to close off the outer end."),
}
    :camp_blueprint {
        update = "fbmg_2_gate_4",
        name = content.text("build an outer palisade gate"),
        provides = {
            { id = "fbmg_2_gate_4" },
        },
        requires = {
            { id = "fbmg_2_12" },
        },
        excludes = {
            { id = "fbmg_2_gate_4" },
        },
    }
)
