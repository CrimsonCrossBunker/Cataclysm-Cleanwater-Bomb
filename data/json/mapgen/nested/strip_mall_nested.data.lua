local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_5x5_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "##+##",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_5x5_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx+",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_5x5_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "##+##",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_5x5_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "+xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
