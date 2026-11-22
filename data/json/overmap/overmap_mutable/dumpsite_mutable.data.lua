local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "dumpsite_mutable",
    root = "dump_core",
    locations = { "field" },
    flags = { "CLASSIC", "MAN_MADE", "WILDERNESS" },
    occurrences = { 0, 3 },
    city_sizes = { 5, -1 },
    city_distance = { 4, 40 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "field" },
        },
        {
            point = { 1, 0, 0 },
            locations = { "field" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "field" },
        },
        {
            point = { -1, 0, 0 },
            locations = { "field" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "field" },
        },
    },
    joins = { "dump_to_dump" },
    overmaps = {
        dump_core = {
            overmap = "dumpsite_north",
            north = "dump_to_dump",
            south = "dump_to_dump",
            east = "dump_to_dump",
            west = "dump_to_dump",
        },
        dump_edge = { overmap = "dumpsite_edge_north", north = "dump_to_dump" },
        dump_field = {
            overmap = "special_field",
            north = "dump_to_dump",
            south = { id = "dump_to_dump", type = "available" },
            east = { id = "dump_to_dump", type = "available" },
            west = { id = "dump_to_dump", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "dump_field", weight = 12 },
            { overmap = "dump_edge", weight = 20 },
            { overmap = "dump_core", weight = 8 },
        },
    },
}
