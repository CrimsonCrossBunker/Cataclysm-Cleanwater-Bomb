local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "city_cop_police_station",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "  .       ",
            " L.7      ",
            " L.7      ",
            " L.7      ",
            " L.7      ",
            " L.7      ",
            " L.7      ",
            " L..mtb.  ",
            " L.....   ",
            " LLLLLL.  ",
        },
        terrain = { ["-"] = "t_wall", ["."] = "t_floor" },
        furniture = {
            t = "f_table",
            b = "f_brazier",
            m = "f_makeshift_bed",
            ["7"] = "f_safe_o",
            L = "f_locker",
        },
        npc_placements = { { id = "survivor_cop", x = 5, y = 8 } },
        zone_placements = {
            { id = "LOOT_UNSORTED", faction = "no_faction", x = { 5, 5 }, y = { 9, 9 } },
            { id = "LOOT_CURRENCY", faction = "no_faction", x = { 5, 5 }, y = { 7, 7 } },
        },
        item_groups = {
            L = {
                { group = "cannedfood", chance = 50, repetitions = { 1, 2 } },
                { group = "alcohol", chance = 50, repetitions = { 1, 2 } },
            },
            ["7"] = {
                { group = "jewelry_front", chance = 50, repetitions = { 1, 2 } },
                { group = "harddrugs", chance = 20, repetitions = { 1, 2 } },
                { group = "stash_drugs", chance = 50, repetitions = { 2, 3 } },
            },
            m = { group = "bed", chance = 50, repetitions = { 1, 2 } },
            b = { group = "stash_wood", chance = 100, repetitions = { 2, 3 } },
            t = { group = "cannedfood", chance = 100, repetitions = { 2, 3 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "SEER_Brigitte_LaCroix_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "SEER_Brigitte_LaCroix", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "KINDRED_Darren_Cooper_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "KINDRED_Darren_Cooper", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "NPC_pizzaiolo_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "NPC_pizzaiolo", x = 0, y = 0 } },
    },
}
