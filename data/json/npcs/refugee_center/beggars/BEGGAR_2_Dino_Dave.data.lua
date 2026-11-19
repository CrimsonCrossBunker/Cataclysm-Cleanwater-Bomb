local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "cardboard_castle_1_main",
    layout = {
        nested = { { x = 0, y = 17, id = "cardboard_castle_1_main" } },
        transform_placements = { { id = "unlock_door", x = { 0, 23 }, y = { 0, 23 } } },
        tile_edits = { { shape = "point", operation = "remember_position", id = "dave_castle", x = 4, y = 19 } },
    },
}

-- First iteration of Dino Dave's cardboard castle - main floor.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cardboard_castle_1_main",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||-|||",
            "|__CC|",
            "|____|",
            "||-|||",
            "|__BB|",
            "||||||",
        },
        nested = { { x = 0, y = 0, z = 1, id = "cardboard_castle_1_roof" } },
        furniture = {
            ["|"] = "f_cardboard_wall",
            ["-"] = "f_cardboard_door",
            _ = "f_cardboard_floor",
            C = "f_cardboard_box",
            B = "f_floor_mattress",
        },
    },
}

-- First iteration of Dino Dave's cardboard castle - roof.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cardboard_castle_1_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "______",
            "______",
            "______",
            "______",
            "______",
            "______",
        },
        furniture = { _ = "f_cardboard_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "refcenter_unlock_roofstairs",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_door_metal_c", x = 1, y = 14 },
            { shape = "point", operation = "terrain", id = "t_door_metal_c", x = 21, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "beggar_2_remove_lobbycardboard",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_clear",
                x = 6,
                y = 1,
                end_x = 8,
                end_y = 1,
            },
        },
    },
}
