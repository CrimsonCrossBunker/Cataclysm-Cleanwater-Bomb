local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room0_construction_east",
    layout = {
        nested = {
            { id = "fbms_room0_construction", x = 15, y = 9, z = 0 },
            { id = "fbms_room0_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room1_construction_west",
    layout = {
        nested = {
            { id = "fbms_room1_construction", x = 3, y = 9, z = 0 },
            { id = "fbms_room1_roof_construction", x = 3, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room2_construction_northwest",
    layout = {
        nested = {
            { id = "fbms_room2_construction", x = 3, y = 3, z = 0 },
            { id = "fbms_room2_roof_construction", x = 3, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room3_construction_southwest",
    layout = {
        nested = {
            { id = "fbms_room3_construction", x = 3, y = 15, z = 0 },
            { id = "fbms_room3_roof_construction", x = 3, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room4_construction_northeast",
    layout = {
        nested = {
            { id = "fbms_room4_construction", x = 15, y = 3, z = 0 },
            { id = "fbms_room4_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room5_construction_southeast",
    layout = {
        nested = {
            { id = "fbms_room5_construction", x = 15, y = 15, z = 0 },
            { id = "fbms_room5_roof_construction", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room6_construction_south",
    layout = {
        nested = {
            { id = "fbms_room6_construction", x = 9, y = 15, z = 0 },
            { id = "fbms_room6_roof_construction", x = 9, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room7_construction_north",
    layout = {
        nested = {
            { id = "fbms_room7_construction", x = 9, y = 3, z = 0 },
            { id = "fbms_room7_roof_construction", x = 9, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room8_construction_center",
    layout = {
        nested = {
            { id = "fbms_room8_construction", x = 9, y = 9, z = 0 },
            { id = "fbms_room8_roof_construction", x = 9, y = 9, z = 1 },
            { id = "fbms_room9_construction", x = 3, y = 9, z = 0 },
            { id = "fbms_room9_roof_construction", x = 3, y = 9, z = 1 },
            { id = "fbms_room10_construction", x = 15, y = 9, z = 0 },
            { id = "fbms_room10_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room0_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  wwww",
            "  ...w",
            "  ...w",
            "  ...w",
            "  ...w",
            "  wwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room0_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  rrrr",
            "  rrrr",
            "  rrrr",
            "  rrrr",
            "  rrrr",
            "  rrrr",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room1_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww  ",
            "w...  ",
            "w...  ",
            "w...  ",
            "w...  ",
            "wwww  ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room1_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrr  ",
            "rrrr  ",
            "rrrr  ",
            "rrrr  ",
            "rrrr  ",
            "rrrr  ",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room2_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "   wow",
            "   w..",
            "   w..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room2_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "   rrr",
            "   rrr",
            "   rrr",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room3_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   w..",
            "   w..",
            "   wow",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room3_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   rrr",
            "   rrr",
            "   rrr",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room4_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "wow   ",
            "..w   ",
            "..w   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room4_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "rrr   ",
            "rrr   ",
            "rrr   ",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room5_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "..w   ",
            "..w   ",
            "wow   ",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room5_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrr   ",
            "rrr   ",
            "rrr   ",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room6_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            "......",
            "woddow",
            " .... ",
            " .... ",
            "w....w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room6_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            " rrrr ",
            " rrrr ",
            "rrrrrr",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room7_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w....w",
            " .... ",
            " .... ",
            "woddow",
            "......",
            "......",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room7_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            " rrrr ",
            " rrrr ",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room8_construction",
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
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room8_roof_construction",
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
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room9_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    ..",
            "    ..",
            "    ..",
            "    ..",
            "    ..",
            "    ..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room9_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    rr",
            "    rr",
            "    rr",
            "    rr",
            "    rr",
            "    rr",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room10_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "..    ",
            "..    ",
            "..    ",
            "..    ",
            "..    ",
            "..    ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_room10_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rr    ",
            "rr    ",
            "rr    ",
            "rr    ",
            "rr    ",
            "rr    ",
        },
        parameters = {
            fbms_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbms_concrete_palette", "fbms_log_palette", "fbms_metal_palette",
                        "fbms_migo_resin_palette", "fbms_rammed_earth_palette", "fbms_rock_palette",
                        "fbms_wad_palette", "fbms_wood_palette", "fbms_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbms_construction_palette" } },
    },
}
