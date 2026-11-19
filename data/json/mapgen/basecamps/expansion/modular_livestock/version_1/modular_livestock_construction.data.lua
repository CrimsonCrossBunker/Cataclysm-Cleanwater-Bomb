local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_coop_construction_northeast",
    layout = {
        nested = {
            { id = "fbml_coop_construction", x = 15, y = 3, z = 0 },
            { id = "fbml_coop_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_shack_construction_southeast",
    layout = {
        nested = {
            { id = "fbml_shack_construction", x = 15, y = 15, z = 0 },
            { id = "fbml_shack_roof_construction", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable0_construction_southwest",
    layout = {
        nested = {
            { id = "fbml_stable0_construction", x = 3, y = 15, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable1_construction_west",
    layout = {
        nested = {
            { id = "fbml_stable1_construction", x = 3, y = 9, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable2_construction_northwest",
    layout = {
        nested = {
            { id = "fbml_stable2_construction", x = 3, y = 3, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_coop_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "w....w",
            "w....w",
            "w....w",
            "w....w",
            "wwdfww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
        parameters = {
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" }, "fbml_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_coop_roof_construction",
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
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_shack_construction",
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
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" }, "fbml_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_shack_roof_construction",
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
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_stable0_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww.w",
            "w..D..",
            "w..F..",
            "w..F..",
            "w..Fbb",
            "wwwwww",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
        parameters = {
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" }, "fbml_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_stable_roof_construction",
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
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_stable1_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwww.w",
            "w..F..",
            "w..D..",
            "wwwwb.",
            "w..Fb.",
            "w..D..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
        parameters = {
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" }, "fbml_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_stable2_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "wwwwww",
            "w..F..",
            "w..D..",
            "wwwwb.",
            "w..Fb.",
            "w..D..",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 5 }, y = { 0, 5 } } },
        parameters = {
            fbml_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbml_concrete_palette", "fbml_log_palette", "fbml_metal_palette",
                        "fbml_migo_resin_palette", "fbml_rammed_earth_palette", "fbml_rock_palette",
                        "fbml_wad_palette", "fbml_wood_palette", "fbml_brick_palette",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbml_construction_palette" }, "fbml_common_palette" },
    },
}
