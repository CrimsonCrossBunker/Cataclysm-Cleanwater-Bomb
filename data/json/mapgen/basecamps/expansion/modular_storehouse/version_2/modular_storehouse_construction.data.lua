local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_1_construction",
    layout = {
        nested = {
            { id = "fbms_2_1_construction", x = 0, y = 16, z = 0 },
            { id = "fbms_2_7x7_roof_construction", x = 0, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_2_construction",
    layout = {
        nested = {
            { id = "fbms_2_2_construction", x = 7, y = 16, z = 0 },
            { id = "fbms_2_6x7_roof_construction", x = 7, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_3_construction",
    layout = {
        nested = {
            { id = "fbms_2_3_construction", x = 13, y = 16, z = 0 },
            { id = "fbms_2_7x7_roof_construction", x = 13, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_4_construction",
    layout = {
        nested = {
            { id = "fbms_2_4_construction", x = 0, y = 11, z = 0 },
            { id = "fbms_2_7x5_roof_construction", x = 0, y = 11, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_5_construction",
    layout = {
        nested = {
            { id = "fbms_2_5_construction", x = 7, y = 11, z = 0 },
            { id = "fbms_2_6x5_roof_construction", x = 7, y = 11, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_6_construction",
    layout = {
        nested = {
            { id = "fbms_2_6_construction", x = 13, y = 11, z = 0 },
            { id = "fbms_2_7x5_roof_construction", x = 13, y = 11, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_7_construction",
    layout = {
        nested = {
            { id = "fbms_2_7_construction", x = 0, y = 5, z = 0 },
            { id = "fbms_2_7x6_roof_construction", x = 0, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_8_construction",
    layout = {
        nested = {
            { id = "fbms_2_8_construction", x = 7, y = 5, z = 0 },
            { id = "fbms_2_6x6_roof_construction", x = 7, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_9_construction",
    layout = {
        nested = {
            { id = "fbms_2_9_construction", x = 13, y = 5, z = 0 },
            { id = "fbms_2_7x6_roof_construction", x = 13, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_10_construction",
    layout = {
        nested = {
            { id = "fbms_2_10_construction", x = 0, y = 0, z = 0 },
            { id = "fbms_2_7x5_roof_construction", x = 0, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_11_construction",
    layout = {
        nested = {
            { id = "fbms_2_11_construction", x = 7, y = 0, z = 0 },
            { id = "fbms_2_6x5_roof_construction", x = 7, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_2_12_construction",
    layout = {
        nested = {
            { id = "fbms_2_12_construction", x = 13, y = 0, z = 0 },
            { id = "fbms_2_7x5_roof_construction", x = 13, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_1_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "w......",
            "w......",
            "w......",
            "w......",
            "w......",
            "w......",
            "wvwwv+w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_7x7_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
        },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_2_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "...... ",
            "...... ",
            "...... ",
            "...... ",
            "...... ",
            "...... ",
            "wvwwvw ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_6x7_roof_construction",
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
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_3_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "......v",
            "......w",
            "......w",
            "......w",
            "......w",
            "......v",
            "wwvw+vw",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_4_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwww+w",
            "w......",
            "w......",
            "w......",
            "w......",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_7x5_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "       ",
            "       ",
        },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_5_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "......",
            "......",
            "......",
            "......",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_6x5_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "      ",
        },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_6_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwww+ww",
            "......w",
            "......w",
            "......w",
            "......w",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_7_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "w......",
            "w......",
            "w......",
            "w......",
            "w......",
            "w......",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_7x6_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "rrrrrrr",
            "       ",
        },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_8_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            "......",
            "......",
            "......",
            "......",
            "......",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_6x6_roof_construction",
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
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_9_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "......v",
            "......w",
            "......w",
            "......w",
            "......w",
            "......v",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_10_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwwwww",
            "w......",
            "w......",
            "w......",
            "w......",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_11_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "......",
            "......",
            "......",
            "......",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_2_12_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwwwww",
            "......w",
            "......w",
            "......w",
            "......w",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_2_concrete_palette", "fbms_2_log_palette", "fbms_2_metal_palette",
                        "fbms_2_migo_resin_palette", "fbms_2_rammed_earth_palette",
                        "fbms_2_rock_palette", "fbms_2_wad_palette", "fbms_2_wood_palette",
                        "fbms_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_2_construction_palette" } },
    },
}
