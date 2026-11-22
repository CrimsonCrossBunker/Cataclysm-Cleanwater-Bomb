local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "string_dimension_field_mutable",
    root = "string_dimension_field_core",
    locations = { "string_dimension_crossroads" },
    flags = { "WILDERNESS", "EXTRADIMENSIONAL", "STRING_DIMENSION" },
    occurrences = { 0, 10 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { 2, 2, 0 },
            to = { -2, -2, 0 },
            locations = { "string_dimension_crossroads" },
        },
    },
    joins = { "string_dimension_field_to_string_dimension_field" },
    overmaps = {
        string_dimension_field_core = {
            overmap = "string_dimension_field_core",
            north = "string_dimension_field_to_string_dimension_field",
            south = "string_dimension_field_to_string_dimension_field",
            east = "string_dimension_field_to_string_dimension_field",
            west = "string_dimension_field_to_string_dimension_field",
        },
        string_dimension_field_end = {
            overmap = "string_dimension_field_end_north",
            north = "string_dimension_field_to_string_dimension_field",
        },
        string_dimension_field_fill = {
            overmap = "string_dimension_field_end_north",
            north = {
                id = "string_dimension_field_to_string_dimension_field",
                type = "available",
            },
            east = {
                id = "string_dimension_field_to_string_dimension_field",
                type = "available",
            },
            west = {
                id = "string_dimension_field_to_string_dimension_field",
                type = "available",
            },
        },
    },
    phases = {
        {
            { overmap = "string_dimension_field_core", weight = 200 },
            { overmap = "string_dimension_field_end", weight = 100 },
            { overmap = "string_dimension_field_fill", weight = 1 },
        },
    },
}
