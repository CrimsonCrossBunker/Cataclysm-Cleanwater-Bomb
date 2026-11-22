local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "mutable_industy_ruinfield",
    root = "ruin_core",
    locations = { "subterranean_empty", "land", "open_air" },
    flags = { "EXOPLANET" },
    occurrences = { 0, 2 },
    city_sizes = { 0, 20 },
    city_distance = { 10, -1 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "land" },
        },
        {
            point = { 1, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "land" },
        },
        {
            point = { -1, 0, 0 },
            locations = { "land" },
        },
    },
    joins = { "ruin_to_ruin" },
    overmaps = {
        pipe_entrance = {
            overmap = "afs_formless_ruins_dynamic_north",
            north = "ruin_to_ruin",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        ruin_core = {
            overmap = "afs_formless_ruins_industrial_north",
            north = "ruin_to_ruin",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        ruin_line = { overmap = "afs_formless_ruins_industrial_north", north = "ruin_to_ruin", south = "ruin_to_ruin" },
        ruin_termination = {
            overmap = "afs_formless_ruins_industrial_north",
            north = { id = "ruin_to_ruin", type = "available" },
            south = { id = "ruin_to_ruin", type = "available" },
            east = { id = "ruin_to_ruin", type = "available" },
            west = { id = "ruin_to_ruin", type = "available" },
        },
        afs_catalytic_react_r1 = { overmap = "afs_catalytic_react_r1_north" },
        afs_catalytic_react_r2 = { overmap = "afs_catalytic_react_r2_north" },
        afs_catalytic_react_u1 = { overmap = "afs_catalytic_react_u1_north" },
        afs_catalytic_react_u2 = { overmap = "afs_catalytic_react_u2_north" },
        afs_catalytic_react_m1 = { overmap = "afs_catalytic_react_m1_north" },
        afs_catalytic_react_m2 = { overmap = "afs_catalytic_react_m2_north" },
        afs_catalytic_react_g1 = {
            overmap = "afs_catalytic_react_g1_north",
            north = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        afs_catalytic_react_g2 = {
            overmap = "afs_catalytic_react_g2_north",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        afs_catalytic_react_sub1 = { overmap = "afs_catalytic_react_sub1_north" },
        afs_catalytic_react_sub2 = { overmap = "afs_catalytic_react_sub2_north" },
    },
    phases = {
        {
            {
                name = "catalytic",
                chunk = {
                    {
                        overmap = "afs_catalytic_react_g1",
                        pos = { 0, 0, 0 },
                        rot = "north",
                    },
                    {
                        overmap = "afs_catalytic_react_g2",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "afs_catalytic_react_m1",
                        pos = { 0, 0, 1 },
                    },
                    {
                        overmap = "afs_catalytic_react_m2",
                        pos = { 0, 1, 1 },
                    },
                    {
                        overmap = "afs_catalytic_react_u1",
                        pos = { 0, 0, 2 },
                    },
                    {
                        overmap = "afs_catalytic_react_u2",
                        pos = { 0, 1, 2 },
                    },
                    {
                        overmap = "afs_catalytic_react_r1",
                        pos = { 0, 0, 3 },
                    },
                    {
                        overmap = "afs_catalytic_react_r2",
                        pos = { 0, 1, 3 },
                    },
                    {
                        overmap = "afs_catalytic_react_sub1",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "afs_catalytic_react_sub2",
                        pos = { 0, 1, -1 },
                    },
                },
                max = 1,
            },
        },
        {
            { overmap = "ruin_core", max = 2 },
            { overmap = "ruin_line", max = 10 },
        },
        {
            { overmap = "ruin_core", max = 5 },
            { overmap = "ruin_line", max = 10 },
        },
        {
            { overmap = "ruin_termination", weight = 1000 },
        },
    },
}
