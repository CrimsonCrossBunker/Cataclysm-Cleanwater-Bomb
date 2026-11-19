local ccb = require("ccb")

ccb.content.define_mapgen_palette { id = "fbmc_straw_bed_palette", layout = { terrain = {}, furniture = { b = "f_straw_bed" } } }

ccb.content.define_mapgen_palette {
    id = "fbmc_makeshift_bed_palette",
    layout = { terrain = {}, furniture = { b = "f_makeshift_bed" } },
}

ccb.content.define_mapgen_palette { id = "fbmc_bed_palette", layout = { terrain = {}, furniture = { b = "f_bed" } } }

ccb.content.define_mapgen_palette {
    id = "fbmc_concrete_palette",
    layout = {
        terrain = {
            ["."] = "t_thconc_floor",
            ["+"] = "t_door_metal_c",
            r = "t_concrete_roof",
            v = "t_window_no_curtains",
            w = "t_sconc_wall",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_log_palette",
    layout = {
        terrain = {
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            r = "t_wood_treated_roof",
            v = "t_window_no_curtains",
            w = "t_wall_log",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_metal_palette",
    layout = {
        terrain = {
            ["."] = "t_scrap_floor",
            ["+"] = "t_door_metal_c",
            r = "t_metal_flat_roof",
            v = "t_window_no_curtains",
            w = "t_scrap_wall",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_migo_resin_palette",
    layout = {
        terrain = {
            ["."] = "t_floor_resin",
            ["+"] = "t_resin_hole_c",
            r = "t_resin_roof",
            v = "t_wall_resin_cage",
            w = "t_wall_resin",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_rammed_earth_palette",
    layout = {
        terrain = {
            ["."] = "t_floor_primitive",
            ["+"] = "t_door_makeshift_c",
            r = "t_log_sod_roof",
            v = "t_window_empty",
            w = "t_wall_rammed_earth",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_rock_palette",
    layout = {
        terrain = {
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            r = "t_wood_treated_roof",
            v = "t_window_no_curtains",
            w = "t_rock_wall",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_wad_palette",
    layout = {
        terrain = {
            ["."] = "t_floor_primitive",
            ["+"] = "t_door_makeshift_c",
            r = "t_log_sod_roof",
            v = "t_wall_wattle_half",
            w = "t_wall_wattle",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_wood_palette",
    layout = {
        terrain = {
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            r = "t_wood_treated_roof",
            v = "t_window_no_curtains",
            w = "t_wall_wood",
        },
        furniture = { ["."] = "f_clear", ["+"] = "f_clear", v = "f_clear", w = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_bed_horizontal",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "bb",
            "  ",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_bed_vertical",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "b ",
            "b ",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_5x6_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
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

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_shack_south",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwww ",
            "....w ",
            "....w ",
            "....w ",
            "....w ",
            "w+vww ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_5x6_roof" } },
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
    id = "fbmc_construction_shack_north",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w+vww ",
            "....w ",
            "....w ",
            "....w ",
            "....w ",
            "wwwww ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_5x6_roof" } },
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
    id = "fbmc_construction_6x5_roof",
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

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_shack_west",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w....w",
            "v....w",
            "+....w",
            "w....w",
            "wwwwww",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_6x5_roof" } },
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
    id = "fbmc_construction_shack_east",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w....w",
            "w....v",
            "w....+",
            "w....w",
            "wwwwww",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_6x5_roof" } },
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
    id = "fbmc_construction_wall_roof_horizontal",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "rrrrrr",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
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

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_wall_horizontal",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_wall_roof_horizontal" } },
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
    id = "fbmc_construction_wall_roof_vertical",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "r     ",
            "r     ",
            "r     ",
            "r     ",
            "r     ",
            "r     ",
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

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_wall_vertical",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "w     ",
            "w     ",
            "w     ",
            "w     ",
            "w     ",
            "w     ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_wall_roof_vertical" } },
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
    id = "fbmc_construction_wall_tile_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "r",
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

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_construction_wall_tile",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = 0, y = 0, z = 1, id = "fbmc_construction_wall_tile_roof" } },
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
