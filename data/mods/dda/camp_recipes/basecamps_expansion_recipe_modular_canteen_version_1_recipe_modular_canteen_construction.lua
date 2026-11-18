local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_canteen_room_center_construction",
    result = "faction_base_canteen_room_center_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's start building the central kitchen."),
}
    :camp_blueprint {
        update = "faction_base_canteen_construction",
        name = content.text("build the central kitchen room"),
        provides = {
            { id = "fbmk_center" },
        },
        requires = {
            { id = "fbmk_0" },
        },
        excludes = {
            { id = "fbmk_center" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_room2_center_construction",
    result = "faction_base_canteen_room2_center_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's finish the central kitchen."),
}
    :camp_blueprint {
        update = "faction_base_canteen2_construction",
        name = content.text("finish the central kitchen room"),
        provides = {
            { id = "fbmk_center2" },
        },
        requires = {
            { id = "fbmk_center" },
        },
        excludes = {
            { id = "fbmk_center2" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_smoking_area_construction",
    result = "faction_base_canteen_smoking_area_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's get this smoking area covered to protect the workers from the weather."),
}
    :camp_blueprint {
        update = "faction_base_smoking_area_construction",
        name = content.text("build a roofed area for smoking racks"),
        provides = {
            { id = "fbmk_smoking_area" },
        },
        requires = {
            { id = "fbmk_center2" },
        },
        excludes = {
            { id = "fbmk_smoking_area" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_pantry_construction",
    result = "faction_base_canteen_pantry_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a pantry west of the kitchen."),
}
    :camp_blueprint {
        update = "fbmk_canteen_pantry_construction",
        name = content.text("build a pantry"),
        provides = {
            { id = "fbmk_pantry_room" },
        },
        requires = {
            { id = "fbmk_center2" },
        },
        excludes = {
            { id = "fbmk_pantry_room" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_dining_west_construction",
    result = "faction_base_canteen_dining_west_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build the west third of the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_canteen_dining_west_construction",
        name = content.text("build west dining hall third"),
        provides = {
            { id = "fbmk_canteen_dining_west" },
        },
        requires = {
            { id = "fbmk_pantry_room" },
        },
        excludes = {
            { id = "fbmk_canteen_dining_west" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_dining_east_construction",
    result = "faction_base_canteen_dining_east_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build the east third of the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_canteen_dining_east_construction",
        name = content.text("build east dining room third"),
        provides = {
            { id = "fbmk_canteen_dining_east" },
        },
        requires = {
            { id = "fbmk_canteen_dining_west" },
            { id = "fbmk_smoking_area" },
        },
        excludes = {
            { id = "fbmk_canteen_dining_east" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_dining_center_construction",
    result = "faction_base_canteen_dining_center_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build the center third of the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_canteen_dining_center_construction",
        name = content.text("build center third of the dining hall"),
        provides = {
            { id = "fbmk_canteen_dining_center" },
        },
        requires = {
            { id = "fbmk_canteen_dining_east" },
        },
        excludes = {
            { id = "fbmk_canteen_dining_center" },
        },
        parameter_labels = {
            ["fbmk_construction_palette"] = {
                ["fbmk_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmk_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmk_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmk_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmk_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmk_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmk_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmk_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmk_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
