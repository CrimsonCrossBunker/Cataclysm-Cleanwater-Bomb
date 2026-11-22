local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "dumpsite_mutable",
    root = "dump_core",
    locations = { "land" },
    flags = { "CLASSIC" },
    occurrences = { 0, 3 },
    city_sizes = { 5, -1 },
    city_distance = { 4, 40 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 1, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "land" },
        },
        {
            point = { -1, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "land" },
        },
    },
    joins = { "dump_to_dump" },
    overmaps = {
        dump_core = {
            overmap = "dumpsite_north",
            north = { id = "dump_to_dump" },
            south = { id = "dump_to_dump" },
            east = { id = "dump_to_dump" },
            west = { id = "dump_to_dump" },
        },
        dump_edge = {
            overmap = "dumpsite_edge_north",
            north = "dump_to_dump",
            south = { id = "dump_to_dump", type = "available" },
            east = { id = "dump_to_dump", type = "available" },
            west = { id = "dump_to_dump", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "dump_edge", weight = 33 },
            { overmap = "dump_core", weight = 11 },
        },
    },
}
