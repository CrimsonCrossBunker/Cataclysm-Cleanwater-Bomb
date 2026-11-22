local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "termitemound",
    root = "surface",
    locations = { "subterranean_empty" },
    flags = { "OVERMAP_UNIQUE", "CLASSIC", "WILDERNESS" },
    occurrences = { 80, 100 },
    city_distance = { 10, -1 },
    spawns = {
        group = "GROUP_TERMITE_SURFACE",
        population = { 1000, 2000 },
        radius = { 10, 30 },
    },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, 0, 1 },
            locations = { "open_air" },
        },
        {
            point = { 0, 0, -1 },
            locations = { "subterranean_empty" },
        },
        {
            point = { 1, 0, -1 },
            locations = { "subterranean_empty" },
        },
        {
            point = { 0, 1, -1 },
            locations = { "subterranean_empty" },
        },
        {
            point = { -1, 0, -1 },
            locations = { "subterranean_empty" },
        },
        {
            point = { 0, -1, -1 },
            locations = { "subterranean_empty" },
        },
    },
    joins = {
        { id = "surface_to_tunnel", opposite = "tunnel_to_surface" },
        {
            id = "tunnel_to_surface",
            opposite = "surface_to_tunnel",
            into_locations = { "land" },
        },
        "tunnel_to_tunnel",
    },
    overmaps = {
        surface = {
            overmap = "termitemound_north",
            locations = { "land" },
            below = "surface_to_tunnel",
        },
        below_entrance = {
            overmap = "termites_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
            above = "tunnel_to_surface",
        },
        crossroads = {
            overmap = "termites_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
        },
        tee = {
            overmap = "termites_nes",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        straight_tunnel = { overmap = "termites_ns", north = "tunnel_to_tunnel", south = "tunnel_to_tunnel" },
        corner = { overmap = "termites_ne", north = "tunnel_to_tunnel", east = "tunnel_to_tunnel" },
        dead_end = { overmap = "termites_end_south", north = "tunnel_to_tunnel" },
        queen = { overmap = "termites_queen_north", north = "tunnel_to_tunnel" },
        larvae = { overmap = "termites_larvae_north", north = "tunnel_to_tunnel" },
        water = { overmap = "termites_water_north", north = "tunnel_to_tunnel" },
        food = { overmap = "termites_food_north", north = "tunnel_to_tunnel" },
    },
    phases = {
        {
            { overmap = "below_entrance", max = 1 },
        },
        {
            {
                overmap = "straight_tunnel",
                max = { poisson = 20 },
            },
            {
                overmap = "corner",
                max = { poisson = 5 },
            },
            {
                overmap = "tee",
                max = { poisson = 10 },
            },
            {
                overmap = "below_entrance",
                max = { poisson = 0.7 },
            },
        },
        {
            { overmap = "queen", max = 1 },
        },
        {
            {
                overmap = "food",
                max = { poisson = 5 },
            },
            {
                overmap = "larvae",
                max = { poisson = 5 },
            },
            {
                overmap = "water",
                max = { poisson = 5 },
            },
        },
        {
            { overmap = "dead_end", weight = 2000 },
            { overmap = "straight_tunnel", weight = 100 },
            { overmap = "corner", weight = 100 },
            { overmap = "tee", weight = 10 },
            { overmap = "crossroads", weight = 1 },
            { overmap = "surface", weight = 1 },
        },
    },
}
