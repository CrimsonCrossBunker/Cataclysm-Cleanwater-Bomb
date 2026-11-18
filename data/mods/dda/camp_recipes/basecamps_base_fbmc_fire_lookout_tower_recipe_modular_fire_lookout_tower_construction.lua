local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_construction_shack_0",
    result = "faction_base_fire_lookout_tower_construction_shack_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack in the northern part of the camp."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_construction_shack_0",
        name = content.text("northern shack"),
        provides = {
            { id = "fbmc_fire_lookout_tower_shack_0" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_0" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_shack_0" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_construction_shack_1",
    result = "faction_base_fire_lookout_tower_construction_shack_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack in the southern part of the camp."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_construction_shack_1",
        name = content.text("southern shack"),
        provides = {
            { id = "fbmc_fire_lookout_tower_shack_1" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_shack_0" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_shack_1" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)
