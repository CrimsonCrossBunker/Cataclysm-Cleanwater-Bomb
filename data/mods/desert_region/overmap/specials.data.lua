local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "ws_giant_sinkhole",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "ws_giant_sinkhole_1_north" },
        { point = { 0, 0, -1 }, terrain = "ws_giant_sinkhole_2_north" },
    },
    locations = { "wilderness" },
    city_distance = { 15, -1 },
    occurrences = { 0, 10 },
    flags = { "CLASSIC", "WILDERNESS" },
}

ccb.content.define_fixed_overmap_special {
    id = "Canyon Tourist Center",
    tiles = {
        { point = { 0, 1, 0 }, terrain = "s_lot_north", locations = { "land" } },
        { point = { 0, 0, 0 }, terrain = "s_lot_north", locations = { "land" } },
        { point = { 1, 0, 0 }, locations = { "canyon" } },
        { point = { 1, 1, 0 }, locations = { "canyon" } },
    },
    connections = { { point = { 0, -1, 0 }, terrain = "road", from = { 0, 0, 0 } } },
    city_distance = { 5, 75 },
    occurrences = { 0, 2 },
    flags = { "CLASSIC", "MAN_MADE" },
}
