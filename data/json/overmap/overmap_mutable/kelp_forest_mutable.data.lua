local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "kelp_forest_mutable",
    root = "root",
    locations = { "ocean_bed" },
    flags = { "OCEAN", "WILDERNESS" },
    occurrences = { 1, 2 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "ocean_surface" },
        },
        {
            point = { 0, 0, 1 },
            locations = { "open_air" },
        },
    },
    check_for_locations_area = {
        {
            from = { 2, 2, 0 },
            to = { -2, -2, 0 },
            locations = { "ocean_surface" },
        },
        {
            from = { 2, 2, -9 },
            to = { -2, -2, -9 },
            locations = { "ocean_bed" },
        },
    },
    joins = { "kelp_to_kelp", "root_to_kelp" },
    overmaps = {
        root = {
            overmap = "ocean_surface",
            locations = { "ocean_surface" },
            above = "root_to_kelp",
        },
        root_to_forest = {
            overmap = "open_air",
            locations = { "open_air" },
            below = "root_to_kelp",
        },
        kelp_forest_core = {
            overmap = "kelp_forest_core",
            north = "kelp_to_kelp",
            south = "kelp_to_kelp",
            east = "kelp_to_kelp",
            west = "kelp_to_kelp",
        },
        kelp_forest_end = { overmap = "kelp_forest_end_north", north = "kelp_to_kelp" },
        kelp_forest_fill = {
            overmap = "kelp_forest_end_north",
            north = { id = "kelp_to_kelp", type = "available" },
            east = { id = "kelp_to_kelp", type = "available" },
            west = { id = "kelp_to_kelp", type = "available" },
        },
    },
    phases = {
        {
            {
                name = "root_to_forest",
                chunk = {
                    {
                        overmap = "root_to_forest",
                        pos = { 0, 0, 1 },
                    },
                    {
                        overmap = "kelp_forest_core",
                        pos = { 0, 0, -9 },
                    },
                },
                max = 1,
            },
        },
        {
            { overmap = "kelp_forest_core", weight = 400 },
            { overmap = "kelp_forest_end", weight = 100 },
            { overmap = "kelp_forest_fill", weight = 1 },
        },
    },
}
