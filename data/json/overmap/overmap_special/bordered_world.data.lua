local ccb = require("ccb")

-- This location should never spawn naturally, only on top of existing locations when playing the scenarios with BORDERED flag.
ccb.content.define_fixed_overmap_special {
    id = "world",
    tiles = { { point = { 0, 0, 0 }, terrain = "rock_border" } },
    locations = { "land" },
    occurrences = { 0, 0 },
}
