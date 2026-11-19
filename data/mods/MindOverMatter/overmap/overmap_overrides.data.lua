local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "lab_surface_brick_blockA2", "lab_surface_brick_blockA3", "lab_surface_brick_blockA4",
        "lab_surface_brick_blockB2", "lab_surface_brick_blockB3", "lab_surface_brick_blockB4",
        "lab_surface_brick_blockC4", "lab_surface_brick_blockD2", "lab_surface_brick_blockD3",
        "lab_surface_brick_blockD4", "lab_surface_brick_blockE2", "lab_surface_brick_blockE3",
        "lab_surface_brick_blockE4",
    },
    name = ccb.content.text("research facility"),
    symbol = "l",
    color = "light_gray",
    spawns = { group = "GROUP_LAB_RESEARCH", population = { 10, 25 }, chance = 60 },
    extras = "research_facility_interior",
    see_cost = "full_high",
    monster_density = 2,
}
