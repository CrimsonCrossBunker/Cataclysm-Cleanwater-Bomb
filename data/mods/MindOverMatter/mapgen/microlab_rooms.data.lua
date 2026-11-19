local ccb = require("ccb")

-- This is a Physics lab tile with guaranteed matrix crystal
ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_chunk",
    weight = 333,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "| .....  ||.",
            "|.....   ...",
            "  |.C...C...",
            "   ....,.C..",
            "   ..| ..C. ",
            "   Cc....|  ",
            "  .CC.. .  |",
            "  |  ,  .C..",
            ".  ,,    ..|",
            "..   ..   . ",
            ",.  .. CC   ",
            "|           ",
        },
        palettes = { "microlab_matrix_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
