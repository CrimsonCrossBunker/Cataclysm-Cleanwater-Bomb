local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette_log",
    layout = {
        terrain = { w = "t_wall_log", d = "t_door_c", X = "t_floor" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette_rock",
    layout = {
        terrain = { w = "t_rock_wall", d = "t_door_c", X = "t_floor" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette_standard",
    layout = {
        terrain = { w = "t_wall", d = "t_door_c", X = "t_floor" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette_wad",
    layout = {
        terrain = { w = "t_wall_wattle", d = "t_door_makeshift_c", X = "t_floor" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette_wood",
    layout = {
        terrain = { w = "t_wall_wood", d = "t_door_c", X = "t_floor" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_NW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_NW", x = 8, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_W1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_W1", x = 5, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_W2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_W2", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_SW",
    layout = {
        nested = {
            { id = "fbmc_shelter_1_bedroom_SW", x = 5, y = 19 },
            { id = "fbmc_shelter_1_bedroom_W3", x = 5, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_S",
    layout = {
        nested = {
            { id = "fbmc_shelter_1_bedroom_S1", x = 8, y = 19 },
            { id = "fbmc_shelter_1_bedroom_S2", x = 12, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bedroom_NW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  w",
            "  w",
            "wdw",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_W1",
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
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_W2",
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
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_W3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  w",
            " Xw",
            "  d",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_SW",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "  ww",
            "  w ",
            "  w ",
            "  w ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_S1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " dww",
            "   w",
            "   w",
            "   w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
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
    id = "fbmc_shelter_1_bedroom_S2",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "dw",
            "  ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_1_palette_log", "fbmc_shelter_1_palette_rock",
                        "fbmc_shelter_1_palette_standard", "fbmc_shelter_1_palette_wad",
                        "fbmc_shelter_1_palette_wood",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}
