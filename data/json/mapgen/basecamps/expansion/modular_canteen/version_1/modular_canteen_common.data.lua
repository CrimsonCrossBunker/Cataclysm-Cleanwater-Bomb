local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_0",
    layout = {
        nested = { { id = "fbmk_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_counters",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "     c ",
            "       ",
            "  ccc  ",
            "       ",
            " rr rr ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_counters",
    layout = {
        nested = { { id = "fbmk_canteen_counters", x = 9, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_pantry",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            " rrrrU ",
            " V     ",
            " rrrr  ",
            " V     ",
            " rrrrU ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_pantry_furniture",
    layout = {
        nested = { { id = "fbmk_canteen_pantry", x = 3, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_furniture",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "hth hth",
            "hth hth",
            "hth hth",
            "hth hth",
            "       ",
            "       ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_furniture",
    layout = {
        nested = { { id = "fbmk_canteen_dining_furniture", x = 9, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_planters",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ppp",
            "ppp",
            "   ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_1",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 4, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_2",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 8, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_3",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 14, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_4",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 18, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 10, y = 8 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 11, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 11, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 13, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 13, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 10, y = 8, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_stove",
    layout = {
        loot_placements = { { id = "pot", x = 10, y = 8 }, { id = "pan", x = 10, y = 8 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 11, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 11, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 13, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 13, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 10, y = 8, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_well",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_water_pump", x = 12, y = 5 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 12, y = 5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_smoking_kiln",
    layout = {
        tile_edits = {
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 17,
                y = 8,
                z = 0,
            },
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 18,
                y = 8,
                z = 0,
            },
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 19,
                y = 8,
                z = 0,
            },
            { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 19, y = 12, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 19, y = 12, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_butchery_rack",
    layout = {
        loot_placements = { { id = "knife_huge", variant = "knife_butcher", x = 16, y = 12 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 17, y = 12 },
            { shape = "point", operation = "furniture", id = "f_table", x = 16, y = 12 },
        },
    },
}
