local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room0_construction_northeast",
    layout = {
        nested = {
            { id = "fbmw_room0_construction", x = 15, y = 3, z = 0 },
            { id = "fbmw_room0_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room3_construction_north",
    layout = {
        nested = {
            { id = "fbmw_room3_construction", x = 9, y = 3, z = 0 },
            { id = "fbmw_room3_roof_construction", x = 9, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room4_construction_east",
    layout = {
        nested = {
            { id = "fbmw_room4_construction", x = 15, y = 9, z = 0 },
            { id = "fbmw_room4_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room5_construction_center",
    layout = {
        nested = {
            { id = "fbmw_room5_construction", x = 9, y = 9, z = 0 },
            { id = "fbmw_room5_roof_construction", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room7to9_construction_northwest",
    layout = {
        nested = {
            { id = "fbmw_room7_construction", x = 3, y = 3, z = 0 },
            { id = "fbmw_room7_roof_construction", x = 3, y = 3, z = 1 },
            { id = "fbmw_room8_construction", x = 3, y = 9, z = 0 },
            { id = "fbmw_room8_roof_construction", x = 3, y = 9, z = 1 },
            { id = "fbmw_room9_construction", x = 9, y = 9, z = 0 },
            { id = "fbmw_room9_roof_construction", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room6_construction_north",
    layout = {
        nested = {
            { id = "fbmw_room6_construction", x = 9, y = 3, z = 0 },
            { id = "fbmw_room6_roof_construction", x = 9, y = 3, z = 1 },
        },
        loot_placements = {
            { id = "tongs", x = 19, y = 5, chance = 100 },
            { id = "chisel", x = 19, y = 5, chance = 100 },
            { id = "hammer", x = 19, y = 5, chance = 100 },
            { id = "swage", x = 19, y = 5, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room11to12_construction_southeast",
    layout = {
        nested = {
            { id = "fbmw_room11_construction", x = 15, y = 15, z = 0 },
            { id = "fbmw_room11_roof_construction", x = 15, y = 15, z = 1 },
            { id = "fbmw_room12_construction", x = 9, y = 15, z = 0 },
            { id = "fbmw_room12_roof_construction", x = 9, y = 15, z = 1 },
        },
        loot_placements = {
            { id = "wrench", x = 19, y = 7, chance = 100 },
            { id = "pliers", x = 19, y = 7, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_drophammer", x = 19, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room0_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwoww",
            ".....w",
            ".....o",
            ".....w",
            ".....w",
            ".....w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room0_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room3_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   wwo",
            "   wr.",
            "   w.h",
            "   d..",
            "   wr.",
            "   wr.",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room3_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room4_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".....d",
            "....xw",
            ".....o",
            ".....w",
            "....rw",
            "....rw",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room4_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRRRRR",
            "RRRRCR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room5_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   wr.",
            "   wt.",
            "   oM.",
            "   wB.",
            "   o..",
            "   w..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room5_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room6_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "www   ",
            "rkr   ",
            "...   ",
            "cc.   ",
            "...   ",
            "...   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room6_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRR   ",
            "RCR   ",
            "RRR   ",
            "RRR   ",
            "RRR   ",
            "RRR   ",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room7_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   www",
            "   wrr",
            "   wr.",
            "   d..",
            "   wr.",
            "   wr.",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room7_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room8_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   wwo",
            "     b",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room8_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room9_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wow   ",
            "bb    ",
            "      ",
            "z     ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room9_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRR   ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room11_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "....ww",
            ".....w",
            "......",
            ".....w",
            "......",
            ".....w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room11_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room12_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   ww.",
            "   w..",
            "   ...",
            "   w..",
            "   ...",
            "   w..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room12_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
            "   RRR",
        },
        parameters = {
            fbmw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_concrete_palette", "fbmw_log_palette", "fbmw_metal_palette",
                        "fbmw_migo_resin_palette", "fbmw_rammed_earth_palette", "fbmw_rock_palette",
                        "fbmw_wad_palette", "fbmw_wood_palette", "fbmw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_construction_palette" } },
    },
}
