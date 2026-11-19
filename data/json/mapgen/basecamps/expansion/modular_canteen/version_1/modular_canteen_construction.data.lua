local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_construction",
    layout = {
        nested = {
            { id = "fbmk_kitchen_room_construction", x = 9, y = 7, z = 0 },
            { id = "fbmk_kitchen_room_roof_construction", x = 9, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen2_construction",
    layout = {
        nested = {
            { id = "fbmk_kitchen_room2_construction", x = 9, y = 7, z = 0 },
            { id = "fbmk_kitchen_room2_roof_construction", x = 9, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_smoking_area_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_smoking_area_construction", x = 16, y = 7, z = 0 },
            { id = "fbmk_canteen_smoking_area_roof_construction", x = 16, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_pantry_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_pantry_construction", x = 3, y = 7, z = 0 },
            { id = "fbmk_canteen_pantry_roof_construction", x = 3, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_west_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_west_construction", x = 3, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_west_roof_construction", x = 3, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_east_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_east_construction", x = 14, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_east_roof_construction", x = 14, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_center_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_center_construction", x = 8, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_center_roof_construction", x = 8, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_kitchen_room_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wowdwow",
            "w.....w",
            "......o",
            "       ",
            "       ",
            "       ",
            "       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_kitchen_room_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "       ",
            "       ",
            "       ",
            "       ",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_kitchen_room2_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "w.....d",
            "......o",
            "w.....w",
            "wwwdwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_kitchen_room2_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_smoking_area_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ",w,w   ",
            ",,,,   ",
            ",,,,   ",
            ",,aw   ",
            ",,,,   ",
            ",,,,   ",
            "ww,w   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" }, "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_smoking_area_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_pantry_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwwww ",
            "w..... ",
            "o..... ",
            "w..... ",
            "o..... ",
            "w..... ",
            "wwwwww ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_pantry_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRR ",
            "RRRRRR ",
            "RRRRRR ",
            "RRRRRR ",
            "RRRRRR ",
            "RRRRRR ",
            "RRRRRR ",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_west_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            " bbbw..",
            "    w..",
            "  B o..",
            "    d..",
            "    o..",
            "    ww.",
            "     ww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" }, "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_west_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "    RRR",
            "    RRR",
            "    RRR",
            "    RRR",
            "    RRR",
            "    RRR",
            "     RR",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_east_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "...w   ",
            "...w   ",
            "...ob  ",
            "...wb  ",
            "...ob  ",
            "..ww   ",
            "oww    ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" }, "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_east_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRRR   ",
            "RRR    ",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_center_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  .... ",
            "  .... ",
            "  .... ",
            "  .... ",
            "  .... ",
            "  .... ",
            "  owdw ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_center_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  RRRR ",
            "  RRRR ",
            "  RRRR ",
            "  RRRR ",
            "  RRRR ",
            "  RRRR ",
            "  RRRR ",
        },
        parameters = {
            fbmk_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmk_concrete_palette", "fbmk_log_palette", "fbmk_metal_palette",
                        "fbmk_migo_resin_palette", "fbmk_rammed_earth_palette", "fbmk_rock_palette",
                        "fbmk_wad_palette", "fbmk_wood_palette", "fbmk_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmk_construction_palette" } },
    },
}
