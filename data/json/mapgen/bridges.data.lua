local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "bridge_ground_palette",
    layout = {
        terrain = {
            ["."] = "t_pavement",
            [":"] = "t_pavement_y",
            _ = "t_sidewalk",
            ["="] = "t_guardrail",
            u = "t_ramp_up_low",
            U = "t_ramp_up_high",
            d = "t_ramp_down_high",
            D = "t_ramp_down_low",
            W = "t_sidewalk_ramp_down_high",
            [">"] = "t_sidewalk_ramp_down_low",
            ["<"] = "t_sidewalk_ramp_up_high",
            w = "t_sidewalk_ramp_up_low",
            ["#"] = "t_concrete_wall",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "bridge_road_palette",
    layout = {
        terrain = {
            [" "] = "t_open_air",
            ["."] = "t_pavement_hw_air",
            [":"] = "t_pavement_y_hw_air",
            _ = "t_sidewalk_hw_air",
            ["="] = "t_guardrail_hw_air",
            U = "t_ramp_up_high",
            d = "t_ramp_down_high",
            D = "t_ramp_down_low",
            W = "t_sidewalk_ramp_down_high",
            [">"] = "t_sidewalk_ramp_down_low",
            ["<"] = "t_sidewalk_ramp_up_high",
            w = "t_sidewalk_ramp_up_low",
            ["#"] = "t_concrete_wall",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridge_road_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 0, 23 }, chance = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ground_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 0, 12 }, chance = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ramp_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 15, 23 }, chance = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "bridge" },
    weight = { global = "vanilla_bridge_weight", fallback = 1000 },
    layout = {
        rows = {
            "         ######         ",
            "          ####          ",
            "           ##           ",
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
            "           ##           ",
            "          ####          ",
            "         ######         ",
        },
        fallback_predecessor_mapgen = "river_center",
        palettes = { "bridge_ground_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "bridge_road" },
    weight = { global = "vanilla_bridge_weight", fallback = 1000 },
    layout = {
        fill_terrain = "t_open_air",
        rows = {
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
        },
        nested = {
            { id = "24x24_bridge_road_trash", x = 0, y = 0 },
            { id = "24x24_bridge_road_vehicles", x = 0, y = 0 },
        },
        palettes = { "bridge_road_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "bridgehead_ground" },
    weight = { global = "vanilla_bridge_weight", fallback = 1000 },
    layout = {
        rows = {
            "  __................__  ",
            "  __.......::.......__  ",
            "  __.......::.......__  ",
            "  __.......::.......__  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =wuuuuuuuuuuuuuuuuw=  ",
            "  =<UUUUUUUUUUUUUUUU<=  ",
            "  ####################  ",
            "  ####################  ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        fallback_predecessor_mapgen = "river_north",
        nested = {
            { id = "24x24_bridgehead_ground_trash", x = 0, y = 0 },
            { id = "24x24_bridgehead_ground_vehicles", x = 0, y = 0 },
            {
                id = "3x3_road_corner_ne",
                x = 1,
                y = 0,
                neighbors = {
                    north_west = {
                        { terrain = "road_curved", match = "subtype" },
                    },
                    north = {
                        { terrain = "road_curved", match = "subtype" },
                    },
                },
            },
            {
                id = "3x3_road_corner_nw",
                x = 20,
                y = 0,
                neighbors = {
                    north_east = {
                        { terrain = "road_curved", match = "subtype" },
                    },
                    north = {
                        { terrain = "road_curved", match = "subtype" },
                    },
                },
            },
        },
        palettes = { "bridge_ground_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "bridgehead_ramp" },
    weight = { global = "vanilla_bridge_weight", fallback = 1000 },
    layout = {
        fill_terrain = "t_open_air",
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
            "  =>DDDDDDDDDDDDDDDD>=  ",
            "  =WddddddddddddddddW=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_................_=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
            "  =_.......::......._=  ",
        },
        nested = {
            { id = "24x24_bridgehead_ramp_trash", x = 0, y = 0 },
        },
        palettes = { "bridge_road_palette" },
    },
}
