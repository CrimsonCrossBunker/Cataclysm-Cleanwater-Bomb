local ccb = require("ccb")

-- Dummy terrain entry to satisfy need for non empty terrain section
ccb.content.define_mapgen_palette {
    id = "fbmc_shelter_1_palette",
    layout = {
        terrain = { ["."] = "t_dirt" },
        furniture = {
            h = "f_chair",
            t = "f_table",
            x = "f_coffee_table",
            L = "f_locker",
            s = "f_sofa",
            ["*"] = "f_clear",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_NW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_nw_wall", x = 8, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W3",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_SW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_southwest_wall", x = 5, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_S1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_south1_wall", x = 8, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_S2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_south2_wall", x = 11, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " hth",
            " hth",
            " hth",
            " hth",
        },
        palettes = { "fbmc_shelter_1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_dining",
    layout = {
        nested = { { id = "fbmc_shelter_1_dining_room", x = 12, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_living_room",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "***  ",
            " sss ",
            "***  ",
            " xxx ",
            "***  ",
        },
        palettes = { "fbmc_shelter_1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_0",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_floor", x = 15, y = 15 },
            { shape = "point", operation = "furniture", id = "f_bulletin", x = 15, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 15, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 18, y = 14, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 18, y = 14, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 15, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_brazier",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 15, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_brazier", x = 18, y = 14 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_stove",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 15, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 18, y = 14, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 18, y = 14, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 15, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 16, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_livingroom",
    layout = {
        nested = { { id = "fbmc_shelter_1_living_room", x = 8, y = 11 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 8, y = 16 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 9, y = 16 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 10, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_pantry",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 16 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 13, y = 15 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 14, y = 15 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 20 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 21 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 22 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_craftspot",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_workbench", x = 16, y = 15 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 16, y = 16 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 17, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_radio_console",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 18, y = 8 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 18, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bed_nw_wall",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "bL",
            "b*",
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
        palettes = { "fbmc_shelter_1_palette", { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bed_w1_wall",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "bb",
            "L*",
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
        palettes = { "fbmc_shelter_1_palette", { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bed_southwest_wall",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "L*  ",
            " *  ",
            "b*  ",
            "bt  ",
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
        palettes = { "fbmc_shelter_1_palette", { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bed_south1_wall",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "L*L",
            "b*b",
            "btb",
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
        palettes = { "fbmc_shelter_1_palette", { parameter = "fbmc_bed_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_bed_south2_wall",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   L",
            "  bb",
            "   L",
            "  bb",
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
        palettes = { "fbmc_shelter_1_palette", { parameter = "fbmc_bed_palette" } },
    },
}
