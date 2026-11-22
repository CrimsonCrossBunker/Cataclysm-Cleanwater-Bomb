local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "xedrawood_ancient_road",
    root = "road_straight",
    locations = { "land", "open_air" },
    flags = { "OVERMAP_UNIQUE" },
    occurrences = { 15, 100 },
    city_sizes = { 0, -1 },
    city_distance = { 0, -1 },
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
            point = { -1, 0, 0 },
            locations = { "land" },
        },
        {
            point = { 0, -1, 0 },
            locations = { "land" },
        },
        {
            point = { 0, 1, 0 },
            locations = { "land" },
        },
    },
    joins = { "road_to_road", "invisible_road", "crossroad_temple" },
    overmaps = {
        road_straight = {
            overmap = "ancient_road_ns",
            locations = { "land" },
            north = "road_to_road",
            south = "road_to_road",
        },
        straight_invisible = { overmap = "field", north = "invisible_road", south = "invisible_road" },
        to_invisible = { overmap = "ancient_road_end_north", north = "road_to_road", south = "invisible_road" },
        road_curve = { overmap = "ancient_road_ne", north = "road_to_road", east = "road_to_road" },
        road_end = { overmap = "ancient_road_end_north", north = "road_to_road" },
        invisible_end = { overmap = "field", south = "invisible_road" },
        no_temple = { overmap = "field", south = "crossroad_temple" },
        road_tee = {
            overmap = "ancient_road_nes",
            north = "road_to_road",
            south = "road_to_road",
            east = "road_to_road",
            west = "crossroad_temple",
        },
        temple = { overmap = "xedrawood_ancient_temple_north", north = "crossroad_temple" },
        temple_roof = { overmap = "xedrawood_ancient_temple_above_north" },
        temple_roof_2 = { overmap = "xedrawood_ancient_temple_above2_north" },
        closing_chunk = {
            overmap = "field",
            north = {
                id = "road_to_road",
                alternatives = { "invisible_road", "crossroad_temple" },
                type = "available",
            },
            south = {
                id = "road_to_road",
                alternatives = { "invisible_road" },
                type = "available",
            },
            east = {
                id = "road_to_road",
                alternatives = { "invisible_road" },
                type = "available",
            },
            west = {
                id = "road_to_road",
                alternatives = { "invisible_road" },
                type = "available",
            },
        },
    },
    phases = {
        {
            { overmap = "road_straight", max = 4 },
        },
        {
            { overmap = "road_straight", max = 80 },
            {
                overmap = "road_curve",
                max = {
                    poisson = 1.5,
                    bounds = { 1, 2 },
                },
            },
            {
                overmap = "road_tee",
                max = {
                    poisson = 1.5,
                    bounds = { 0, 2 },
                },
            },
            { overmap = "straight_invisible", max = 140 },
            {
                overmap = "to_invisible",
                max = {
                    poisson = 1.5,
                    bounds = { 0, 4 },
                },
            },
        },
        {
            { overmap = "no_temple", weight = 2 },
            {
                name = "crossroad_temple_chunk",
                weight = 1,
                chunk = {
                    {
                        overmap = "temple",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "temple_roof",
                        pos = { 0, 0, 1 },
                    },
                    {
                        overmap = "temple_roof_2",
                        pos = { 0, 0, 2 },
                    },
                },
            },
        },
        {
            { overmap = "invisible_end", weight = 100 },
            { overmap = "road_curve", weight = 100 },
            { overmap = "road_tee", weight = 100 },
            { overmap = "closing_chunk", weight = 1 },
            { overmap = "road_end", weight = 100000 },
        },
    },
}
