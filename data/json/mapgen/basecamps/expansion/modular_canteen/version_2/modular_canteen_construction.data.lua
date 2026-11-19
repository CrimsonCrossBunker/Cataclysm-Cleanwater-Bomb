local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_1",
    layout = {
        nested = {
            { id = "fbmk_2_room", x = 9, y = 9, z = 0 },
            { id = "fbmk_2_room_roof", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_2",
    layout = {
        nested = {
            { id = "fbmk_2_room_2", x = 9, y = 9, z = 0 },
            { id = "fbmk_2_room_2_roof", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_smoking_area_construction",
    layout = {
        nested = {
            { id = "fbmk_2_smoking_area_construction", x = 15, y = 18, z = 0 },
            { id = "fbmk_2_smoking_area_roof_construction", x = 15, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_pantry_construction",
    layout = {
        nested = {
            { id = "fbmk_2_pantry_construction", x = 0, y = 9, z = 0 },
            { id = "fbmk_2_pantry_roof_construction", x = 0, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_dining_1",
    layout = {
        nested = {
            { id = "fbmk_2_dining_1", x = 10, y = 16, z = 0 },
            { id = "fbmk_2_dining_1_roof", x = 10, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_dining_2",
    layout = {
        nested = {
            { id = "fbmk_2_dining_2", x = 6, y = 16, z = 0 },
            { id = "fbmk_2_dining_2_roof", x = 6, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_brewery",
    layout = {
        nested = {
            { id = "fbmk_2_brewery", x = 0, y = 16, z = 0 },
            { id = "fbmk_2_brewery_roof", x = 0, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_room",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wvw+wvw",
            "......w",
            "......v",
            "       ",
            "       ",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_room_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "       ",
            "       ",
            "       ",
            "       ",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_room_2",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "w.....+",
            "......v",
            "......w",
            "w+wwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_room_2_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_smoking_area_construction",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w,,,w",
            "v,,,,",
            "+,,,,",
            "v,,,,",
            "w,,,w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_smoking_area_roof_construction",
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
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_pantry_construction",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "wwwwwwwww",
            "w........",
            "w........",
            "w........",
            "w........",
            "w........",
            "wwwwwwwww",
            "         ",
            "         ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_pantry_roof_construction",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "rrrrrrrrr",
            "rrrrrrrrr",
            "rrrrrrrrr",
            "rrrrrrrrr",
            "rrrrrrrrr",
            "rrrrrrrrr",
            "rrrrrrrrr",
            "         ",
            "         ",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_1",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".....w ",
            ".....v ",
            ".....  ",
            ".....  ",
            ".....  ",
            ".....  ",
            "wwvw+  ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_1_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrr ",
            "rrrrrr ",
            "rrrrr  ",
            "rrrrr  ",
            "rrrrr  ",
            "rrrrr  ",
            "rrrrr  ",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_2",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "....   ",
            "....   ",
            "....   ",
            "....   ",
            "....   ",
            "....   ",
            "wwvw   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_2_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrr   ",
            "rrrr   ",
            "rrrr   ",
            "rrrr   ",
            "rrrr   ",
            "rrrr   ",
            "rrrr   ",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_brewery",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "w....w ",
            "w....w ",
            "w....+ ",
            "w....w ",
            "w....w ",
            "w....w ",
            "wwwwvw ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_brewery_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
        },
        parameters = {
            fbmk_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_2_concrete_palette", "fbmk_2_log_palette", "fbmk_2_metal_palette",
                        "fbmk_2_migo_resin_palette", "fbmk_2_rammed_earth_palette",
                        "fbmk_2_rock_palette", "fbmk_2_wad_palette", "fbmk_2_wood_palette",
                        "fbmk_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_2_construction_palette" } },
    },
}
