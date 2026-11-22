local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "meadow_mutable",
    root = "meadow_core",
    locations = { "field_no_meadow" },
    flags = { "WILDERNESS", "CLASSIC" },
    occurrences = { 10, 20 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { 5, 5, 0 },
            to = { -5, -5, 0 },
            locations = { "field_no_meadow" },
        },
    },
    joins = { "meadow_to_meadow" },
    overmaps = {
        meadow_core = {
            overmap = "meadow_core",
            north = "meadow_to_meadow",
            south = "meadow_to_meadow",
            east = "meadow_to_meadow",
            west = "meadow_to_meadow",
        },
        meadow_end = { overmap = "meadow_end_north", north = "meadow_to_meadow" },
        meadow_fill = {
            overmap = "meadow_end_north",
            north = { id = "meadow_to_meadow", type = "available" },
            east = { id = "meadow_to_meadow", type = "available" },
            west = { id = "meadow_to_meadow", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "meadow_core", weight = 2800 },
            { overmap = "meadow_end", weight = 50 },
            { overmap = "meadow_fill", weight = 1000 },
        },
    },
}
