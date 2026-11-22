local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "iso_mslc",
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
    joins = {
        "hallway_to_hallway",
        "duct_to_surface",
        "duct_to_entrance",
        { id = "hallway_to_microlab", opposite = "microlab_to_hallway" },
        { id = "microlab_to_hallway", opposite = "hallway_to_microlab" },
        "microlab_to_microlab",
        "microlab_entry_to_station",
        "microlab_station_to_subway",
    },
    overmaps = {
        surface = {
            overmap = "nether_glass_impassable_north",
            locations = { "iso_nether" },
            below = "duct_to_surface",
        },
        closing_chunk = {
            overmap = "iso_elevator_microlab_embed_next_north",
            north = "microlab_to_hallway",
            south = { id = "microlab_to_hallway", type = "available" },
            east = { id = "microlab_to_hallway", type = "available" },
            west = { id = "microlab_to_hallway", type = "available" },
        },
        microlab = {
            overmap = "microlab_generic",
            north = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                alternatives = { "microlab_to_hallway" },
            },
        },
        microlab_edge = {
            overmap = "microlab_generic_edge",
            north = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
        },
        microlab_subhallway = {
            overmap = "mlb_generic_subhallway_north",
            north = "microlab_to_microlab",
            south = "hallway_to_microlab",
        },
        iso_elevator = {
            overmap = "iso_elevator_microlab_embed_north",
            north = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            above = "duct_to_surface",
        },
        iso_next_level_elevator = {
            overmap = "iso_elevator_microlab_embed_next_north",
            north = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            south = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            east = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
            west = {
                id = "microlab_to_microlab",
                type = "available",
                alternatives = { "microlab_to_hallway" },
            },
        },
    },
    phases = {
        {
            {
                name = "start_chunk",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 2, 0 },
                    },
                    {
                        overmap = "iso_elevator",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                },
                max = 1,
            },
        },
        {
            {
                name = "microlab_chunk",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                },
                max = 1,
            },
        },
        {
            {
                name = "microlab_chunk_1",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                    {
                        overmap = "microlab_subhallway",
                        pos = { 2, 0, 0 },
                        rot = "west",
                    },
                },
                max = 1,
            },
        },
        {
            {
                name = "microlab_chunkk_2",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                },
                max = { poisson = 2 },
            },
        },
        {
            {
                name = "microlab_chunk_1",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                    {
                        overmap = "microlab_subhallway",
                        pos = { 2, 0, 0 },
                        rot = "west",
                    },
                },
                max = { poisson = 0.5 },
            },
        },
        {
            {
                name = "microlab_chunkk_2",
                chunk = {
                    {
                        overmap = "microlab_subhallway",
                        pos = { 0, 1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                },
                max = { poisson = 2 },
            },
        },
        {
            {
                name = "microlab_final_chunk",
                chunk = {
                    {
                        overmap = "microlab_edge",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 0, -1, 0 },
                    },
                    {
                        overmap = "iso_next_level_elevator",
                        pos = { 1, -1, 0 },
                    },
                    {
                        overmap = "microlab_edge",
                        pos = { 1, 0, 0 },
                    },
                },
                max = 10,
            },
        },
        {
            { overmap = "closing_chunk", weight = 1 },
        },
    },
}
