local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "#+#",
            "#x#",
            "###",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
