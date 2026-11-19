local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_NE_1",
    layout = {
        nested = {
            { id = "fbmh_2_room_NE_1", x = 18, y = 0, z = 0 },
            { id = "fbmh_2_room_NE_1_roof", x = 18, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_NE_2",
    layout = {
        nested = {
            { id = "fbmh_2_room_NE_2", x = 18, y = 0, z = 0 },
            { id = "fbmh_2_room_NE_2_roof", x = 18, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_NE_3",
    layout = {
        nested = {
            { id = "fbmh_2_room_NE_3", x = 18, y = 0, z = 0 },
            { id = "fbmh_2_room_NE_3_roof", x = 18, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_ENE",
    layout = {
        nested = {
            { id = "fbmh_2_room_ENE", x = 19, y = 6, z = 0 },
            { id = "fbmh_2_room_roof", x = 19, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_ESE",
    layout = {
        nested = {
            { id = "fbmh_2_room_ESE", x = 19, y = 14, z = 0 },
            { id = "fbmh_2_room_ESE_roof", x = 19, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_SE",
    layout = {
        nested = {
            { id = "fbmh_2_room_SE", x = 19, y = 19, z = 0 },
            { id = "fbmh_2_room_roof", x = 19, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_SW",
    layout = {
        nested = {
            { id = "fbmh_2_room_SW", x = 0, y = 19, z = 0 },
            { id = "fbmh_2_room_roof", x = 0, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_WSW",
    layout = {
        nested = {
            { id = "fbmh_2_room_WSW", x = 0, y = 14, z = 0 },
            { id = "fbmh_2_room_WSW_roof", x = 0, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_WNW",
    layout = {
        nested = {
            { id = "fbmh_2_room_WNW", x = 0, y = 5, z = 0 },
            { id = "fbmh_2_room_WNW_roof", x = 0, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_room_NW",
    layout = {
        nested = {
            { id = "fbmh_2_room_NW", x = 0, y = 0, z = 0 },
            { id = "fbmh_2_room_roof", x = 0, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_east",
    layout = {
        nested = {
            { id = "fbmh_2_center_east", x = 18, y = 9, z = 0 },
            { id = "fbmh_2_center_east_roof", x = 18, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_mideast",
    layout = {
        nested = {
            { id = "fbmh_2_center_mideast", x = 12, y = 9, z = 0 },
            { id = "fbmh_2_center_roof", x = 12, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_midwest",
    layout = {
        nested = {
            { id = "fbmh_2_center_midwest", x = 6, y = 9, z = 0 },
            { id = "fbmh_2_center_roof", x = 6, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_west",
    layout = {
        nested = {
            { id = "fbmh_2_center_west", x = 0, y = 9, z = 0 },
            { id = "fbmh_2_center_west_roof", x = 0, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_courtyard_wall_north",
    layout = {
        nested = {
            { id = "fbmh_2_courtyard_wall_north", x = 5, y = 0, z = 0 },
            { id = "fbmh_2_courtyard_wall_north_roof", x = 5, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_courtyard_wall_south",
    layout = {
        nested = {
            { id = "fbmh_2_courtyard_wall_south", x = 5, y = 10, z = 0 },
            { id = "fbmh_2_courtyard_wall_south_roof", x = 5, y = 10, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  wwww",
            "  ...w",
            "    .w",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_1_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  rrrr",
            "  rrrr",
            "    rr",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "  ..  ",
            "  ...w",
            "  ...w",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_2_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "  rr  ",
            "  rrrr",
            "  rrrr",
            "      ",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " w    ",
            " w    ",
            " +    ",
            " v    ",
            " w    ",
            " wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NE_3_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " r    ",
            " r    ",
            " r    ",
            " r    ",
            " r    ",
            " rrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_ENE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "v...w",
            "+...w",
            "w...w",
            "wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_ESE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ...w",
            "+...w",
            "v...w",
            "w...w",
            "wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_ESE_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " rrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_SE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "v...w",
            "+...w",
            "w...w",
            "wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_SW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "w...v",
            "w...+",
            "w...w",
            "wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_WSW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w... ",
            "w...+",
            "w...v",
            "w...w",
            "wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_WSW_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "rrrr ",
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_WNW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "wwwww",
            "w...w",
            "w...v",
            "w...+",
            "w... ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_WNW_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrr ",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_room_NW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "wwwww",
            "w...w",
            "w...+",
            "w...v",
            "w...w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_east",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w     ",
            ".     ",
            ".....+",
            ".....+",
            ".wwwww",
            "ww    ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_east_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "r     ",
            "r     ",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rr    ",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_mideast",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "+wwvww",
            "......",
            "......",
            "......",
            "......",
            "+wwvww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_midwest",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwvw+",
            "......",
            "......",
            "......",
            "......",
            "wwwvw+",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_west",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    ww",
            "wwwww.",
            "+.....",
            "+.....",
            "wwwww.",
            "    ww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_center_west_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    rr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "    rr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_courtyard_wall_north",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "+wwwwwwwwwwww+",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_courtyard_wall_north_roof",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "rrrrrrrrrrrrrr",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_courtyard_wall_south",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "+wwwwwwwwwwww+",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_courtyard_wall_south_roof",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "rrrrrrrrrrrrrr",
        },
        parameters = {
            fbmh_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmh_2_adobe_palette", "fbmh_2_concrete_palette", "fbmh_2_log_palette",
                        "fbmh_2_metal_palette", "fbmh_2_migo_resin_palette",
                        "fbmh_2_rammed_earth_palette", "fbmh_2_rock_palette", "fbmh_2_wad_palette",
                        "fbmh_2_wood_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmh_2_construction_palette" } },
    },
}
