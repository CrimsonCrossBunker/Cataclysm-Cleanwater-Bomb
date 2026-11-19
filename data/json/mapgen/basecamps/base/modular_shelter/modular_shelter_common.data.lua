local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_SE",
    layout = {
        nested = { { id = "fbmc_shelter_bed_east_wall", x = 16, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_E",
    layout = {
        nested = { { id = "fbmc_shelter_bed_east_wall", x = 16, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_SW",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_W",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_beds_NW",
    layout = {
        nested = { { id = "fbmc_shelter_bed_west_wall", x = 5, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " hth",
            " hth",
            " hth",
            " hth",
        },
        palettes = { "fbmc_shelter_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_dining",
    layout = {
        nested = { { id = "fbmc_shelter_dining_room", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_living_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "tsss",
            "    ",
            "    ",
            " CtC",
        },
        palettes = { "fbmc_shelter_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_0",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_floor", x = 9, y = 9 },
            { shape = "point", operation = "furniture", id = "f_bulletin", x = 9, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 12, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 18, y = 11, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 18, y = 11, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 12, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_brazier",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 12, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_brazier", x = 18, y = 11 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_stove",
    layout = {
        loot_placements = { { id = "pot", x = 18, y = 12, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 18, y = 11, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 18, y = 11, z = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 18, y = 12, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 16, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_livingroom",
    layout = {
        nested = { { id = "fbmc_shelter_living_room", x = 10, y = 18 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 7, y = 21 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 8, y = 21 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_pantry",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 15, y = 9 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 15, y = 14 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 16, y = 14 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 17, y = 14 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 18, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_craftspot",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_workbench", x = 16, y = 11 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 16, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_radio_console",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 5, y = 7 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 6, y = 7 },
        },
    },
}
