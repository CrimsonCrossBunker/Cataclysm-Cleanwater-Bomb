local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "iso_office",
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
    joins = { "duct_to_surface", "duct_to_entrance", "office_to_office" },
    overmaps = {
        surface = {
            overmap = "nether_glass_impassable_north",
            locations = { "iso_nether" },
            below = "duct_to_surface",
        },
        closing_chunk = {
            overmap = "iso_office",
            north = "office_to_office",
            south = { id = "office_to_office", type = "available" },
            east = { id = "office_to_office", type = "available" },
            west = { id = "office_to_office", type = "available" },
        },
        office = {
            overmap = "iso_office",
            north = { id = "office_to_office" },
            south = { id = "office_to_office" },
        },
        office_3way = {
            overmap = "iso_office",
            north = { id = "office_to_office" },
            south = { id = "office_to_office" },
            east = { id = "office_to_office" },
        },
        iso_elevator = {
            overmap = "iso_elevator_office",
            north = { id = "office_to_office", type = "available" },
            south = { id = "office_to_office", type = "available" },
            east = { id = "office_to_office", type = "available" },
            west = { id = "office_to_office", type = "available" },
            above = "duct_to_surface",
        },
        iso_next_level_elevator = {
            overmap = "iso_elevator_office_next",
            north = { id = "office_to_office", type = "available" },
            south = { id = "office_to_office", type = "available" },
        },
    },
    phases = {
        {
            {
                name = "start_chunk",
                chunk = {
                    {
                        overmap = "iso_elevator",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "office",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "office",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "office",
                        pos = { -1, 0, 0 },
                        rot = "west",
                    },
                    {
                        overmap = "office",
                        pos = { 1, 0, 0 },
                        rot = "east",
                    },
                },
                max = 1,
            },
        },
        {
            { overmap = "office", max = 10 },
            {
                overmap = "office_3way",
                max = {
                    poisson = 4,
                    bounds = { 2, 8 },
                },
            },
        },
        {
            { overmap = "office", max = 10 },
        },
        {
            { overmap = "iso_next_level_elevator", max = 2 },
        },
        {
            { overmap = "closing_chunk", weight = 1 },
        },
    },
}
