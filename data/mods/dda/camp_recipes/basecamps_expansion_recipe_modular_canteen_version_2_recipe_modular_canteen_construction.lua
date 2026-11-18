local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmk_2_room_1",
    result = "fbmk_2_room_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's start building the kitchen walls."),
}
    :camp_blueprint {
        update = "fbmk_2_1",
        name = content.text("build the kitchen"),
        provides = {
            { id = "fbmk_2_center" },
        },
        requires = {
            { id = "fbmk_2" },
        },
        excludes = {
            { id = "fbmk_2_center" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_room_2_center",
    result = "fbmk_2_room_2_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's finish the kitchen walls."),
}
    :camp_blueprint {
        update = "fbmk_2_2",
        name = content.text("finish the kitchen"),
        provides = {
            { id = "fbmk_2_center_2" },
        },
        requires = {
            { id = "fbmk_2_center" },
        },
        excludes = {
            { id = "fbmk_2_center_2" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_smoking_area",
    result = "fbmk_2_smoking_area",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's get this smoking area covered to protect the workers from the weather."),
}
    :camp_blueprint {
        update = "fbmk_2_smoking_area_construction",
        name = content.text("build a roofed area for smoking racks"),
        provides = {
            { id = "fbmk_2_smoking_area" },
        },
        requires = {
            { id = "fbmk_2_center_2" },
        },
        excludes = {
            { id = "fbmk_2_smoking_area" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_pantry",
    result = "fbmk_2_pantry",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a pantry beside the kitchen."),
}
    :camp_blueprint {
        update = "fbmk_2_pantry_construction",
        name = content.text("build a pantry"),
        provides = {
            { id = "fbmk_2_pantry_room" },
        },
        requires = {
            { id = "fbmk_2_center_2" },
        },
        excludes = {
            { id = "fbmk_2_pantry_room" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_dining_1",
    result = "fbmk_2_dining_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build the first part of the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_2_dining_1",
        name = content.text("build first dining hall section"),
        provides = {
            { id = "fbmk_2_dining_1" },
        },
        requires = {
            { id = "fbmk_2_smoking_area" },
        },
        excludes = {
            { id = "fbmk_2_dining_1" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_dining_2",
    result = "fbmk_2_dining_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build the second half of the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_2_dining_2",
        name = content.text("build second half of the dining hall"),
        provides = {
            { id = "fbmk_2_dining_2" },
        },
        requires = {
            { id = "fbmk_2_dining_1" },
        },
        excludes = {
            { id = "fbmk_2_dining_2" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_brewery",
    result = "fbmk_2_brewery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a brewery."),
}
    :camp_blueprint {
        update = "fbmk_2_brewery",
        name = content.text("build brewery"),
        provides = {
            { id = "fbmk_2_brewery" },
        },
        requires = {
            { id = "fbmk_2" },
        },
        excludes = {
            { id = "fbmk_2_brewery" },
        },
        parameter_labels = {
            ["fbmk_2_construction_palette"] = {
                ["fbmk_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
