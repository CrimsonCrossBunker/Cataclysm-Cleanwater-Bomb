local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room0_construction_northeast",
    result = "faction_base_modular_workshop_room0_construction_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We can use a workshop.  Let's start by building a spot to protect the workers from the rain."),
}
    :camp_blueprint {
        update = "fbmw_room0_construction_northeast",
        name = content.text("northeast wall"),
        provides = {
            { id = "fbmw_northeast" },
        },
        requires = {
            { id = "fbmw_0" },
        },
        excludes = {
            { id = "fbmw_northeast" },
        },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room3_construction_north",
    result = "faction_base_modular_workshop_room3_construction_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's extend the north wall to the west and add some storage space."),
}
    :camp_blueprint {
        update = "fbmw_room3_construction_north",
        name = content.text("north wall"),
        provides = {
            { id = "fbmw_north" },
        },
        requires = {
            { id = "fbmw_northeast", amount = 3 },
        },
        excludes = {
            { id = "fbmw_north" },
        },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room4_construction_east",
    result = "faction_base_modular_workshop_room4_construction_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's expand our production by adding another charcoal kiln with walls."),
}
    :camp_blueprint {
        update = "fbmw_room4_construction_east",
        name = content.text("east forge wall"),
        provides = {
            { id = "fbmw_east" },
            { id = "blacksmith_recipes_3" },
        },
        requires = {
            { id = "fbmw_north" },
        },
        excludes = {
            { id = "fbmw_east" },
        },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room5_construction_center",
    result = "faction_base_modular_workshop_room5_construction_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's expand work area with a wall, and add a bookshelf for our reference books."),
}
    :camp_blueprint {
        update = "fbmw_room5_construction_center",
        name = content.text("west forge wall"),
        provides = {
            { id = "fbmw_center" },
        },
        requires = {
            { id = "fbmw_east" },
        },
        excludes = {
            { id = "fbmw_center" },
        },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room6_construction_north",
    result = "faction_base_modular_workshop_room6_construction_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's expand our production by adding a walled pottery kiln area."),
}
    :component("metalworking_tongs", 1)
    :component("chisel", 1)
    :component("hammer", 1)
    :component("swage", 1)
    :camp_blueprint {
        update = "fbmw_room6_construction_north",
        name = content.text("north pottery wall"),
        provides = {
            { id = "fbmw_north" },
            { id = "blacksmith_recipes_4" },
        },
        requires = {
            { id = "fbmw_center" },
        },
        excludes = {
            { id = "fbmw_north", amount = 2 },
        },
        resources = { "metalworking_tongs", "chisel", "hammer", "swage" },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room7to9_construction_northwest",
    result = "faction_base_modular_workshop_room7to9_construction_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's enclose this pottery with walls and get some more storage set up."),
}
    :camp_blueprint {
        update = "fbmw_room7to9_construction_northwest",
        name = content.text("northwest and south pottery wall"),
        provides = {
            { id = "fbmw_northwest" },
            { id = "blacksmith_recipes_5" },
        },
        requires = {
            { id = "fbmw_north", amount = 2 },
        },
        excludes = {
            { id = "fbmw_northwest" },
        },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room11to12_construction_southeast",
    result = "faction_base_modular_workshop_room11to12_construction_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's expand the workspace for larger projects and add a drop hammer for productivity with log pillars."),
}
    :component("wrench", 1)
    :component("pliers", 1)
    :camp_blueprint {
        update = "fbmw_room11to12_construction_southeast",
        name = content.text("open air, covered work space"),
        provides = {
            { id = "fbmw_southeast" },
            { id = "fbmw_south" },
            { id = "blacksmith_recipes_7" },
        },
        requires = {
            { id = "fbmw_northeast", amount = 4 },
        },
        excludes = {
            { id = "fbmw_northsoutheast" },
            { id = "fbmw_south" },
        },
        resources = { "wrench", "pliers", "fake_drop_hammer" },
        parameter_labels = {
            ["fbmw_construction_palette"] = {
                ["fbmw_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_metal_palette"] = content.text("Metal walls and wooden roof"),
                ["fbmw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
