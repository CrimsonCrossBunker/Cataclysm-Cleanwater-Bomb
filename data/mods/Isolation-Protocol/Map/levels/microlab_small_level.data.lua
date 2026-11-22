local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "iso_msl",
    root = "surface",
    locations = { "iso_nether" },
    flags = { "ISO_MAP" },
    occurrences = { 4, 4 },
    city_sizes = { 0, -1 },
    city_distance = { 0, -1 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 4, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 3, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 2, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 1, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { -4, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { -3, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { -2, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { -1, 0, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, -4, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, -3, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, -2, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, -1, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, 4, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, 3, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, 2, -1 },
            locations = { "iso_nether" },
        },
        {
            point = { 0, 1, -1 },
            locations = { "iso_nether" },
        },
    },
    joins = {
        "hallway_to_hallway",
        "duct_to_surface",
        { id = "hallway_to_microlab", opposite = "microlab_to_hallway" },
        { id = "microlab_to_hallway", opposite = "hallway_to_microlab" },
        "microlab_to_microlab",
    },
    overmaps = {
        surface = {
            overmap = "nether_glass_impassable_north",
            locations = { "iso_nether" },
            below = "duct_to_surface",
        },
        iso_elevator = { overmap = "iso_elevator_north", north = "hallway_to_hallway", above = "duct_to_surface" },
        iso_next_level_elevator = {
            overmap = "iso_next_level_elevator_north",
            north = { id = "hallway_to_hallway" },
        },
        special_rock = { overmap = "special_rock" },
        nether_glass_impassable = { overmap = "nether_glass_impassable_north" },
        microlab = {
            overmap = "microlab_generic",
            north = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
        },
        microlab_edge = {
            overmap = "microlab_generic_edge",
            north = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
        },
        firebreak = {
            overmap = "microlab_generic_firebreak_north",
            north = "hallway_to_hallway",
            south = "hallway_to_hallway",
        },
        hallway_cross = {
            overmap = "microlab_generic_hallway_nesw",
            north = "hallway_to_hallway",
            south = "hallway_to_hallway",
            east = "hallway_to_hallway",
            west = "hallway_to_hallway",
        },
        hallway_straight = {
            overmap = "microlab_generic_hallway_ns",
            north = "hallway_to_hallway",
            south = "hallway_to_hallway",
            east = "hallway_to_microlab",
            west = "hallway_to_microlab",
        },
        hallway_curve = {
            overmap = "microlab_generic_hallway_ne",
            north = "hallway_to_hallway",
            south = "hallway_to_microlab",
            east = "hallway_to_hallway",
            west = "hallway_to_microlab",
        },
        hallway_end = {
            overmap = "microlab_generic_hallway_end_south",
            north = "hallway_to_hallway",
            south = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "hallway_to_microlab" },
            },
            east = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "hallway_to_microlab" },
            },
            west = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "hallway_to_microlab" },
            },
        },
        hallway_blind_end = {
            overmap = "microlab_generic_hallway_blind_end_north",
            north = { id = "hallway_to_hallway" },
        },
        rock_divisor = {
            overmap = "special_rock",
            north = "microlab_to_microlab",
            south = "microlab_to_microlab",
            east = { id = "microlab_to_microlab", type = "available" },
            west = { id = "microlab_to_microlab", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "iso_elevator", max = 1 },
        },
        {
            { overmap = "hallway_straight", max = 4 },
        },
        {
            {
                overmap = "hallway_curve",
                max = {
                    poisson = 0.5,
                    bounds = { 0, 1 },
                },
            },
        },
        {
            {
                overmap = "hallway_straight",
                max = {
                    poisson = 0.7,
                    bounds = { 1, 3 },
                },
            },
        },
        {
            {
                overmap = "hallway_cross",
                max = {
                    poisson = 0.5,
                    bounds = { 0, 1 },
                },
            },
        },
        {
            {
                overmap = "hallway_straight",
                max = { poisson = 3 },
            },
        },
        {
            { overmap = "iso_next_level_elevator", max = 1 },
        },
        {
            { overmap = "hallway_end", weight = 1 },
        },
        {
            { overmap = "microlab", max = 20 },
        },
        {
            { overmap = "microlab_edge", weight = 1 },
        },
        {
            { overmap = "rock_divisor", weight = 1 },
        },
    },
}
