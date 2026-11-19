local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "labyrinth2_scarlet_sea_portal",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x0_y0" },
        { point = { 1, 0, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x1_y0" },
        { point = { 0, 1, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x0_y1" },
        { point = { 1, 1, 0 }, terrain = "labyrinth2_scarlet_sea_portal_x1_y1" },
    },
    city_distance = { 0, -1 },
    occurrences = { 33, 100 },
    rotate = false,
    locations = { "labyrinth2" },
    flags = { "EXTRADIMENSIONAL", "NETHERUM_LABYRINTH2", "GLOBALLY_UNIQUE" },
}
