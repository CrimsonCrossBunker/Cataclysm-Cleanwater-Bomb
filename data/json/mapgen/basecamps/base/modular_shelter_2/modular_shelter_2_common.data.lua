local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_NW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_nw_wall", x = 3, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w1_wall", x = 3, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w1_wall", x = 3, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w2_wall", x = 8, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_SW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_southwest_wall", x = 7, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_S1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_south1_wall", x = 10, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_S2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_south1_wall", x = 13, y = 21 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east1_wall", x = 14, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E4",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "hhhh",
            "tttt",
            "hhhh",
            "    ",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_dining",
    layout = {
        nested = { { id = "fbmc_shelter_2_dining_room", x = 12, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_living_room",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "xCB",
            "s Q",
            "s B",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_living_room_roof",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "  V",
            "   ",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_livingroom",
    layout = {
        nested = {
            { id = "fbmc_shelter_2_living_room", x = 17, y = 7, z = 0 },
            { id = "fbmc_shelter_2_living_room_roof", x = 17, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 12, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 9, y = 8, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 8, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 8, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 9, y = 8, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_brazier",
    layout = {
        loot_placements = { { id = "pot", x = 9, y = 8, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_brazier", x = 8, y = 8 },
            { shape = "point", operation = "furniture", id = "f_table", x = 9, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_stove",
    layout = {
        loot_placements = { { id = "pot", x = 9, y = 8, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 8, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 8, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 9, y = 8, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 10, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_pantry",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 7, y = 13 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 8, y = 13 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 9, y = 13 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 14, y = 13 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 15, y = 13 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 16, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_craftspot",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_workbench", x = 6, y = 8 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 7, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_radio_console",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 12, y = 5 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 13, y = 5 },
        },
    },
}
