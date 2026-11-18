local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmg_2_1_construction",
    result = "fbmg_2_1_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's start building the first garage wall section."),
}
    :camp_blueprint {
        update = "fbmg_2_1_construction",
        name = content.text("build the first garage section"),
        provides = {
            { id = "fbmg_2_1" },
        },
        requires = {
            { id = "fbmg_2" },
        },
        excludes = {
            { id = "fbmg_2_1" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_2_construction",
    result = "fbmg_2_2_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a second garage wall section to block the wind from the other direction, making a garage wide enough to handle two normal vehicles or one super sized one."),
}
    :camp_blueprint {
        update = "fbmg_2_2_construction",
        name = content.text("build the second garage section"),
        provides = {
            { id = "fbmg_2_2" },
        },
        requires = {
            { id = "fbmg_2_1" },
        },
        excludes = {
            { id = "fbmg_2_2" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_wall_construction",
    result = "fbmg_2_wall_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a wall to block the wind from blowing straight through the garage."),
}
    :camp_blueprint {
        update = "fbmg_2_wall_construction",
        name = content.text("build an inner wall"),
        provides = {
            { id = "fbmg_2_wall" },
        },
        requires = {
            { id = "fbmg_2_3" },
        },
        excludes = {
            { id = "fbmg_2_wall" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_4_construction",
    result = "fbmg_2_4_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Now that we're able to work on short vehicles, let's extend the garage to allow for long ones."),
}
    :camp_blueprint {
        update = "fbmg_2_4_construction",
        name = content.text("extend the first wall"),
        provides = {
            { id = "fbmg_2_4" },
        },
        requires = {
            { id = "fbmg_2_3" },
        },
        excludes = {
            { id = "fbmg_2_4" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_5_construction",
    result = "fbmg_2_5_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend the second wall to match the first one."),
}
    :camp_blueprint {
        update = "fbmg_2_5_construction",
        name = content.text("extend the second wall"),
        provides = {
            { id = "fbmg_2_5" },
        },
        requires = {
            { id = "fbmg_2_4" },
        },
        excludes = {
            { id = "fbmg_2_5" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_7_construction",
    result = "fbmg_2_7_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Now that we're able to work on long vehicles, let's extend the garage to allow for really long ones, or multiple vehicles."),
}
    :camp_blueprint {
        update = "fbmg_2_7_construction",
        name = content.text("extend the first wall"),
        provides = {
            { id = "fbmg_2_7" },
        },
        requires = {
            { id = "fbmg_2_6" },
        },
        excludes = {
            { id = "fbmg_2_7" },
            { id = "fbmg_2_gate_2" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_8_construction",
    result = "fbmg_2_8_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend the second wall to match the first one."),
}
    :camp_blueprint {
        update = "fbmg_2_8_construction",
        name = content.text("extend the second wall"),
        provides = {
            { id = "fbmg_2_8" },
        },
        requires = {
            { id = "fbmg_2_7" },
        },
        excludes = {
            { id = "fbmg_2_8" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_10_construction",
    result = "fbmg_2_10_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extent the garage to hangar size, allowing us to work on monster vehicles or a large number of normal ones."),
}
    :camp_blueprint {
        update = "fbmg_2_10_construction",
        name = content.text("extend the first wall"),
        provides = {
            { id = "fbmg_2_10" },
        },
        requires = {
            { id = "fbmg_2_9" },
        },
        excludes = {
            { id = "fbmg_2_10" },
            { id = "fbmg_2_gate_3" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmg_2_11_construction",
    result = "fbmg_2_11_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend the second wall to match the first one."),
}
    :camp_blueprint {
        update = "fbmg_2_11_construction",
        name = content.text("extend the second wall"),
        provides = {
            { id = "fbmg_2_11" },
        },
        requires = {
            { id = "fbmg_2_10" },
        },
        excludes = {
            { id = "fbmg_2_11" },
        },
        parameter_labels = {
            ["fbmg_2_construction_palette"] = {
                ["fbmg_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmg_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmg_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmg_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmg_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmg_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmg_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmg_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmg_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
