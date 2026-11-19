local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_end_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_end_vehicles_city", weight = 67 },
                    { id = "null", weight = 33 },
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
                    { id = "24x24_road_end_vehicles_country", weight = 1 },
                    { id = "null", weight = 39 },
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
    id = "24x24_road_end_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_south", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_end_vehicles_city",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_wrecks_south", weight = 264 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 528 },
                    { id = "24x24_road_vehicles_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_straight_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_straight_vehicles_city", weight = 67 },
                    { id = "null", weight = 33 },
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
                    { id = "24x24_road_straight_vehicles_country", weight = 1 },
                    { id = "null", weight = 39 },
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
    id = "24x24_bridge_road_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_bridge_road_vehicles_country", weight = 1 },
                    { id = "null", weight = 9 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ground_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_bridgehead_ground_vehicles_country", weight = 1 },
                    { id = "null", weight = 19 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_straight_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_north",
                    "24x24_road_vehicles_country_out_of_fuel_south",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridge_road_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_country_out_of_fuel_north", weight = 396 },
                    { id = "24x24_road_vehicles_country_out_of_fuel_south", weight = 396 },
                    { id = "24x24_road_vehicles_bridge_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ground_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_north", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_straight_vehicles_city",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_wrecks_north", weight = 132 },
                    { id = "24x24_road_vehicles_city_wrecks_south", weight = 132 },
                    { id = "24x24_road_vehicles_city_parked_north", weight = 264 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 264 },
                    { id = "24x24_road_vehicles_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_curved_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_curved_vehicles_city", weight = 67 },
                    { id = "null", weight = 33 },
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
                    { id = "24x24_road_curved_vehicles_country", weight = 1 },
                    { id = "null", weight = 39 },
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
    id = "24x24_road_curved_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_east",
                    "24x24_road_vehicles_country_out_of_fuel_south",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_curved_vehicles_city",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_wrecks_east", weight = 132 },
                    { id = "24x24_road_vehicles_city_wrecks_south", weight = 132 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 264 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 264 },
                    { id = "24x24_road_vehicles_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_tee_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_tee_vehicles_city", weight = 67 },
                    { id = "null", weight = 33 },
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
                    { id = "24x24_road_tee_vehicles_country", weight = 1 },
                    { id = "null", weight = 39 },
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
    id = "24x24_road_tee_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_east",
                    "24x24_road_vehicles_country_out_of_fuel_west",
                    "24x24_road_vehicles_country_out_of_fuel_south",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_tee_vehicles_city",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_wrecks_east", weight = 88 },
                    { id = "24x24_road_vehicles_city_wrecks_south", weight = 88 },
                    { id = "24x24_road_vehicles_city_wrecks_west", weight = 88 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 176 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 176 },
                    { id = "24x24_road_vehicles_city_parked_west", weight = 176 },
                    { id = "24x24_road_vehicles_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_four_way_crossroad_vehicles",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_four_way_crossroad_vehicles_city", weight = 67 },
                    { id = "null", weight = 33 },
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
                    { id = "24x24_road_four_way_crossroad_vehicles_country", weight = 1 },
                    { id = "null", weight = 39 },
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
    id = "24x24_road_four_way_crossroad_vehicles_country",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_north",
                    "24x24_road_vehicles_country_out_of_fuel_south",
                    "24x24_road_vehicles_country_out_of_fuel_east",
                    "24x24_road_vehicles_country_out_of_fuel_west",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_four_way_crossroad_vehicles_city",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_wrecks_north", weight = 66 },
                    { id = "24x24_road_vehicles_city_wrecks_south", weight = 66 },
                    { id = "24x24_road_vehicles_city_wrecks_east", weight = 66 },
                    { id = "24x24_road_vehicles_city_wrecks_west", weight = 66 },
                    { id = "24x24_road_vehicles_city_parked_north", weight = 132 },
                    { id = "24x24_road_vehicles_city_parked_south", weight = 132 },
                    { id = "24x24_road_vehicles_city_parked_east", weight = 132 },
                    { id = "24x24_road_vehicles_city_parked_west", weight = 132 },
                    { id = "24x24_road_vehicles_special", weight = 12 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_north_north_facing",
                    "24x24_road_vehicles_country_out_of_fuel_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_east_east_facing",
                    "24x24_road_vehicles_country_out_of_fuel_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_south_north_facing",
                    "24x24_road_vehicles_country_out_of_fuel_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_country_out_of_fuel_west_east_facing",
                    "24x24_road_vehicles_country_out_of_fuel_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_north_north_facing", x = 0, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_north_south_facing", x = 0, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_west_east_facing", x = 7, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_country_out_of_fuel_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_country_out_of_fuel_west_west_facing", x = 7, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_wrecks_north_north_facing",
                    "24x24_road_vehicles_city_wrecks_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_wrecks_east_east_facing",
                    "24x24_road_vehicles_city_wrecks_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_wrecks_south_north_facing",
                    "24x24_road_vehicles_city_wrecks_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_wrecks_west_east_facing",
                    "24x24_road_vehicles_city_wrecks_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_north_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_north_north_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_city_parked_north_north_facing", x = { 1, 2 }, y = 2 },
            { id = "24x24_road_vehicles_city_parked_north_north_facing", x = 0, y = { 0, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_north_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_north_south_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_city_parked_north_south_facing", x = { 1, 2 }, y = 2 },
            { id = "24x24_road_vehicles_city_parked_north_south_facing", x = 0, y = { 0, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_east_east_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_city_parked_east_east_facing", x = 2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_city_parked_east_east_facing", x = { 0, 2 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_east_west_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_city_parked_east_west_facing", x = 2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_city_parked_east_west_facing", x = { 0, 2 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_south_north_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_city_parked_south_north_facing", x = { 1, 2 }, y = -2 },
            { id = "24x24_road_vehicles_city_parked_south_north_facing", x = 0, y = { -2, 0 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_south_south_facing", x = { -2, -1 }, y = 0 },
            { id = "24x24_road_vehicles_city_parked_south_south_facing", x = { 1, 2 }, y = -2 },
            { id = "24x24_road_vehicles_city_parked_south_south_facing", x = 0, y = { -2, 0 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_west_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_west_east_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_city_parked_west_east_facing", x = -2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_city_parked_west_east_facing", x = { -2, 0 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_wrecks_west_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            { id = "24x24_road_vehicles_city_parked_west_west_facing", x = 0, y = { -2, -1 } },
            { id = "24x24_road_vehicles_city_parked_west_west_facing", x = -2, y = { 1, 2 } },
            { id = "24x24_road_vehicles_city_parked_west_west_facing", x = { -2, 0 }, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_north",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_parked_north_north_facing",
                    "24x24_road_vehicles_city_parked_north_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_east",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_parked_east_east_facing",
                    "24x24_road_vehicles_city_parked_east_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_south",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_parked_south_north_facing",
                    "24x24_road_vehicles_city_parked_south_south_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_west",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_parked_west_east_facing",
                    "24x24_road_vehicles_city_parked_west_west_facing",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_south_north_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_city_parked_north_north_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_south_south_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_city_parked_north_south_facing", x = 0, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_east_east_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_city_parked_west_east_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_parked_east_west_facing",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_city_parked_west_west_facing", x = 12, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_special",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    { id = "24x24_road_vehicles_city_jack-knifed_semi", weight = 15 },
                    { id = "24x24_road_vehicles_city_vehicle_pileup", weight = 4 },
                    { id = "24x24_road_vehicles_city_policecar_pileup", weight = 1 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_bridge_special",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = { { id = "24x24_road_vehicles_bridge_semi_crash", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_city_jack-knifed_semi",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_city_jack-knifed_semi_north",
                    "24x24_road_vehicles_city_jack-knifed_semi_east",
                    "24x24_road_vehicles_city_jack-knifed_semi_south",
                    "24x24_road_vehicles_city_jack-knifed_semi_west",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_vehicles_bridge_semi_crash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = {
                    "24x24_road_vehicles_bridge_semi_crash_north",
                    "24x24_road_vehicles_bridge_semi_crash_south",
                },
                x = 0,
                y = 0,
            },
        },
    },
}
