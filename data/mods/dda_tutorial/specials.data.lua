local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "tutorial",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "tutorial" },
        { point = { 0, 0, 1 }, terrain = "tutorial_roof" },
        { point = { 0, 0, -1 }, terrain = "tutorial_underground" },
    },
    locations = { "land" },
    occurrences = { 0, 0 },
    flags = { "TUTORIAL" },
}
