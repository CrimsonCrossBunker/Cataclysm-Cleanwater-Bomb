local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Defense Mode Lake Retreat",
    locations = { "lake_surface" },
    city_distance = { 40, -1 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE", "LAKE" },
    tiles = {
        {
            point = { 0, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 2, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 3, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 4, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 5, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 6, 0, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 1, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 1, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 2, 1, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 3, 1, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 4, 1, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 5, 1, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 6, 1, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 2, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 2, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 2, 2, 0 },
            terrain = "lake_retreat_boathouse_north",
        },
        {
            point = { 2, 2, 1 },
            terrain = "lake_retreat_boathouse_roof_north",
        },
        {
            point = { 3, 2, 0 },
            terrain = "forest_thick",
        },
        {
            point = { 4, 2, 0 },
            terrain = "forest_thick",
        },
        {
            point = { 5, 2, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 6, 2, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 3, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 3, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 2, 3, 0 },
            terrain = "forest",
        },
        {
            point = { 3, 3, 0 },
            terrain = "lake_retreat_ground_north",
        },
        {
            point = { 3, 3, 1 },
            terrain = "lake_retreat_z1_north",
        },
        {
            point = { 3, 3, 2 },
            terrain = "lake_retreat_z2_north",
        },
        {
            point = { 3, 3, 3 },
            terrain = "lake_retreat_z3_north",
        },
        {
            point = { 3, 3, 4 },
            terrain = "lake_retreat_z4_north",
        },
        {
            point = { 4, 3, 0 },
            terrain = "forest",
        },
        {
            point = { 5, 3, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 6, 3, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 4, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 4, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 2, 4, 0 },
            terrain = "forest_thick",
        },
        {
            point = { 3, 4, 0 },
            terrain = "forest_thick",
        },
        {
            point = { 4, 4, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 5, 4, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 6, 4, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 5, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 5, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 2, 5, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 3, 5, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 4, 5, 0 },
            terrain = "lake_shore",
        },
        {
            point = { 5, 5, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 6, 5, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 0, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 1, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 2, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 3, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 4, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 5, 6, 0 },
            terrain = "lake_surface",
        },
        {
            point = { 6, 6, 0 },
            terrain = "lake_surface",
        },
    },
    occurrences = ccb.content.is_mod_active("defense_mode") and { 100, 100 } or { 0, 0 },
}
