local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_2_palette_log",
    layout = { terrain = { w = "t_wall_log", d = "t_door_c" }, furniture = { w = "f_clear", d = "f_clear" } },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_2_palette_rock",
    layout = {
        terrain = { w = "t_rock_wall", d = "t_door_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_2_palette_standard",
    layout = { terrain = { w = "t_wall_w", d = "t_door_c" }, furniture = { w = "f_clear", d = "f_clear" } },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_2_palette_wad",
    layout = {
        terrain = { w = "t_wall_wattle", d = "t_door_makeshift_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_2_palette_wood",
    layout = {
        terrain = { w = "t_wall_wood", d = "t_door_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_NW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_NW", x = 3, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_W1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_W1", x = 3, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_W2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_W2", x = 3, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_W3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_W3", x = 7, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_SW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_SW", x = 6, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_S",
    layout = {
        nested = {
            { id = "fbmc_shelter_2_bedroom_S1", x = 10, y = 19 },
            { id = "fbmc_shelter_2_bedroom_S2", x = 13, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_E2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_east2", x = 18, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_E3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_east3", x = 18, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_E4",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_east4", x = 18, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bedroom_E1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bedroom_east1", x = 13, y = 14 } },
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_door_c", x = 12, y = 14 },
            { shape = "point", operation = "terrain", id = "t_door_c", x = 12, y = 17 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_bedroom_NW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  w",
            "  d",
            "www",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_W1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  w",
            "  d",
            "www",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_W2",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "  w ",
            "  d ",
            "  w ",
            "  w ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_W3",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "www ",
            "d  w",
            "w  w",
            "www ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_SW",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "wdww",
            "   w",
            "   w",
            "    ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_S1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "wdw",
            "  w",
            "  w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_S2",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "www",
            "  d",
            "  w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_east1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " www",
            "w  w",
            "w  w",
            " dww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_east2",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "w   ",
            "w   ",
            "d   ",
            "www ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_east3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "w  ",
            "d  ",
            "www",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
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
    id = "fbmc_shelter_2_bedroom_east4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "w   ",
            "d   ",
            "w   ",
            "w   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_2_palette_log", "fbmc_shelter_2_palette_rock",
                        "fbmc_shelter_2_palette_standard", "fbmc_shelter_2_palette_wad",
                        "fbmc_shelter_2_palette_wood",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}
