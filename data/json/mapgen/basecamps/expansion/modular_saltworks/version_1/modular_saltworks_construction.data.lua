local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_saltworks_0",
    layout = {
        nested = { { id = "fbmsw_0", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_saltpan_construction_northeast",
    layout = {
        nested = {
            { id = "fbmsw_saltpan_construction", x = 14, y = 3, z = 0 },
            { id = "fbmsw_saltpan_construction_roof", x = 14, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_shack_construction_southeast",
    layout = {
        nested = {
            { id = "fbmsw_shack_construction", x = 15, y = 15, z = 0 },
            { id = "fbmsw_shack_construction_roof", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_brewery0_construction_southwest",
    layout = {
        nested = {
            { id = "fbmsw_brewery0_construction", x = 3, y = 14, z = 0 },
            { id = "fbmsw_brewery0_construction_roof", x = 3, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_saltpan_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwowww",
            "w.....w",
            "w.c.c.w",
            "o.~t~.o",
            "w.~#~.w",
            "w.....w",
            "www+www",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_saltpan_construction_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
        },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_shack_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  woww",
            " wwrrw",
            " +..to",
            " orrrw",
            " wwoww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_shack_construction_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  RRRR",
            " RRRRR",
            " RRRRR",
            " RRRRR",
            " RRRRR",
        },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_brewery0_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "wwwwwww",
            "w.rrr.w",
            "oH....+",
            "wO....w",
            "o.....w",
            "w.....w",
            "wwwwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_brewery0_construction_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
        },
        parameters = {
            fbmsw_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmsw_log_palette", "fbmsw_metal_palette", "fbmsw_migo_resin_palette",
                        "fbmsw_rammed_earth_palette", "fbmsw_rock_palette", "fbmsw_wad_palette",
                        "fbmsw_wood_palette", "fbmsw_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmsw_construction_palette" } },
    },
}
