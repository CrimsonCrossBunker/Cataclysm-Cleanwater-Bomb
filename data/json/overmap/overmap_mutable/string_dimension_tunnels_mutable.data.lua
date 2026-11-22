local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "string_dimension_utility_tunnels",
    root = "surface",
    locations = { "string_dimension_crossroads", "string_dimension_true_void" },
    flags = { "EXTRADIMENSIONAL", "STRING_DIMENSION" },
    occurrences = { 0, 4 },
    city_distance = { 0, -1 },
    priority = 3,
    joins = {
        { id = "surface_to_crossroads", opposite = "crossroads_to_surface" },
        { id = "crossroads_to_surface", opposite = "surface_to_crossroads" },
        {
            id = "tunnel_to_tunnel",
            into_locations = { "string_dimension_true_void" },
        },
    },
    overmaps = {
        surface = {
            overmap = "string_dimension_utility_tunnel_entrance_north",
            locations = { "string_dimension_crossroads" },
            below = "surface_to_crossroads",
        },
        crossroads = {
            overmap = "string_dimension_utility_tunnel_four_way_north",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
            above = "crossroads_to_surface",
        },
        tee = {
            overmap = "string_dimension_utility_tunnel_T_north",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        straight_tunnel = {
            overmap = "string_dimension_utility_tunnel_straight_south",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
        },
        corner = {
            overmap = "string_dimension_utility_tunnel_corner_north",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        dead_end = {
            overmap = "string_dimension_utility_tunnel_end_south",
            north = "tunnel_to_tunnel",
        },
    },
    phases = {
        {
            { overmap = "crossroads", max = 1 },
        },
        {
            { overmap = "straight_tunnel", weight = 20 },
            { overmap = "dead_end", weight = 2 },
            { overmap = "corner", weight = 1 },
            { overmap = "tee", weight = 1 },
        },
    },
}
