local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "hab_unit_central" },
    layout = {
        rows = {
            "########################",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "########################",
        },
        nested = {
            { x = 0, y = 0, id = "11x11_stairs_bloc" },
            { x = 13, y = 0, id = "11x11_communal_showers_s" },
            { x = 0, y = 13, id = "11x11_micro_apartment_n" },
            { x = 13, y = 13, id = "11x11_micro_apartment_n" },
            { x = 11, y = 0, required_flags = { north = { "ROAD" } }, id = "2x2_door_h" },
            { x = 23, y = 11, required_flags = { east = { "ROAD" } }, id = "2x2_door_v" },
            { x = 11, y = 23, required_flags = { south = { "ROAD" } }, id = "2x2_door_h" },
            { x = 0, y = 11, required_flags = { west = { "ROAD" } }, id = "2x2_door_v" },
            { x = 11, y = 0, required_flags = { north = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 22, y = 11, required_flags = { east = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 11, y = 22, required_flags = { south = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 0, y = 11, required_flags = { west = { "SIDEWALK" } }, id = "2x2_walkway" },
        },
        fill_terrain = "t_concrete_light",
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "hab_unit", "shop_unit", "park_unit" },
    layout = {
        rows = {
            "########################",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "#                      #",
            "########################",
        },
        nested = {
            {
                x = 0,
                y = 0,
                any_flags = {
                    north = { "SOURCE_DRINK" },
                    east = { "SOURCE_DRINK" },
                    south = { "SOURCE_DRINK" },
                    west = { "SOURCE_DRINK" },
                },
                id = "11x11_micro_apartment_s",
                otherwise = { "11x11_stairs_bloc" },
            },
            { x = 13, y = 0, id = "11x11_communal_showers_s" },
            { x = 0, y = 13, id = "11x11_micro_apartment_n" },
            { x = 13, y = 13, id = "11x11_micro_apartment_n" },
            { x = 11, y = 0, required_flags = { north = { "ROAD" } }, id = "2x2_door_h" },
            { x = 23, y = 11, required_flags = { east = { "ROAD" } }, id = "2x2_door_v" },
            { x = 11, y = 23, required_flags = { south = { "ROAD" } }, id = "2x2_door_h" },
            { x = 0, y = 11, required_flags = { west = { "ROAD" } }, id = "2x2_door_v" },
            { x = 11, y = 0, required_flags = { north = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 22, y = 11, required_flags = { east = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 11, y = 22, required_flags = { south = { "SIDEWALK" } }, id = "2x2_walkway" },
            { x = 0, y = 11, required_flags = { west = { "SIDEWALK" } }, id = "2x2_walkway" },
        },
        fill_terrain = "t_concrete_light",
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_stairs_bloc",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#         #",
            "#         #",
            "#         #",
            "#      ####",
            "#      #   ",
            "#      #   ",
            "#      #   ",
            "#      #   ",
            "#      #   ",
            "########   ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { x = 0, y = 0, choices = { "11x11_stairs_bloc_janitor", "11x11_stairs_bloc_storage" } },
            { x = 7, y = 4, id = "7x7_stairwell" },
        },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_stairs_bloc_janitor",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#====# #TTc",
            "#    + # hc",
            "#====# +  c",
            "###### ####",
            "#====# #   ",
            "#    + #   ",
            "#=  =# #   ",
            "#=  =# #   ",
            "#====# #   ",
            "######+#   ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_stairs_bloc_storage",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#=#=#=#=#=#",
            "#+#+#+#+#+#",
            "#         #",
            "#####  ####",
            "#=#=#  #   ",
            "#+#+#  #   ",
            "#      #   ",
            "#+#+#  #   ",
            "#=#=#  #   ",
            "#####++#   ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_n",
    layout = {
        size = { width = 11, height = 11 },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, id = "11x11_micro_apartment_v" }, { x = 5, y = 0, id = "1x1_door" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_s",
    layout = {
        size = { width = 11, height = 11 },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, id = "11x11_micro_apartment_v" }, { x = 5, y = 10, id = "1x1_door" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_v",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#$%3+ +3%$#",
            "##### #####",
            "#$%3+ +3%$#",
            "##### #####",
            "#$%3+ +3%$#",
            "##### #####",
            "#$%3+ +3%$#",
            "##### #####",
            "#$%3+ +3%$#",
            "###########",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { x = 1, y = 1, id = "2x2_micro_apartment_furniture_w" },
            { x = 1, y = 3, id = "2x2_micro_apartment_furniture_w" },
            { x = 1, y = 5, id = "2x2_micro_apartment_furniture_w" },
            { x = 1, y = 7, id = "2x2_micro_apartment_furniture_w" },
            { x = 1, y = 9, id = "2x2_micro_apartment_furniture_w" },
            { x = 8, y = 1, id = "2x2_micro_apartment_furniture_e" },
            { x = 8, y = 3, id = "2x2_micro_apartment_furniture_e" },
            { x = 8, y = 5, id = "2x2_micro_apartment_furniture_e" },
            { x = 8, y = 7, id = "2x2_micro_apartment_furniture_e" },
            { x = 8, y = 9, id = "2x2_micro_apartment_furniture_e" },
        },
        zone_placements = {
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 1, 3 }, y = 1 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 7, 9 }, y = 1 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 1, 3 }, y = 3 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 7, 9 }, y = 3 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 1, 3 }, y = 5 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 7, 9 }, y = 5 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 1, 3 }, y = 7 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 7, 9 }, y = 7 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 1, 3 }, y = 9 },
            { id = "ZONE_START_POINT", faction = "your_followers", x = { 7, 9 }, y = 9 },
        },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_e",
    layout = {
        size = { width = 11, height = 11 },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, id = "11x11_micro_apartment_h" }, { x = 10, y = 5, id = "1x1_door" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_w",
    layout = {
        size = { width = 11, height = 11 },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, id = "11x11_micro_apartment_h" }, { x = 0, y = 5, id = "1x1_door" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_micro_apartment_h",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#$#$#$#$#$#",
            "#%#%#%#%#%#",
            "#3#3#3#3#3#",
            "#+#+#+#+#+#",
            "#         #",
            "#+#+#+#+#+#",
            "#3#3#3#3#3#",
            "#%#%#%#%#%#",
            "#$#$#$#$#$#",
            "###########",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { x = 1, y = 1, id = "2x2_micro_apartment_furniture_s" },
            { x = 3, y = 1, id = "2x2_micro_apartment_furniture_s" },
            { x = 5, y = 1, id = "2x2_micro_apartment_furniture_s" },
            { x = 7, y = 1, id = "2x2_micro_apartment_furniture_s" },
            { x = 9, y = 1, id = "2x2_micro_apartment_furniture_s" },
            { x = 1, y = 8, id = "2x2_micro_apartment_furniture_n" },
            { x = 3, y = 8, id = "2x2_micro_apartment_furniture_n" },
            { x = 5, y = 8, id = "2x2_micro_apartment_furniture_n" },
            { x = 7, y = 8, id = "2x2_micro_apartment_furniture_n" },
            { x = 9, y = 8, id = "2x2_micro_apartment_furniture_n" },
        },
        zone_placements = {
            { id = "ZONE_START_POINT", faction = "your_followers", x = 1, y = { 1, 3 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 1, y = { 7, 9 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 3, y = { 1, 3 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 3, y = { 7, 9 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 5, y = { 1, 3 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 5, y = { 7, 9 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 7, y = { 1, 3 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 7, y = { 7, 9 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 9, y = { 1, 3 } },
            { id = "ZONE_START_POINT", faction = "your_followers", x = 9, y = { 7, 9 } },
        },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_micro_apartment_furniture_n",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "2 ",
            "1 ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        parameters = {
            micro_apartment_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "micro_apartment_palette_bed",
                        "micro_apartment_palette_shower",
                        "micro_apartment_palette_null",
                    },
                },
                scope = "nested",
            },
        },
        palettes = { { parameter = "micro_apartment_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_micro_apartment_furniture_s",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "1 ",
            "2 ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        parameters = {
            micro_apartment_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "micro_apartment_palette_bed",
                        "micro_apartment_palette_shower",
                        "micro_apartment_palette_null",
                    },
                },
                scope = "nested",
            },
        },
        palettes = { { parameter = "micro_apartment_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_micro_apartment_furniture_w",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "12",
            "  ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        parameters = {
            micro_apartment_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "micro_apartment_palette_bed",
                        "micro_apartment_palette_shower",
                        "micro_apartment_palette_null",
                    },
                },
                scope = "nested",
            },
        },
        palettes = { { parameter = "micro_apartment_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_micro_apartment_furniture_e",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "21",
            "  ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        parameters = {
            micro_apartment_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "micro_apartment_palette_bed",
                        "micro_apartment_palette_shower",
                        "micro_apartment_palette_null",
                    },
                },
                scope = "nested",
            },
        },
        palettes = { { parameter = "micro_apartment_palette" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_door_h",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "++",
            "  ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_door_v",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "+ ",
            "+ ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_door",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "+",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_walkway",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "  ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_end",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "##",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_stairwell",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "####   ",
            "#  +   ",
            "#  +   ",
            "####   ",
            "#>>    ",
            "#4     ",
            "#4     ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 1, y = 4, id = "3x3_stairs" } },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_stairs",
    layout = {
        size = { width = 3, height = 3 },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                x = 0,
                y = 0,
                required_flags = { above = { "SIDEWALK" } },
                otherwise = { "3x3_stairs_top" },
            },
            {
                x = 0,
                y = 0,
                required_flags = { below = { "SIDEWALK" } },
                otherwise = { "3x3_stairs_bottom" },
            },
            {
                x = 0,
                y = 0,
                required_flags = { above = { "SIDEWALK" }, below = { "SIDEWALK" } },
                id = "3x3_stairs_middle",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_stairs_top",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            ">> ",
            "00i",
            "iii",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_stairs_middle",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            ">> ",
            "<<i",
            "iii",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_stairs_bottom",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "<< ",
            "   ",
            "   ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "base" },
    },
}

ccb.content.define_overmap_terrain {
    id = "hab_unit",
    name = ccb.content.text("hab unit"),
    symbol = "^",
    color = "light_green",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 30 },
}

ccb.content.define_overmap_terrain {
    id = "hab_unit_central",
    name = ccb.content.text("hab unit central"),
    symbol = "^",
    color = "light_green",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK", "SOURCE_DRINK" },
    spawns = { group = "euzhvil_group", population = { 1, 3 }, chance = 30 },
}
