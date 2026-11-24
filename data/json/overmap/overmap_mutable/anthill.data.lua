local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "Anthill",
    occurrences = { 0, 0 },
    tiles = {},
}

ccb.content.define_fixed_overmap_special {
    id = "Acid Anthill",
    occurrences = { 0, 0 },
    tiles = {},
}

ccb.content.define_mutable_overmap_special {
    id = "anthill",
    root = "surface",
    locations = { "subterranean_empty" },
    flags = { "ANT", "OVERMAP_UNIQUE", "WILDERNESS" },
    occurrences = { 3, 5 },
    city_distance = { 10, -1 },
    spawns = {
        group = "GROUP_ANT_SURFACE",
        population = { 1000, 2000 },
        radius = { 10, 30 },
    },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "land", "agricultural" },
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
            into_locations = { "land", "agricultural" },
        },
        "tunnel_to_tunnel",
    },
    overmaps = {
        surface = {
            overmap = "anthill_north",
            locations = { "land", "agricultural" },
            below = "surface_to_tunnel",
        },
        below_entrance = {
            overmap = "ants_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
            above = "tunnel_to_surface",
        },
        crossroads = {
            overmap = "ants_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
        },
        tee = {
            overmap = "ants_nes",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        straight_tunnel = { overmap = "ants_ns", north = "tunnel_to_tunnel", south = "tunnel_to_tunnel" },
        corner = { overmap = "ants_ne", north = "tunnel_to_tunnel", east = "tunnel_to_tunnel" },
        dead_end = { overmap = "ants_end_south", north = "tunnel_to_tunnel" },
        queen = { overmap = "ants_queen_north", north = "tunnel_to_tunnel" },
        larvae = { overmap = "ants_larvae_north", north = "tunnel_to_tunnel" },
        food = { overmap = "ants_food_north", north = "tunnel_to_tunnel" },
        farm = { overmap = "ants_fungus_colony_north", north = "tunnel_to_tunnel" },
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
                overmap = "farm",
                max = { poisson = 10 },
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

ccb.content.define_mutable_overmap_special {
    id = "acid_anthill",
    root = "surface",
    locations = { "subterranean_empty" },
    flags = { "ANT", "OVERMAP_UNIQUE", "WILDERNESS" },
    occurrences = { 2, 5 },
    city_distance = { 10, -1 },
    spawns = {
        group = "GROUP_ACID_ANT_SURFACE",
        population = { 1000, 2000 },
        radius = { 10, 30 },
    },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "land", "agricultural" },
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
            into_locations = { "land", "agricultural" },
        },
        "tunnel_to_tunnel",
    },
    overmaps = {
        surface = {
            overmap = "anthill_north",
            locations = { "land", "agricultural" },
            below = "surface_to_tunnel",
        },
        below_entrance = {
            overmap = "acid_ants_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
            above = "tunnel_to_surface",
        },
        crossroads = {
            overmap = "acid_ants_nesw",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
            west = "tunnel_to_tunnel",
        },
        tee = {
            overmap = "acid_ants_nes",
            north = "tunnel_to_tunnel",
            south = "tunnel_to_tunnel",
            east = "tunnel_to_tunnel",
        },
        straight_tunnel = { overmap = "acid_ants_ns", north = "tunnel_to_tunnel", south = "tunnel_to_tunnel" },
        corner = { overmap = "acid_ants_ne", north = "tunnel_to_tunnel", east = "tunnel_to_tunnel" },
        dead_end = { overmap = "acid_ants_end_south", north = "tunnel_to_tunnel" },
        queen = { overmap = "acid_ants_queen_north", north = "tunnel_to_tunnel" },
        larvae = { overmap = "acid_ants_larvae_north", north = "tunnel_to_tunnel" },
        food = { overmap = "acid_ants_food_north", north = "tunnel_to_tunnel" },
        farm = { overmap = "acid_ants_fungus_colony_north", north = "tunnel_to_tunnel" },
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
                overmap = "farm",
                max = { poisson = 10 },
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
