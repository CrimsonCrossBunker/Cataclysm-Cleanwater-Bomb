local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbml_2_coop_construction",
    result = "fbml_2_coop_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a coop to contain our chicken and other birds, so build a shack on the remote side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_coop_construction",
        name = content.text("chicken coop"),
        provides = {
            { id = "fbml_2_coop" },
        },
        requires = {
            { id = "fbml_2" },
        },
        excludes = {
            { id = "fbml_2_coop" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_shack_construction",
    result = "fbml_2_shack_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a storage room for feed, animal gear and tools, so build a shack on the near side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_shack_construction",
        name = content.text("storage shack"),
        provides = {
            { id = "fbml_2_shack" },
            { id = "blacksmith" },
            { id = "fbml_2_shed_recipes_1" },
        },
        requires = {
            { id = "fbml_2" },
        },
        excludes = {
            { id = "fbml_2_shack" },
        },
        resources = { "spinwheelitem" },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_stall_1_construction",
    result = "fbml_2_stall_1_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a stable for larger livestock, so build a stall section on the near side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_stall_1_construction",
        name = content.text("stable section 1"),
        provides = {
            { id = "fbml_2_stall_1" },
        },
        requires = {
            { id = "fbml_2" },
        },
        excludes = {
            { id = "fbml_2_stall_1" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_stall_2_construction",
    result = "fbml_2_stall_2_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a larger stable, so extend the stable with another stall."),
}
    :camp_blueprint {
        update = "fbml_2_stall_2_construction",
        name = content.text("stable section 2"),
        provides = {
            { id = "fbml_2_stall_2" },
        },
        requires = {
            { id = "fbml_2_stall_1" },
        },
        excludes = {
            { id = "fbml_2_stall_2" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_stall_3_construction",
    result = "fbml_2_stall_3_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a larger stable, so extend the stable with another stall."),
}
    :camp_blueprint {
        update = "fbml_2_stall_3_construction",
        name = content.text("stable section 3"),
        provides = {
            { id = "fbml_2_stall_3" },
        },
        requires = {
            { id = "fbml_2_stall_2" },
        },
        excludes = {
            { id = "fbml_2_stall_3" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_stall_4_construction",
    result = "fbml_2_stall_4_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a larger stable, so extend the stable with another stall."),
}
    :camp_blueprint {
        update = "fbml_2_stall_4_construction",
        name = content.text("stable section 4"),
        provides = {
            { id = "fbml_2_stall_4" },
        },
        requires = {
            { id = "fbml_2_stall_3" },
        },
        excludes = {
            { id = "fbml_2_stall_4" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_stall_5_construction",
    result = "fbml_2_stall_5_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a larger stable, so finish the stable with two smaller stalls."),
}
    :camp_blueprint {
        update = "fbml_2_stall_5_construction",
        name = content.text("finished stable"),
        provides = {
            { id = "fbml_2_stall_5" },
        },
        requires = {
            { id = "fbml_2_stall_4" },
        },
        excludes = {
            { id = "fbml_2_stall_5" },
        },
        parameter_labels = {
            ["fbml_2_construction_palette"] = {
                ["fbml_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbml_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbml_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbml_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbml_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbml_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbml_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbml_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbml_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
