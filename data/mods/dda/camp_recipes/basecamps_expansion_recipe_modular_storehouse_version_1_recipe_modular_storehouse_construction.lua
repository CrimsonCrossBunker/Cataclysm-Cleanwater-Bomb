local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_east",
    result = "faction_base_modular_storehouse_construction_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Begin by building the east wing."),
}
    :camp_blueprint {
        update = "fbms_room0_construction_east",
        name = content.text("east storage wing"),
        provides = {
            { id = "fbms_east" },
        },
        requires = {
            { id = "fbms_0" },
        },
        excludes = {
            { id = "fbms_east" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_west",
    result = "faction_base_modular_storehouse_construction_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the west wing."),
}
    :camp_blueprint {
        update = "fbms_room1_construction_west",
        name = content.text("west storage wing"),
        provides = {
            { id = "fbms_west" },
        },
        requires = {
            { id = "fbms_0" },
        },
        excludes = {
            { id = "fbms_west" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_northwest",
    result = "faction_base_modular_storehouse_construction_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the northwest corner."),
}
    :camp_blueprint {
        update = "fbms_room2_construction_northwest",
        name = content.text("northwest storeroom corner"),
        provides = {
            { id = "fbms_northwest" },
        },
        requires = {
            { id = "fbms_west" },
        },
        excludes = {
            { id = "fbms_northwest" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_southwest",
    result = "faction_base_modular_storehouse_construction_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the southwest corner."),
}
    :camp_blueprint {
        update = "fbms_room3_construction_southwest",
        name = content.text("southwest storeroom corner"),
        provides = {
            { id = "fbms_southwest" },
        },
        requires = {
            { id = "fbms_west" },
        },
        excludes = {
            { id = "fbms_southwest" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_northeast",
    result = "faction_base_modular_storehouse_construction_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the northeast corner."),
}
    :camp_blueprint {
        update = "fbms_room4_construction_northeast",
        name = content.text("northeast storeroom corner"),
        provides = {
            { id = "fbms_northeast" },
        },
        requires = {
            { id = "fbms_east" },
        },
        excludes = {
            { id = "fbms_northeast" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_southeast",
    result = "faction_base_modular_storehouse_construction_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the southeast corner."),
}
    :camp_blueprint {
        update = "fbms_room5_construction_southeast",
        name = content.text("southeast storeroom corner"),
        provides = {
            { id = "fbms_southeast" },
        },
        requires = {
            { id = "fbms_east" },
        },
        excludes = {
            { id = "fbms_southeast" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_south",
    result = "faction_base_modular_storehouse_construction_south",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the southern entrance."),
}
    :camp_blueprint {
        update = "fbms_room6_construction_south",
        name = content.text("south storeroom entrance"),
        provides = {
            { id = "fbms_south" },
        },
        requires = {
            { id = "fbms_southeast" },
            { id = "fbms_southwest" },
        },
        excludes = {
            { id = "fbms_south" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_north",
    result = "faction_base_modular_storehouse_construction_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by building the northern entrance."),
}
    :camp_blueprint {
        update = "fbms_room7_construction_north",
        name = content.text("north storeroom entrance"),
        provides = {
            { id = "fbms_north" },
        },
        requires = {
            { id = "fbms_northeast" },
            { id = "fbms_northwest" },
        },
        excludes = {
            { id = "fbms_north" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_storehouse_construction_center",
    result = "faction_base_modular_storehouse_construction_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a large central storage building.  Continue by filling in the floor."),
}
    :camp_blueprint {
        update = "fbms_room8_construction_center",
        name = content.text("north storeroom entrance"),
        provides = {
            { id = "fbms_center" },
        },
        requires = {
            { id = "fbms_north" },
            { id = "fbms_south" },
        },
        excludes = {
            { id = "fbms_center" },
        },
        parameter_labels = {
            ["fbms_construction_palette"] = {
                ["fbms_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
