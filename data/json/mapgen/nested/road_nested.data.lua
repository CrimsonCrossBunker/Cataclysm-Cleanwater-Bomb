local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_marked_crosswalk_and_lights",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                id = "24x24_marked_crosswalk_and_lights_placement",
                x = 0,
                y = 0,
                any_flags = { north_west = { "SIDEWALK" }, west = { "SIDEWALK" }, south_west = { "SIDEWALK" } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_marked_crosswalk_and_lights_placement",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { id = "4x4_sidewalk", x = 0, y = 0 },
            { id = "4x4_sidewalk", x = 20, y = 0 },
            { id = "16x16_marked_crosswalk_h", x = 4, y = 1 },
            { choices = { "18x18_marked_crosswalk_traffic_lights", "null" }, x = 3, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "18x18_marked_crosswalk_traffic_lights",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { id = "1x1_traffic_light", x = 0, y = 0 },
            { choices = { "1x1_street_light", "null" }, x = 0, y = 3 },
            { choices = { "1x1_street_light", "null" }, x = 17, y = 0 },
            { id = "1x1_traffic_light", x = 17, y = 3 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "culvert_east",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "        ____",
            "        ___.",
            "        __..",
            "        _~~~",
            "        _~~~",
            "        _~~~",
            "        _~~~",
            "        _~~~",
            "        _~~~",
            "        __..",
            "        ___.",
            "        ____",
        },
        terrain = { ["."] = "t_region_groundcover", ["~"] = "t_water_moving_sh", _ = "t_concrete" },
        furniture = { ["."] = "f_null", ["~"] = "f_null", _ = "f_null" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "culvert_west",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "____        ",
            ".___        ",
            "..__        ",
            "~~~_        ",
            "~~~_        ",
            "~~~_        ",
            "~~~_        ",
            "~~~_        ",
            "~~~_        ",
            "..__        ",
            ".___        ",
            "____        ",
        },
        terrain = { ["."] = "t_region_groundcover", ["~"] = "t_water_moving_sh", _ = "t_concrete" },
        furniture = { ["."] = "f_null", ["~"] = "f_null", _ = "f_null" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "16x16_marked_crosswalk_h",
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            ".│.│.│.│.│.│.│.│",
            ".│.│.│.│.│.│.│.│",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
            "                ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "16x16_marked_crosswalk_v",
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
            "..              ",
            "──              ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Only four_way for now so no need for conditionals
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_traffic_lights_rotary",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { id = "1x1_traffic_light", x = 20, y = 0 },
            { id = "1x1_traffic_light", x = 23, y = 3 },
            { id = "1x1_traffic_light", x = 23, y = 20 },
            { id = "1x1_traffic_light", x = 20, y = 23 },
            { id = "1x1_traffic_light", x = 3, y = 23 },
            { id = "1x1_traffic_light", x = 0, y = 20 },
            { id = "1x1_traffic_light", x = 0, y = 3 },
            { id = "1x1_traffic_light", x = 3, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_street_lights_end_straight",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = { "1x1_street_light", "null" },
                x = 3,
                y = { 17, 18 },
                any_flags = { south_west = { "SIDEWALK" }, west = { "SIDEWALK" } },
            },
            {
                choices = { "1x1_street_light", "null" },
                x = 20,
                y = { 17, 18 },
                any_flags = { east = { "SIDEWALK" }, south_east = { "SIDEWALK" } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_street_lights_straight",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = { "1x1_street_light", "null" },
                x = 3,
                y = { 5, 6 },
                any_flags = { west = { "SIDEWALK" }, north_west = { "SIDEWALK" } },
            },
            {
                choices = { "1x1_street_light", "null" },
                x = 3,
                y = { 17, 18 },
                any_flags = { south_west = { "SIDEWALK" }, west = { "SIDEWALK" } },
            },
            {
                choices = { "1x1_street_light", "null" },
                x = 20,
                y = { 5, 6 },
                any_flags = { north_east = { "SIDEWALK" }, east = { "SIDEWALK" } },
            },
            {
                choices = { "1x1_street_light", "null" },
                x = 20,
                y = { 17, 18 },
                any_flags = { east = { "SIDEWALK" }, south_east = { "SIDEWALK" } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_street_lights_cul_de_sac",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { id = "1x1_street_light", x = 20, y = 19 },
            { id = "1x1_street_light", x = 23, y = 11 },
            { id = "1x1_street_light", x = 20, y = 4 },
            { id = "1x1_street_light", x = 3, y = 4 },
            { id = "1x1_street_light", x = 0, y = 11 },
            { id = "1x1_street_light", x = 3, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_traffic_light",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "T",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_stop_sign",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "S",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_street_light",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "Y",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No SIDEWALK bc shouldn't occur in cities
ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_road_corner_ne",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "...",
            " ..",
            "  .",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_road_corner_se",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  .",
            " ..",
            "...",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_road_corner_sw",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            ".  ",
            ".. ",
            "...",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_road_corner_nw",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "...",
            ".. ",
            ".  ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_ns_long",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "12x12_sidewalk_ns_half", x = 0, y = 0 },
            { id = "12x12_sidewalk_ns_half", x = 0, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_ns_double",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "12x12_sidewalk_ns_half", x = 0, y = 0 },
            { id = "12x12_sidewalk_ns_half", x = 20, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_sidewalk_ns_half",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
            "____        ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_ns_corner_double",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = { { id = "4x4_sidewalk", x = 0, y = 0 }, { id = "4x4_sidewalk", x = 20, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_ew_long",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "12x12_sidewalk_ew_half", x = 0, y = 0 },
            { id = "12x12_sidewalk_ew_half", x = 12, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_sidewalk_ew_half",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "____________",
            "____________",
            "____________",
            "____________",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_end_straight",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "24x24_sidewalk_ns_long", x = 0, y = 0 },
            { id = "24x24_sidewalk_ns_long", x = 20, y = 0 },
            { id = "24x24_sidewalk_ew_long", x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_ew_corner_double",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = { { id = "4x4_sidewalk", x = 0, y = 0 }, { id = "4x4_sidewalk", x = 0, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_esw_corner_half_e",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "12x12_sidewalk_ew_half", x = 12, y = 0 },
            { id = "4x4_sidewalk", x = 20, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_esw_corner_half_w",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = { { id = "12x12_sidewalk_ew_half", x = 0, y = 0 }, { id = "4x4_sidewalk", x = 0, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_sidewalk",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "____",
            "____",
            "____",
        },
        palettes = { "road_palette" },
        rotation = { 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_double",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        nested = {
            { id = "24x24_sidewalk_curved_curvy_outer", x = 0, y = 0 },
            { id = "4x4_sidewalk_curved_curvy_inner", x = 20, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_sidewalk_curved_curvy_inner",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "  __",
            " ___",
            "____",
            "____",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_rotary_sidewalk_ne",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            " ___",
            "  __",
            "   _",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_rotary_sidewalk_se",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   _",
            "  __",
            " ___",
            "____",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_rotary_sidewalk_sw",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "_   ",
            "__  ",
            "___ ",
            "____",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_rotary_sidewalk_nw",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "___ ",
            "__  ",
            "_   ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_rotary_center_basic",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ____  ",
            " __  __ ",
            "__    __",
            "_      _",
            "_      _",
            "__    __",
            " __  __ ",
            "  ____  ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_rotary_center_fountain",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ____  ",
            " __  __ ",
            "__####__",
            "_ #~~# _",
            "_ #~~# _",
            "__####__",
            " __  __ ",
            "  ____  ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_rotary_center_statue",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ____  ",
            " __  __ ",
            "__    __",
            "_      _",
            "_   @  _",
            "__    __",
            " __  __ ",
            "  ____  ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_rotary_center_flowers",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ____  ",
            " __ff__ ",
            "__ffff__",
            "_ffffff_",
            "_ffffff_",
            "__ffff__",
            " __ff__ ",
            "  ____  ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_rotary_center_shrubs",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ____  ",
            " __  __ ",
            "__    __",
            "_  ss  _",
            "_  ss  _",
            "__    __",
            " __  __ ",
            "  ____  ",
        },
        palettes = { "road_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_NW",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "g___........___________g",
            "gg__........_________ggg",
            "ggg..........ggggggggggg",
            "gg********....gggggggggg",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_NE",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "g___________........___g",
            "ggg_________........__gg",
            "ggggggggggg..........ggg",
            "gggggggggg********....gg",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_ES",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                    gggg",
            "                    ggg_",
            "                    ggg_",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    *g__",
            "                    *.__",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    ....",
            "                    ....",
            "                    ..__",
            "                    .g__",
            "                    ggg_",
            "                    gggg",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_EN",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                    gggg",
            "                    ggg_",
            "                    *g__",
            "                    *.__",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    *...",
            "                    ....",
            "                    ....",
            "                    ..__",
            "                    .g__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    gg__",
            "                    ggg_",
            "                    ggg_",
            "                    gggg",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_SE",
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "gggggggggg....********gg",
            "ggggggggggg..........ggg",
            "ggg_________........__gg",
            "g___________........___g",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_SW",
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "gg....********gggggggggg",
            "ggg..........ggggggggggg",
            "gg__........_________ggg",
            "g___........___________g",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_WS",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "gggg                    ",
            "_ggg                    ",
            "_ggg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__g.                    ",
            "__..                    ",
            "....                    ",
            "....                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "__.*                    ",
            "__g*                    ",
            "_ggg                    ",
            "gggg                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_layby_junction_WN",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "gggg                    ",
            "_ggg                    ",
            "__g.                    ",
            "__..                    ",
            "....                    ",
            "....                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "...*                    ",
            "__.*                    ",
            "__g*                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "__gg                    ",
            "_ggg                    ",
            "_ggg                    ",
            "gggg                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_zombies",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        nested = {
            {
                choices = { "24x24_road_zombies_placement", "null" },
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
    id = "24x24_road_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "road", x = { 0, 23 }, y = { 0, 23 }, chance = 5 } },
    },
}

-- mapgendata::first_predecessor doesn't work perfectly so overwrite corner
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 3,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "999999__________________",
            "9999____________________",
            "999_____________________",
            "99______________________",
            "9_____________________  ",
            "9_________________      ",
            "_______________         ",
            "_____________           ",
            "___________             ",
            "__________              ",
            "_________               ",
            "________                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { choices = { "1x1_street_light", "null" }, x = { 16, 17 }, y = 5 },
            { choices = { "1x1_street_light", "null" }, x = 9, y = 9 },
            { choices = { "1x1_street_light", "null" }, x = 5, y = { 16, 17 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 5,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "999999__________________",
            "9999____________________",
            "999_____________________",
            "99_____ggggg____________",
            "9_____ggggg___________  ",
            "9____ggggg________      ",
            "____ggggg______         ",
            "___ggggg_____           ",
            "___gggg____             ",
            "___ggg____              ",
            "___gg____               ",
            "___g____                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { choices = { "1x1_street_light", "null" }, x = { 16, 17 }, y = 5 },
            { choices = { "1x1_street_light", "null" }, x = 9, y = 9 },
            { choices = { "1x1_street_light", "null" }, x = 5, y = { 16, 17 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 1,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "________________________",
            "________________________",
            "__gggggggggg____________",
            "__gffffffffg____________",
            "__gfffffffg___________  ",
            "__gffffffg________      ",
            "__gfffffg______         ",
            "__gffffg_____           ",
            "__gfffg____             ",
            "__gffg____              ",
            "__gfg____               ",
            "__gg____                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { choices = { "1x1_street_light", "null" }, x = { 16, 17 }, y = 5 },
            { choices = { "1x1_street_light", "null" }, x = 9, y = 9 },
            { choices = { "1x1_street_light", "null" }, x = 5, y = { 16, 17 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 1,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "________________________",
            "________________________",
            "________________________",
            "___bbb__bbb_____________",
            "___b6b__b6b___________  ",
            "___bbb__bbb_______      ",
            "_______________         ",
            "_____________           ",
            "___bbb_____             ",
            "___b6b____              ",
            "___bbb___               ",
            "________                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 5,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "________________________",
            "________________________",
            "________________________",
            "___cccccccc_____________",
            "___c6cnnc6c___________  ",
            "___cccccccc_______      ",
            "___cncccc______         ",
            "___cncc______           ",
            "___cccc____             ",
            "___c6c____              ",
            "___ccc___               ",
            "________                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- mapgendata::first_predecessor doesn't work perfectly so disabled for now
ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_sidewalk_curved_curvy_outer",
    weight = 0,
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "________________________",
            "________________________",
            "________________________",
            "___cccccccc_____________",
            "___ccccccxc___________  ",
            "___cccccccc_______      ",
            "___cccccc______         ",
            "___cccc______           ",
            "___cccc____             ",
            "___ccc____              ",
            "___ccc___               ",
            "________                ",
            "________                ",
            "_______                 ",
            "_______                 ",
            "______                  ",
            "______                  ",
            "______                  ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "_____                   ",
            "____                    ",
            "____                    ",
        },
        palettes = { "road_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        vehicle_placements = {
            { id = "food_carts", x = 5, y = 5, fuel = -1, status = -1, rotation = 0 },
            { id = "food_carts", x = 5, y = 7, fuel = -1, status = -1, rotation = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_road_zombies_placement",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0 },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 0, 23 }, y = { 0, 23 } } },
    },
}
