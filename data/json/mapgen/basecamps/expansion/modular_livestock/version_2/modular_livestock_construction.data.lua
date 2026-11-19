local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_coop_construction",
    layout = {
        nested = {
            { id = "fbml_2_coop_construction", x = 13, y = 0, z = 0 },
            { id = "fbml_2_coop_roof_construction", x = 13, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_shack_construction",
    layout = {
        nested = {
            { id = "fbml_2_shack_construction", x = 15, y = 18, z = 0 },
            { id = "fbml_2_shack_furniture", x = 16, y = 19, z = 0 },
            { id = "fbml_2_shack_roof_construction", x = 15, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_1_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_1_construction", x = 0, y = 18, z = 0 },
            { id = "fbml_2_stall_1", x = 3, y = 19, z = 0 },
            { id = "fbml_2_stall_1_roof_construction", x = 0, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_2_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_2_4_construction", x = 0, y = 14, z = 0 },
            { id = "fbml_2_stall_bench", x = 3, y = 15, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_3_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_3_construction", x = 0, y = 10, z = 0 },
            { id = "fbml_2_stall_3", x = 3, y = 11, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 10, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_4_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_2_4_construction", x = 0, y = 6, z = 0 },
            { id = "fbml_2_stall_bench", x = 3, y = 7, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_5_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_5_construction", x = 0, y = 0, z = 0 },
            { id = "fbml_2_stall_5", x = 3, y = 1, z = 0 },
            { id = "fbml_2_stall_5_roof_construction", x = 0, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_coop_construction",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "wwwwwww ",
            "w,,,,,w ",
            "w,,,,,w ",
            "w,,,,,w ",
            "w,,,,,w ",
            "w,,,,,w ",
            "w,,,,,w ",
            "w     w ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_coop_roof_construction",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrrrrrr ",
            "rrrrrrr ",
            "rrrrrrr ",
            "rrrrrrr ",
            "rrrrrrr ",
            "rrrrrrr ",
            "rrrrrrr ",
            "r     r ",
        },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_shack_construction",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "wvwww",
            "w,,,w",
            "+,,,v",
            "v,,,w",
            "wv+ww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_shack_roof_construction",
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
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_1_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww,,",
            "w,, ,,",
            "w,, ,,",
            "w,, ,,",
            "wwwwww",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_1_roof_construction",
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
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_2_4_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww,w",
            "w,, ,,",
            "w,, ,,",
            "w,, ,,",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_2_3_4_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "      ",
            "      ",
        },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_3_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww,,",
            "w,, ,,",
            "w,, ,,",
            "w,, ,,",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_5_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "w,, ,,",
            "w,, ,,",
            "wwww,,",
            "w,, ,,",
            "w,, ,,",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_5_roof_construction",
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
            fbml_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_2_concrete_palette", "fbml_2_log_palette", "fbml_2_metal_palette",
                        "fbml_2_migo_resin_palette", "fbml_2_rammed_earth_palette",
                        "fbml_2_rock_palette", "fbml_2_wad_palette", "fbml_2_wood_palette",
                        "fbml_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_2_construction_palette" } },
    },
}
