local ccb = require("ccb")

-- A nested map for walls variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_chain_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "XX-XX",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        terrain = { ["-"] = "t_chaingate_c", X = "t_chainfence" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
