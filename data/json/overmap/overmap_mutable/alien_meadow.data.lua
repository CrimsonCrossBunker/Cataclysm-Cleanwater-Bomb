local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "alien_meadow_mutable",
    root = "alien_meadow_core",
    locations = { "field_no_meadow" },
    flags = { "WILDERNESS", "GLOBALLY_UNIQUE" },
    occurrences = { 20, 100 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { 2, 2, 0 },
            to = { -2, -2, 0 },
            locations = { "field_no_meadow" },
        },
    },
    joins = { "alien_meadow_to_alien_meadow" },
    overmaps = {
        alien_meadow_core = {
            overmap = "alien_meadow_core",
            north = "alien_meadow_to_alien_meadow",
            south = "alien_meadow_to_alien_meadow",
            east = "alien_meadow_to_alien_meadow",
            west = "alien_meadow_to_alien_meadow",
        },
        alien_meadow_join = {
            overmap = "alien_meadow_join",
            north = "alien_meadow_to_alien_meadow",
            south = "alien_meadow_to_alien_meadow",
            east = "alien_meadow_to_alien_meadow",
            west = "alien_meadow_to_alien_meadow",
        },
        alien_meadow_end = { overmap = "alien_meadow_end_north", north = "alien_meadow_to_alien_meadow" },
        alien_meadow_fill = {
            overmap = "alien_meadow_end_north",
            north = { id = "alien_meadow_to_alien_meadow", type = "available" },
            east = { id = "alien_meadow_to_alien_meadow", type = "available" },
            west = { id = "alien_meadow_to_alien_meadow", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "alien_meadow_join", weight = 500 },
            { overmap = "alien_meadow_end", weight = 50 },
            { overmap = "alien_meadow_fill", weight = 1 },
        },
    },
}
