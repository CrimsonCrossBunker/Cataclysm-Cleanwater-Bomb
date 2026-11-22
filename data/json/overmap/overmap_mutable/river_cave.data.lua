local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "river_cave",
    root = "surface",
    locations = { "subterranean_empty", "land", "lake_shore" },
    flags = { "LAKE", "WILDERNESS" },
    occurrences = { 0, 3 },
    spawns = {
        group = "GROUP_KRAKEN_SURFACE",
        population = { 100, 200 },
        radius = { 3, 5 },
    },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "lake_shore" },
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
            into_locations = { "lake_shore" },
        },
        "tunnel_to_tunnel",
    },
    overmaps = {
        surface = {
            overmap = "c_cave_entrance_north",
            locations = { "lake_shore" },
            below = "surface_to_tunnel",
        },
        below_entrance = {
            overmap = "river_cave_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
            above = "tunnel_to_surface",
        },
        crossroads = {
            overmap = "river_cave_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
        },
        tee = {
            overmap = "river_cave_nes",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        straight_tunnel = { overmap = "river_cave_ns", north = "tunnel_to_tunnel", south = "tunnel_to_tunnel" },
        corner = { overmap = "river_cave_ne", north = "tunnel_to_tunnel", east = "tunnel_to_tunnel" },
        dead_end = { overmap = "river_cave_end_south", north = "tunnel_to_tunnel" },
        queen = { overmap = "river_cave_kraken_north", north = "tunnel_to_tunnel" },
        nest = { overmap = "river_cave_nest_north", north = "tunnel_to_tunnel" },
        food = { overmap = "river_cave_food_north", north = "tunnel_to_tunnel" },
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
                overmap = "nest",
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
