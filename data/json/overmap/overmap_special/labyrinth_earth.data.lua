local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "earth_scrap_metal_spire",
    locations = { "wilderness" },
    tiles = { { point = { 0, 0, 0 }, terrain = "earth_scrap_metal_spire" } },
    city_distance = { 0, -1 },
    occurrences = { 10, 100 },
    flags = { "MAN_MADE", "GLOBALLY_UNIQUE" },
}
