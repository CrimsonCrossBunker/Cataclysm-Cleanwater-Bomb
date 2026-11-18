local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area",
    result = "faction_base_modular_firestation1_living_area",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's expand our living areas by partitioning the far vehicle bay with walls."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_living_area",
        name = content.text("build the living quarters walls"),
        provides = {
            { id = "fbmc_firestation1_quarters" },
        },
        requires = {
            { id = "fbmc_firestation1_0" },
        },
        excludes = {
            { id = "fbmc_firestation1_quarters" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_firestation1_palette_white_wall"] = content.text("White wooden walls"),
                ["fbmc_firestation1_palette_log"] = content.text("Log walls"),
                ["fbmc_firestation1_palette_metal"] = content.text("Metal walls"),
                ["fbmc_firestation1_palette_migo"] = content.text("Mi-go resin walls"),
                ["fbmc_firestation1_palette_rammed_earth"] = content.text("Rammed earth walls"),
                ["fbmc_firestation1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_firestation1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_firestation1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)
