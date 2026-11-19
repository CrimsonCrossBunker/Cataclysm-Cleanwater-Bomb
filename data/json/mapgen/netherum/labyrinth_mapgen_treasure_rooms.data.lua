local ccb = require("ccb")

-- Treasure room Circle of Wings
ccb.content.define_mapgen {
    kind = "nested",
    id = "LS_10x10_deadend_1_room1",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "|________|",
            "_((_______",
            "_((L______",
            "__LÜ______",
            "__________",
            "____UU____",
            "__s_UU_s__",
            "____UU____",
            "__s_UU_s__",
            "|________|",
        },
        palettes = { "labyrinthine_base_palette" },
        furniture = { s = "f_statue", ["Ü"] = "f_lab_bench" },
        item_groups = {
            U = { group = "LS_Rewardroom_Scatter_Passcode1", chance = 32 },
            ["Ü"] = { group = "LS_Rewardroom_Primary_Passcode1" },
        },
    },
}

-- Room full of shelves, should have CBMs
ccb.content.define_mapgen {
    kind = "nested",
    id = "LS_10x10_deadend_1_room3",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "|________|",
            "ϟ________ϟ",
            "ϟ__M__M__ϟ",
            "(________(",
            "ϟ__M__M__ϟ",
            "ϟ________ϟ",
            "(__M__M__(",
            "ϟ________ϟ",
            "ϟ__M__M__ϟ",
            "|ccCUÜCcc|",
        },
        palettes = { "labyrinthine_base_palette" },
        furniture = { ["Ü"] = "f_utility_shelf" },
        item_groups = {
            c = { group = "LS_SUS_crate_tier0_materials" },
            C = { group = "LS_Rewardroom_Scatter_Passcode3", chance = 75 },
            U = { group = "LS_Rewardroom_Scatter_Passcode3", chance = 75 },
            ["Ü"] = { group = "LS_Rewardroom_Primary_Passcode3" },
        },
    },
}
