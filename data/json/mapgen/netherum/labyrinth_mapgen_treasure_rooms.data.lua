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

-- Treasure room with autodoc!
ccb.content.define_mapgen {
    kind = "nested",
    id = "LS_10x10_deadend_1_room0",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "|(U____U(|",
            "(________(",
            "U________U",
            "E________E",
            "B___äd___B",
            "B___âL___B",
            "E________E",
            "U________U",
            "(________(",
            "|(UEBBEU(|",
        },
        palettes = { "labyrinthine_base_palette" },
        item_groups = { U = { group = "LS_Rewardroom_Scatter_Passcode0", chance = 32 } },
        item_group_placements = { { group = "LS_Rewardroom_Primary_Passcode0", x = 4, y = 4 } },
    },
}

-- Room full of shelves, should have CBMs and weapons and a big fight
ccb.content.define_mapgen {
    kind = "nested",
    id = "LS_10x10_deadend_1_room2",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "|L______L|",
            "U___¯¯___U",
            "Ü________U",
            "U___¯¯___U",
            "U________U",
            "U___¯¯___U",
            "U________U",
            "U___¯¯___U",
            "U________U",
            "|L______L|",
        },
        palettes = { "labyrinthine_base_palette" },
        furniture = { ["Ü"] = "f_utility_shelf" },
        monster_group_glyphs = { ["¯"] = { group = "GROUP_NETHER_REALITY_TEAR_FIELD", density = 0.01 } },
        item_groups = {
            ["Ü"] = { group = "LS_Rewardroom_Primary_Passcode2" },
            U = {
                { group = "LS_Rewardroom_Scatter_Passcode2", chance = 25 },
                { group = "LS_Rewardroom_Primary_Passcode2", chance = 2 },
            },
        },
    },
}
