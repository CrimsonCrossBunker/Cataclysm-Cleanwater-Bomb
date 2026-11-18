local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_saltpan_northeast",
    result = "faction_base_modular_saltpan_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could divert saltwater from the swamp nearby to create a steady supply of salt for our needs in building."),
}
    :camp_blueprint {
        update = "fbmsw_saltpan_construction_northeast",
        name = content.text("NE wall saltpan"),
        provides = {
            { id = "fbmsw_northeast" },
            { id = "Salt_Pan" },
            { id = "kitchen" },
            { id = "saltworks_recipes_1" },
        },
        requires = {
            { id = "fbmsw_0" },
        },
        excludes = {
            { id = "fbmsw_northeast" },
        },
        parameter_labels = {
            ["fbmsw_construction_palette"] = {
                ["fbmsw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmsw_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmsw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmsw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmsw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmsw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmsw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmsw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shack_construction_southeast",
    result = "faction_base_modular_shack_construction_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a storage room for chemicals and tools, so build a shack on the southeast side of the saltworks field."),
}
    :camp_blueprint {
        update = "fbmsw_shack_construction_southeast",
        name = content.text("SE storage room"),
        provides = {
            { id = "fbmsw_southeast" },
        },
        requires = {
            { id = "fbmsw_0" },
        },
        excludes = {
            { id = "fbmsw_southeast" },
        },
        parameter_labels = {
            ["fbmsw_construction_palette"] = {
                ["fbmsw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmsw_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmsw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmsw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmsw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmsw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmsw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmsw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_brewery0_construction_southwest",
    result = "faction_base_modular_brewery0_construction_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could take advantage of the designation of this area to build a brewery."),
}
    :camp_blueprint {
        update = "fbmsw_brewery0_construction_southwest",
        name = content.text("SW brewery"),
        provides = {
            { id = "fbmsw_southwest" },
            { id = "saltworks_recipes_2" },
            { id = "brewery" },
        },
        requires = {
            { id = "fbmsw_0" },
        },
        excludes = {
            { id = "fbmsw_southwest" },
        },
        parameter_labels = {
            ["fbmsw_construction_palette"] = {
                ["fbmsw_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmsw_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmsw_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmsw_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmsw_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmsw_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmsw_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmsw_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
