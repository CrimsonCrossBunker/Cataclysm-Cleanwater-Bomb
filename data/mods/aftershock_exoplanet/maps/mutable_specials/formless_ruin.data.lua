local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "mutable_ruinfield",
    root = "ruin_core",
    locations = { "land" },
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
        ruin_core = {
            overmap = "afs_formless_ruins_dynamic_north",
            north = "ruin_to_ruin",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        ruin_line = { overmap = "afs_formless_ruins_dynamic_north", north = "ruin_to_ruin", south = "ruin_to_ruin" },
        ruin_termination = {
            overmap = "afs_formless_ruins_dynamic_north",
            north = { id = "ruin_to_ruin", type = "available" },
            south = { id = "ruin_to_ruin", type = "available" },
            east = { id = "ruin_to_ruin", type = "available" },
            west = { id = "ruin_to_ruin", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "ruin_core", max = 1 },
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
