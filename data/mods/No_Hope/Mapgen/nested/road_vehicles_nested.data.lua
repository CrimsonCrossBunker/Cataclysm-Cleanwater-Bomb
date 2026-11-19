local ccb = require("ccb")

-- TODO: Should use an external option to disable the vanilla versions rather than 999999 weight
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_end_vehicles",
    weight = 999999,
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_parked_south", weight = 250000 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 1000 },
                    { id = "null", weight = 749000 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
            {
                otherwise = {
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_south", weight = 50000 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 100 },
                    { id = "null", weight = 949900 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_straight_vehicles",
    weight = 999999,
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_parked_north", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_south", weight = 125000 },
                    { id = "24x24_road_vehicles_city_parked_north", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 500 },
                    { id = "null", weight = 749000 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
            {
                otherwise = {
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_north", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_south", weight = 25000 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_north", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 50 },
                    { id = "null", weight = 949900 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_curved_vehicles",
    weight = 999999,
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_parked_east", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_south", weight = 125000 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 500 },
                    { id = "null", weight = 749000 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
            {
                otherwise = {
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_east", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_south", weight = 25000 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_east", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 50 },
                    { id = "null", weight = 949900 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_tee_vehicles",
    weight = 999999,
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_parked_east", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_south", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_west", weight = 125000 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_west", weight = 500 },
                    { id = "null", weight = 1123500 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
            {
                otherwise = {
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_east", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_south", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_west", weight = 25000 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_east", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_west", weight = 50 },
                    { id = "null", weight = 1424850 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_four_way_crossroad_vehicles",
    weight = 999999,
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_parked_north", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_east", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_south", weight = 125000 },
                    { id = "24x24_road_vehicles_wr_city_parked_west", weight = 125000 },
                    { id = "24x24_road_vehicles_city_parked_north", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 500 },
                    { id = "24x24_road_vehicles_city_parked_west", weight = 500 },
                    { id = "null", weight = 1498000 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
            {
                otherwise = {
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_north", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_east", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_south", weight = 25000 },
                    { id = "24x24_road_vehicles_wr_country_out_of_fuel_west", weight = 25000 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_north", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_east", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 50 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_west", weight = 50 },
                    { id = "null", weight = 1899800 },
                },
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SIDEWALK" },
                    north_east = { "SIDEWALK" },
                    east = { "SIDEWALK" },
                    south_east = { "SIDEWALK" },
                    south = { "SIDEWALK" },
                    south_west = { "SIDEWALK" },
                    west = { "SIDEWALK" },
                    north_west = { "SIDEWALK" },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_country_out_of_fuel_north_north_facing",
                    "24x24_road_vehicles_wr_country_out_of_fuel_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_country_out_of_fuel_east_east_facing",
                    "24x24_road_vehicles_wr_country_out_of_fuel_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_country_out_of_fuel_south_north_facing",
                    "24x24_road_vehicles_wr_country_out_of_fuel_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_country_out_of_fuel_west_east_facing",
                    "24x24_road_vehicles_wr_country_out_of_fuel_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_country_out_of_fuel_north_north_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_country_out_of_fuel_north_south_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_country_out_of_fuel_west_east_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_country_out_of_fuel_west_west_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_wrecks_north_north_facing",
                    "24x24_road_vehicles_wr_city_wrecks_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_wrecks_east_east_facing",
                    "24x24_road_vehicles_wr_city_wrecks_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_wrecks_south_north_facing",
                    "24x24_road_vehicles_wr_city_wrecks_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_wrecks_west_east_facing",
                    "24x24_road_vehicles_wr_city_wrecks_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_north_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_north_north_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_wr_city_parked_north_north_facing", x = { 1, 2 }, y = 2 },
            { id = "24x24_road_vehicles_wr_city_parked_north_north_facing", x = 0, y = { 0, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_north_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_north_south_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_wr_city_parked_north_south_facing", x = { 1, 2 }, y = 2 },
            { id = "24x24_road_vehicles_wr_city_parked_north_south_facing", x = 0, y = { 0, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_east_east_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_wr_city_parked_east_east_facing", x = 2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_wr_city_parked_east_east_facing", x = { 0, 2 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_east_west_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_wr_city_parked_east_west_facing", x = 2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_wr_city_parked_east_west_facing", x = { 0, 2 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_south_north_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_wr_city_parked_south_north_facing", x = { 1, 2 }, y = -2 },
            { id = "24x24_road_vehicles_wr_city_parked_south_north_facing", x = 0, y = { -2, 0 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_south_south_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_wr_city_parked_south_south_facing", x = { 1, 2 }, y = -2 },
            { id = "24x24_road_vehicles_wr_city_parked_south_south_facing", x = 0, y = { -2, 0 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_west_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_west_east_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_wr_city_parked_west_east_facing", x = -2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_wr_city_parked_west_east_facing", x = { -2, 0 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_wrecks_west_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_wr_city_parked_west_west_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_wr_city_parked_west_west_facing", x = -2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_wr_city_parked_west_west_facing", x = { -2, 0 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_parked_north_north_facing",
                    "24x24_road_vehicles_wr_city_parked_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_parked_east_east_facing",
                    "24x24_road_vehicles_wr_city_parked_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_parked_south_north_facing",
                    "24x24_road_vehicles_wr_city_parked_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_parked_west_east_facing",
                    "24x24_road_vehicles_wr_city_parked_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_city_parked_north_north_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_city_parked_north_south_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_city_parked_west_east_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_wr_city_parked_west_west_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_special",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_wr_city_jack-knifed_semi", weight = 15 },
                    { id = "24x24_road_vehicles_wr_city_vehicle_pileup", weight = 4 },
                    { id = "24x24_road_vehicles_wr_city_policecar_pileup", weight = 1 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_jack-knifed_semi",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_wr_city_jack-knifed_semi_north",
                    "24x24_road_vehicles_wr_city_jack-knifed_semi_east",
                    "24x24_road_vehicles_wr_city_jack-knifed_semi_south",
                    "24x24_road_vehicles_wr_city_jack-knifed_semi_west",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_north_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "highway", x = { 15, 17 }, y = 5, fuel = -1, status = 1, rotation = 270 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_north_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "highway", x = { 7, 9 }, y = 11, fuel = -1, status = 1, rotation = 90 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_west_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "highway", x = 11, y = { 14, 16 }, fuel = -1, status = 1, rotation = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_country_out_of_fuel_west_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "highway", x = 5, y = { 7, 9 }, fuel = -1, status = 1, rotation = 180 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_north_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            {
                id = "city_vehicles_wr",
                x = { 15, 17 },
                y = 5,
                fuel = -1,
                status = 1,
                rotation = 270,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_north_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "city_vehicles_wr", x = { 7, 9 }, y = 11, fuel = -1, status = 1, rotation = 90 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_west_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "city_vehicles_wr", x = 11, y = { 14, 16 }, fuel = -1, status = 1, rotation = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_parked_west_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = { { id = "city_vehicles_wr", x = 5, y = { 7, 9 }, fuel = -1, status = 1, rotation = 180 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_jack-knifed_semi_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "semi_truck", x = 15, y = 4, fuel = -1, status = 1, rotation = 290 },
            { id = "truck_trailer", x = 18, y = 12, fuel = -1, status = 1, rotation = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_jack-knifed_semi_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "semi_truck", x = 19, y = 15, fuel = -1, status = 1, rotation = 20 },
            { id = "truck_trailer", x = 11, y = 18, fuel = -1, status = 1, rotation = 110 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_jack-knifed_semi_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "semi_truck", x = 8, y = 19, fuel = -1, status = 1, rotation = 110 },
            { id = "truck_trailer", x = 5, y = 11, fuel = -1, status = 1, rotation = 200 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_jack-knifed_semi_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "semi_truck", x = 4, y = 8, fuel = -1, status = 1, rotation = 200 },
            { id = "truck_trailer", x = 12, y = 5, fuel = -1, status = 1, rotation = 290 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_vehicle_pileup",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "city_pileup", x = 12, y = 8, fuel = -1, status = 1, rotation = 270 },
            { id = "city_pileup", x = 8, y = 12, fuel = -1, status = 1, rotation = 0 },
            { id = "city_pileup", x = 12, y = 16, fuel = -1, status = 1, rotation = 90 },
            { id = "city_pileup", x = 15, y = 12, fuel = -1, status = 1, rotation = 180 },
            { id = "city_pileup", x = 12, y = 12, fuel = -1, status = 1, rotation = 270 },
            {
                id = "city_pileup",
                x = { 8, 16 },
                y = { 4, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 0,
            },
            {
                id = "city_pileup",
                x = { 8, 16 },
                y = { 4, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 0,
            },
            {
                id = "city_pileup",
                x = { 4, 16 },
                y = { 8, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 90,
            },
            {
                id = "city_pileup",
                x = { 4, 16 },
                y = { 8, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 90,
            },
            {
                id = "city_pileup",
                x = { 4, 15 },
                y = { 4, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 180,
            },
            {
                id = "city_pileup",
                x = { 4, 15 },
                y = { 4, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 180,
            },
            {
                id = "city_pileup",
                x = { 4, 16 },
                y = { 4, 15 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 270,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_wr_city_policecar_pileup",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        vehicle_placements = {
            { id = "police_pileup", x = 12, y = 8, fuel = -1, status = 1, rotation = 270 },
            { id = "police_pileup", x = 8, y = 12, fuel = -1, status = 1, rotation = 0 },
            { id = "police_pileup", x = 12, y = 16, fuel = -1, status = 1, rotation = 90 },
            { id = "police_pileup", x = 16, y = 12, fuel = -1, status = 1, rotation = 180 },
            { id = "police_pileup", x = 12, y = 12, fuel = -1, status = 1, rotation = 270 },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 0,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 0,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 90,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 90,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 180,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 180,
            },
            {
                id = "police_pileup",
                x = { 5, 16 },
                y = { 5, 16 },
                fuel = -1,
                status = 1,
                chance = 50,
                rotation = 270,
            },
        },
    },
}
