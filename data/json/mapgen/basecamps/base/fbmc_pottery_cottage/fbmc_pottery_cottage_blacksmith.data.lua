local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_construction",
    layout = {
        nested = { { id = "fbmc_pottery_cottage_blacksmith_construction_nested", x = 8, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_1",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_forge_rock", x = 9, y = 20, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 9, y = 20, z = 1 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 9, y = 18, z = 0 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 9, y = 19, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_blacksmith_2",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_drophammer", x = 12, y = 17 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 12, y = 18 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 12, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_pottery_cottage_blacksmith_roof_construction_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "rrrrrr",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
        },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_concrete_palette", "fbmc_log_palette", "fbmc_metal_palette",
                        "fbmc_migo_resin_palette", "fbmc_rammed_earth_palette", "fbmc_rock_palette",
                        "fbmc_wad_palette", "fbmc_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_pottery_cottage_blacksmith_construction_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "www+vw",
            "w....w",
            "w.... ",
            "w.... ",
            "w.... ",
            "wwwww ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_pottery_cottage_blacksmith_roof_construction_nested" } },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_concrete_palette", "fbmc_log_palette", "fbmc_metal_palette",
                        "fbmc_migo_resin_palette", "fbmc_rammed_earth_palette", "fbmc_rock_palette",
                        "fbmc_wad_palette", "fbmc_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}
