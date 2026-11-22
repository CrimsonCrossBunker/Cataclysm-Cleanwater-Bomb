local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "homeless_camp_mutable",
    root = "camp_core",
    locations = { "forest" },
    flags = { "CLASSIC", "WILDERNESS", "MAN_MADE" },
    occurrences = { 0, 3 },
    city_sizes = { 6, -1 },
    city_distance = { 0, 24 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "forest" },
        },
        {
            point = { 1, 0, 0 },
            locations = { "forest" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "forest" },
        },
        {
            point = { -1, 0, 0 },
            locations = { "forest" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "forest" },
        },
    },
    joins = { "camp_to_camp" },
    overmaps = {
        camp_core = {
            overmap = "homelesscamp_north",
            north = "camp_to_camp",
            south = "camp_to_camp",
            east = "camp_to_camp",
            west = "camp_to_camp",
        },
        camp_edge = {
            overmap = "homelesscamp_north",
            north = "camp_to_camp",
            south = { id = "camp_to_camp", type = "available" },
            east = { id = "camp_to_camp", type = "available" },
            west = { id = "camp_to_camp", type = "available" },
        },
        camp_tee = {
            overmap = "homelesscamp_north",
            north = "camp_to_camp",
            south = "camp_to_camp",
            east = "camp_to_camp",
        },
        derelict = { overmap = "derelict_property_north", north = "camp_to_camp" },
        derelict_roof = { overmap = "derelict_property_roof_north" },
        camp_corner = { overmap = "homelesscamp_north", north = "camp_to_camp", east = "camp_to_camp" },
    },
    phases = {
        {
            { overmap = "camp_core", max = 1 },
        },
        {
            { overmap = "camp_edge", weight = 120 },
            { overmap = "camp_tee", weight = 33 },
            {
                weight = 20,
                chunk = {
                    {
                        overmap = "derelict",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "derelict_roof",
                        pos = { 0, 0, 1 },
                    },
                },
            },
            { overmap = "camp_corner", weight = 33 },
        },
    },
}
