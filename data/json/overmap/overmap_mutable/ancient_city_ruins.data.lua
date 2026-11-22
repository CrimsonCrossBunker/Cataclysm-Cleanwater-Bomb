local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "mutable_highland_ruins",
    root = "road_straight_core",
    locations = { "land", "open_air" },
    flags = { "HIGHLANDS", "MAN_MADE", "EXTRADIMENSIONAL" },
    occurrences = { 0, 2 },
    city_sizes = { 0, -1 },
    city_distance = { 0, -1 },
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
    joins = { "ruin_to_ruin", "road_to_road" },
    overmaps = {
        road_straight_core = {
            overmap = "highland_road_ns",
            locations = { "nether" },
            north = "road_to_road",
            south = "road_to_road",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        road_straight = { overmap = "highland_road_ns", north = "road_to_road", south = "road_to_road" },
        road_curve = { overmap = "highland_road_ne", north = "road_to_road", east = "road_to_road" },
        road_end = { overmap = "highland_road_end_north", north = "road_to_road" },
        gate = { overmap = "conquerors_road_north", south = "road_to_road" },
        gate_roof = { overmap = "conquerors_road_above_north" },
        gate_roof_2 = { overmap = "conquerors_road_above_1_north" },
        gate_top = { overmap = "conquerors_road_top_north" },
        ruin_core = {
            overmap = "highland_ruins_north",
            north = "ruin_to_ruin",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        ruin_line = { overmap = "highland_ruins_north", north = "ruin_to_ruin", south = "ruin_to_ruin" },
        ruin_termination = {
            overmap = "highland_ruins_north",
            north = { id = "ruin_to_ruin", type = "available" },
            south = { id = "ruin_to_ruin", type = "available" },
            east = { id = "ruin_to_ruin", type = "available" },
            west = { id = "ruin_to_ruin", type = "available" },
        },
    },
    phases = {
        {
            {
                name = "gate_chunk",
                chunk = {
                    {
                        overmap = "gate",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "gate_roof",
                        pos = { 0, 0, 1 },
                    },
                    {
                        overmap = "gate_roof_2",
                        pos = { 0, 0, 2 },
                    },
                    {
                        overmap = "gate_roof_2",
                        pos = { 0, 0, 3 },
                    },
                    {
                        overmap = "gate_roof_2",
                        pos = { 0, 0, 4 },
                    },
                    {
                        overmap = "gate_top",
                        pos = { 0, 0, 5 },
                    },
                },
                max = 1,
            },
        },
        {
            { overmap = "road_straight_core", max = 6 },
            { overmap = "road_straight", max = 4 },
        },
        {
            {
                overmap = "road_curve",
                max = {
                    poisson = 1.5,
                    bounds = { 0, 1 },
                },
            },
            { overmap = "road_straight", max = 30 },
        },
        {
            { overmap = "road_end", max = 2 },
        },
        {
            { overmap = "ruin_core", max = 3 },
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

ccb.content.define_mutable_overmap_special {
    id = "mutable_imperial_road_ruins",
    root = "ruin_core",
    locations = { "nether" },
    flags = { "MAN_MADE", "EXTRADIMENSIONAL", "IMPERIAL_ROAD" },
    occurrences = { 0, 4 },
    city_sizes = { 0, -1 },
    city_distance = { 0, -1 },
    check_for_locations = {
        {
            point = { 0, 0, 0 },
            locations = { "nether" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "nether" },
        },
        {
            point = { 1, 0, 0 },
            locations = { "nether" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "nether" },
        },
        {
            point = { -1, 0, 0 },
            locations = { "nether" },
        },
    },
    joins = { "ruin_to_ruin" },
    overmaps = {
        ruin_core = {
            overmap = "highland_ruins_north",
            north = "ruin_to_ruin",
            south = "ruin_to_ruin",
            east = "ruin_to_ruin",
            west = "ruin_to_ruin",
        },
        ruin_line = { overmap = "highland_ruins_north", north = "ruin_to_ruin", south = "ruin_to_ruin" },
        ruin_termination = {
            overmap = "highland_ruins_north",
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
