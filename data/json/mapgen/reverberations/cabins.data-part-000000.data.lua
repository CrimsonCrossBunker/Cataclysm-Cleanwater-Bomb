local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Cabin_3_reverberation_hint",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cabin_3_reverberation_hint_north" },
        { point = { 0, 0, 1 }, terrain = "cabin_roof_3_reverberation_hint_north" },
    },
    connections = { { point = { 0, -1, 0 }, terrain = "forest_trail", connection = "forest_trail" } },
    locations = { "forest" },
    city_distance = { 25, -1 },
    city_sizes = { 0, 20 },
    occurrences = { 1, 1 },
    flags = { "CLASSIC", "WILDERNESS", "MAN_MADE", "GLOBALLY_UNIQUE" },
}
