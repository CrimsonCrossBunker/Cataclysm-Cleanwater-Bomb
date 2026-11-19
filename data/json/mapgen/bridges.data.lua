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
