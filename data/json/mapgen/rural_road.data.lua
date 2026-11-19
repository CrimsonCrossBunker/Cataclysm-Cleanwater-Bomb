local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_end",
    layout = {
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_end", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_forest_end",
    layout = {
        predecessor_mapgen = "forest",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_end", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_end",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "       .///ii///.       ",
            "       .///ii///.       ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "     .///ii/////.       ",
            "     .///ii//////.      ",
            "    ./////i///////.     ",
            "    .//////////////.    ",
            "    .////////ii/////.   ",
            "    .///i/////ii/////.  ",
            "   .///ii//////ii////.  ",
            "   .///ii///i///ii///.  ",
            "   .///ii///ii///ii///. ",
            "   .///ii///ii///ii///. ",
            "   .///ii///ii///ii///. ",
            "   .///ii////////ii///. ",
            "   .////ii//////iii///. ",
            "   ./////ii///iiii///.  ",
            "   .//////iiiii/////.   ",
            "    ./////////////.     ",
            "     .///////////.      ",
            "      .////////..       ",
            "       ........         ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "1x1_farm_vehicles", x = 5, y = 8, neighbors = { east = { "paddock_end_UR" } } },
            {
                id = "24x24_dirt_road_turnback_paddock",
                x = 0,
                y = 0,
                neighbors = { east = { "paddock_end_UR" } },
            },
            { id = "24x24_fence_gate", x = 0, y = 0, neighbors = { west = { "splitrail_fence" } } },
            { id = "24x24_fence_gate", x = 0, y = 0, neighbors = { east = { "splitrail_fence" } } },
            {
                id = "1x1_farm_house_parking",
                x = 15,
                y = 11,
                neighbors = { east = { "farm_horse_house_1" } },
            },
            {
                id = "8x8_dirt_road_turnback_house",
                x = 16,
                y = 4,
                neighbors = { east = { "farm_horse_house_1" } },
            },
            {
                id = "6x6_dirt_road_turnback_greenhouse",
                x = 9,
                y = 18,
                neighbors = { south = { "farm_horse_greenhouse" } },
            },
            {
                id = "15x15_dirt_road_turnback_yard",
                x = 4,
                y = 9,
                neighbors = { south = { "yard" } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_straight",
    layout = {
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    "24x24_rural_road_straight_meander_east",
                    "24x24_rural_road_straight_meander_west",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_forest_straight",
    layout = {
        predecessor_mapgen = "forest",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    "24x24_rural_road_straight_meander_east",
                    "24x24_rural_road_straight_meander_west",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_straight_meander_east",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "         .///ii///.     ",
            "         .///ii///.     ",
            "         .///ii///.     ",
            "         .///ii///.     ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "        .///ii///.      ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_straight_meander_west",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "      .////ii///.       ",
            "      .///ii////.       ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii///.        ",
            "      .///ii////.       ",
            "      .////ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_curved",
    layout = {
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_curved", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_forest_curved",
    layout = {
        predecessor_mapgen = "forest",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_curved", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_curved",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "               .........",
            "           ..../////////",
            "          ./////////////",
            "         .//////////////",
            "        .///////iiiiiiii",
            "        .////iiiiiiiiiii",
            "        .///iiii////////",
            "        .///ii//////////",
            "        .///ii//////////",
            "       .////ii///.......",
            "       .///ii////.      ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                id = "dirtroad_to_farm_twd",
                x = 0,
                y = 0,
                neighbors = { west = "farm_dairy_twd_11" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_tee",
    layout = {
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_tee", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_forest_tee",
    layout = {
        predecessor_mapgen = "forest",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_tee", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_tee",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ...........     ",
            "........///////////.....",
            "////////////////////////",
            "////////////////////////",
            "//////////iiiiii////////",
            "iiiii///iiiiiiiii///iiii",
            "iiiii///iiiiiiii///iiiii",
            "ii//////////////////////",
            "////////////////////////",
            "////////////////////////",
            "///../////ii//////......",
            "...  .////ii/////.      ",
            "      .///ii////.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
            "       .///ii///.       ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                id = "dirtroad_to_farm_stills",
                x = 0,
                y = 0,
                neighbors = { north = "farm_stills_3" },
            },
            { id = "dirtroad_to_farm_2side", x = 0, y = 0, neighbors = { north = "2farm_11" } },
            {
                id = "dirtroad_to_farm_parking",
                x = 0,
                y = 0,
                neighbors = { south = "dirt_road_farm_parking" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_four_way",
    layout = {
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_four_way", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rural_road_forest_four_way",
    layout = {
        predecessor_mapgen = "forest",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "24x24_rural_road_four_way", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_rural_road_four_way",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "      .////ii////.      ",
            "     ./////ii/////.     ",
            "    .//////ii//////.    ",
            "   .///////ii///////.   ",
            "  .////i///ii///i////.  ",
            " .////ii///ii///ii////. ",
            ".////iii///ii///iii////.",
            "////iii////ii///iiii////",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "iiiiiii///ii///iiiiiiiii",
            "iiiiiii///ii///iiiiiiiii",
            "////////////////////////",
            "////////////////////////",
            "////////////////////////",
            "////iii///ii///iiiii////",
            ".////ii///ii///iiii////.",
            " .////ii//ii////ii////. ",
            "  .////i///ii///i////.  ",
            "   .///////ii///////.   ",
            "    .//////ii//////.    ",
            "     ./////ii/////.     ",
            "      .////ii////.      ",
        },
        palettes = { "rural_road2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "dirt_road_farm_parking",
    layout = {
        rows = {
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .//////////.      ",
            "      .///////i//.      ",
            "      .//i///////.      ",
            "      .///////i//.      ",
            "      .//i////i//.      ",
            "       .////////.       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "rural_road2" },
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        vehicle_placements = {
            { id = "farm_horse_vehicles", x = { 8, 9 }, y = { 9, 14 }, rotation = 270, status = 0 },
            {
                id = "farm_horse_vehicles",
                x = { 14, 15 },
                y = { 9, 14 },
                rotation = 270,
                status = 0,
                chance = 25,
            },
        },
    },
}
