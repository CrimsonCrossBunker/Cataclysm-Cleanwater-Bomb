local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_controls_room_construction",
    layout = {
        nested = {
            { id = "fbmc_construction_wall_tile", x = 19, y = 15 },
            { id = "fbmc_construction_wall_tile", x = 16, y = 16 },
            { id = "fbmc_construction_wall_tile", x = 17, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_0",
    layout = {
        nested = { { id = "fbmc_radio_tower_construction_shack", x = 10, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_1",
    layout = {
        nested = { { id = "fbmc_construction_shack_south", x = 16, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_2",
    layout = {
        nested = {
            { id = "fbmc_construction_wall_vertical", x = 1, y = 15 },
            { id = "fbmc_construction_shack_north", x = 2, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_3",
    layout = {
        nested = { { id = "fbmc_construction_shack_north", x = 7, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_4",
    layout = {
        nested = { { id = "fbmc_construction_shack_north", x = 12, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_5",
    layout = {
        nested = { { id = "fbmc_construction_shack_north", x = 17, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_6",
    layout = {
        nested = { { id = "fbmc_construction_shack_west", x = 14, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_8",
    layout = {
        nested = { { id = "fbmc_construction_shack_east", x = 3, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_construction_shack_7",
    layout = {
        nested = {
            { id = "fbmc_construction_wall_horizontal", x = 3, y = 10 },
            { id = "fbmc_construction_shack_east", x = 3, y = 11 },
        },
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_dirt", x = 9, y = 13 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 11, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_radio_tower_construction_shack",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "w....w",
            "w....w",
            "w....w",
            "w ...w",
            "ww+vww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
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
