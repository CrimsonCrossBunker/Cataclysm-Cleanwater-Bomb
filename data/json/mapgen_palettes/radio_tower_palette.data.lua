local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "radio_tower_palette",
    layout = {
        item_groups = {
            C = { group = "consumer_electronics", chance = 80, repetitions = { 1, 2 } },
            l = { group = "clothing_work_set", chance = 80 },
            r = { group = "recycle_electronic", chance = 80, repetitions = { 1, 2 } },
        },
        palettes = { "parametrized_walls_palette" },
        parameters = {
            chaingate_type = {
                value_type = "terrain",
                default = {
                    weighted = { { id = "t_chaingate_c", weight = 1 }, { id = "t_chaingate_l", weight = 3 } },
                },
                scope = "overmap_special",
            },
        },
        terrain = {
            [" "] = "t_region_groundcover",
            R = "t_radio_tower",
            ["2"] = { parameter = "chaingate_type", fallback = "t_chaingate_l" },
            ["|"] = "t_chainfence",
            ["6"] = "t_radio_controls",
            _ = "t_concrete",
            ["+"] = {
                { id = "t_door_c", copies = 1 },
                { id = "t_door_locked", copies = 2 },
                { id = "t_door_elocked", copies = 1 },
            },
            ["4"] = "t_gutter_downspout",
            ["<"] = "t_ladder_up",
            a = "t_railing",
            [","] = "t_metal_floor_no_roof",
            ["≷"] = "t_ladder_up_down",
            ["&"] = "t_flat_roof",
            w = "t_window",
        },
        furniture = { C = "f_counter", r = "f_rack", h = "f_chair", l = "f_locker" },
    },
}
