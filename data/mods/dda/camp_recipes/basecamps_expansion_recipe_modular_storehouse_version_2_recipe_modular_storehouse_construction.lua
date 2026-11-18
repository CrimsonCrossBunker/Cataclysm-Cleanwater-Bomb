local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbms_2_1_construction",
    result = "fbms_2_1_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a large storage building.  Let's start with a first section."),
}
    :camp_blueprint {
        update = "fbms_2_1_construction",
        name = content.text("first storage section"),
        provides = {
            { id = "fbms_2_1" },
        },
        requires = {
            { id = "fbms_2" },
        },
        excludes = {
            { id = "fbms_2_1" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_2_construction",
    result = "fbms_2_2_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a second section."),
}
    :camp_blueprint {
        update = "fbms_2_2_construction",
        name = content.text("second storage section"),
        provides = {
            { id = "fbms_2_2" },
        },
        requires = {
            { id = "fbms_2_1" },
        },
        excludes = {
            { id = "fbms_2_2" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_3_construction",
    result = "fbms_2_3_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a third section."),
}
    :camp_blueprint {
        update = "fbms_2_3_construction",
        name = content.text("third storage section"),
        provides = {
            { id = "fbms_2_3" },
        },
        requires = {
            { id = "fbms_2_2" },
        },
        excludes = {
            { id = "fbms_2_3" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_4_construction",
    result = "fbms_2_4_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a fourth section."),
}
    :camp_blueprint {
        update = "fbms_2_4_construction",
        name = content.text("fourth storage section"),
        provides = {
            { id = "fbms_2_4" },
        },
        requires = {
            { id = "fbms_2_3" },
        },
        excludes = {
            { id = "fbms_2_4" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_5_construction",
    result = "fbms_2_5_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a fifth section."),
}
    :camp_blueprint {
        update = "fbms_2_5_construction",
        name = content.text("fifth storage section"),
        provides = {
            { id = "fbms_2_5" },
        },
        requires = {
            { id = "fbms_2_4" },
        },
        excludes = {
            { id = "fbms_2_5" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_6_construction",
    result = "fbms_2_6_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's finish our storage building with a last section.  We could then go on to double the volume with another six sections, but if that seems excessive we could use the space to unload loot instead."),
}
    :camp_blueprint {
        update = "fbms_2_6_construction",
        name = content.text("last storage section"),
        provides = {
            { id = "fbms_2_6" },
        },
        requires = {
            { id = "fbms_2_5" },
        },
        excludes = {
            { id = "fbms_2_6" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_7_construction",
    result = "fbms_2_7_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's start the construction of an adjoining warehouse with a seventh section to eventually double our storage space."),
}
    :camp_blueprint {
        update = "fbms_2_7_construction",
        name = content.text("seventh storage section"),
        provides = {
            { id = "fbms_2_7" },
        },
        requires = {
            { id = "fbms_2_6" },
        },
        excludes = {
            { id = "fbms_2_7" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_8_construction",
    result = "fbms_2_8_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with an eighth section."),
}
    :camp_blueprint {
        update = "fbms_2_8_construction",
        name = content.text("eighth storage section"),
        provides = {
            { id = "fbms_2_8" },
        },
        requires = {
            { id = "fbms_2_7" },
        },
        excludes = {
            { id = "fbms_2_8" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_9_construction",
    result = "fbms_2_9_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a ninth section."),
}
    :camp_blueprint {
        update = "fbms_2_9_construction",
        name = content.text("ninth storage section"),
        provides = {
            { id = "fbms_2_9" },
        },
        requires = {
            { id = "fbms_2_8" },
        },
        excludes = {
            { id = "fbms_2_9" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_10_construction",
    result = "fbms_2_10_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with a tenth section."),
}
    :camp_blueprint {
        update = "fbms_2_10_construction",
        name = content.text("tenth storage section"),
        provides = {
            { id = "fbms_2_10" },
        },
        requires = {
            { id = "fbms_2_9" },
        },
        excludes = {
            { id = "fbms_2_10" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_11_construction",
    result = "fbms_2_11_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with an eleventh section."),
}
    :camp_blueprint {
        update = "fbms_2_11_construction",
        name = content.text("eleventh storage section"),
        provides = {
            { id = "fbms_2_11" },
        },
        requires = {
            { id = "fbms_2_10" },
        },
        excludes = {
            { id = "fbms_2_11" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_12_construction",
    result = "fbms_2_12_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's extend our storage building with the absolutely very last section."),
}
    :camp_blueprint {
        update = "fbms_2_12_construction",
        name = content.text("absolutely very last storage section"),
        provides = {
            { id = "fbms_2_12" },
        },
        requires = {
            { id = "fbms_2_11" },
        },
        excludes = {
            { id = "fbms_2_12" },
        },
        parameter_labels = {
            ["fbms_2_construction_palette"] = {
                ["fbms_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbms_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbms_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbms_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbms_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbms_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbms_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbms_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbms_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
