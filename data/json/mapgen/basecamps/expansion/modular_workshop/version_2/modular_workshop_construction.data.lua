local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_1_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_1_construction", x = 14, y = 17, z = 0 },
            { id = "fbmw_2_smithy_1_roof_construction", x = 14, y = 17, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_2_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_2_construction", x = 14, y = 14, z = 0 },
            { id = "fbmw_2_smithy_2_roof_construction", x = 14, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_pottery_construction",
    layout = {
        nested = {
            { id = "fbmw_2_pottery_construction", x = 0, y = 16, z = 0 },
            { id = "fbmw_2_pottery_roof_construction", x = 0, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_3_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_3_construction", x = 8, y = 16, z = 0 },
            { id = "fbmw_2_smithy_3_roof_construction", x = 8, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_glassblower_construction",
    layout = {
        nested = {
            { id = "fbmw_2_glassblower_construction", x = 0, y = 7, z = 0 },
            { id = "fbmw_2_6x5_roof_construction", x = 0, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_tanner_construction",
    layout = {
        nested = {
            { id = "fbmw_2_tanner_construction", x = 14, y = 0, z = 0 },
            { id = "fbmw_2_6x5_roof_construction", x = 14, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_1_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".....w",
            ".....v",
            ".....w",
            ".....w",
            ".....w",
            "vww+vw",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_1_roof_construction",
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
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_2_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  w,,w",
            "  ,,,,",
            "wwwvww",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_2_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  rrrr",
            "  rrrr",
            "rrrrrr",
            "      ",
            "      ",
            "      ",
        },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_pottery_construction",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "www+wwvw",
            "w.......",
            "w.......",
            "w.......",
            "w.......",
            "w.......",
            "wwwwvwww",
            "        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_pottery_roof_construction",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "        ",
        },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_3_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwvw+ ",
            "w..... ",
            "w..... ",
            "+..... ",
            "w..... ",
            "w..... ",
            "wwwvww ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_smithy_3_roof_construction",
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
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_glassblower_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwvwvw",
            "w....w",
            "w....+",
            "w....w",
            "wwvw+w",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_6x5_roof_construction",
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
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_tanner_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "w....v",
            "+....w",
            "w....v",
            "w+wvww",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmw_2_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmw_2_concrete_palette", "fbmw_2_log_palette", "fbmw_2_metal_palette",
                        "fbmw_2_migo_resin_palette", "fbmw_2_rammed_earth_palette",
                        "fbmw_2_rock_palette", "fbmw_2_wad_palette", "fbmw_2_wood_palette",
                        "fbmw_2_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmw_2_construction_palette" } },
    },
}
