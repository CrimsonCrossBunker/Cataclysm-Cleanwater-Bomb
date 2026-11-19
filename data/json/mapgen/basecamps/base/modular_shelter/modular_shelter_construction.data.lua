local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_palette_log",
    layout = { terrain = { w = "t_wall_log", d = "t_door_c" }, furniture = { w = "f_clear", d = "f_clear" } },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_palette_rock",
    layout = {
        terrain = { w = "t_rock_wall", d = "t_door_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_palette_standard",
    layout = { terrain = { w = "t_wall", d = "t_door_c" }, furniture = { w = "f_clear", d = "f_clear" } },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_palette_wad",
    layout = {
        terrain = { w = "t_wall_wattle", d = "t_door_makeshift_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_palette_wood",
    layout = {
        terrain = { w = "t_wall_wood", d = "t_door_c" },
        furniture = { w = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_se",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_SE", x = 15, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_e",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_E", x = 15, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_SW",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_SW", x = 4, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_W",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_W", x = 5, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_NW",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_NW", x = 5, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_bedroom_SE",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "wwww",
            "w   ",
            "d   ",
            "w   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_palette_log", "fbmc_shelter_palette_rock",
                        "fbmc_shelter_palette_standard", "fbmc_shelter_palette_wad",
                        "fbmc_shelter_palette_wood",
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
    id = "fbmc_shelter_bedroom_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "wwww",
            "w   ",
            "d   ",
            "w   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_palette_log", "fbmc_shelter_palette_rock",
                        "fbmc_shelter_palette_standard", "fbmc_shelter_palette_wad",
                        "fbmc_shelter_palette_wood",
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
    id = "fbmc_shelter_bedroom_SW",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " wwww",
            "    w",
            "    d",
            "    w",
            "  www",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_palette_log", "fbmc_shelter_palette_rock",
                        "fbmc_shelter_palette_standard", "fbmc_shelter_palette_wad",
                        "fbmc_shelter_palette_wood",
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
    id = "fbmc_shelter_bedroom_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "wwww",
            "   w",
            "   d",
            "   w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_palette_log", "fbmc_shelter_palette_rock",
                        "fbmc_shelter_palette_standard", "fbmc_shelter_palette_wad",
                        "fbmc_shelter_palette_wood",
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
    id = "fbmc_shelter_bedroom_NW",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "   w",
            "   d",
            "   w",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_shelter_palette_log", "fbmc_shelter_palette_rock",
                        "fbmc_shelter_palette_standard", "fbmc_shelter_palette_wad",
                        "fbmc_shelter_palette_wood",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}
