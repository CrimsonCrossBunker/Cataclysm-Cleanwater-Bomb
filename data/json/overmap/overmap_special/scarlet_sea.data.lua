local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "scarlet_sea_xedra_hew",
    locations = { "scarlet_sea_reverberation" },
    tiles = { { point = { 0, 0, 0 }, terrain = "scarlet_sea_xedra_hew_north" } },
    city_distance = { 0, -1 },
    occurrences = { 80, 100 },
    flags = { "MAN_MADE", "GLOBALLY_UNIQUE", "SCARLET_SEA", "EXTRADIMENSIONAL" },
}

ccb.content.define_fixed_overmap_special {
    id = "scarlet_scrap_metal_spire",
    locations = { "scarlet_sea_reverberation" },
    tiles = { { point = { 0, 0, 0 }, terrain = "scarlet_scrap_metal_spire" } },
    city_distance = { 0, -1 },
    occurrences = { 95, 100 },
    flags = { "MAN_MADE", "GLOBALLY_UNIQUE", "SCARLET_SEA", "EXTRADIMENSIONAL" },
}
