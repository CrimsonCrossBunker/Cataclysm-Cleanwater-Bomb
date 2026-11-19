local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_group_infested",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { group = "GROUP_INFESTED_SPAWN", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_group_zombie",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { group = "GROUP_ZOMBIE", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_planksandtools",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "~~ 2",
            "~~ 2",
            "   2",
            "!!!!",
        },
        palettes = { "shelter_unfinished" },
        furniture = { ["!"] = "f_crate_o", ["2"] = "f_crate_o" },
        item_placements = { { id = "pot", x = 1, y = 4, amount = 1 } },
        item_groups = {
            ["!"] = {
                {
                    group = "faction_camp_tools",
                    chance = 95,
                    repetitions = { 2, 3 },
                    faction = "your_followers",
                },
                { group = "hardware_bulk", chance = 95, faction = "your_followers" },
                { group = "tools_home", chance = 95, faction = "your_followers" },
                {
                    group = "dishes_utility",
                    chance = 80,
                    repetitions = { 2, 3 },
                    faction = "your_followers",
                },
            },
            ["2"] = {
                {
                    group = "faction_camp_misc",
                    chance = 80,
                    repetitions = { 1, 2 },
                    faction = "your_followers",
                },
                {
                    group = "trash_junkyard",
                    chance = 80,
                    repetitions = { 6, 9 },
                    faction = "your_followers",
                },
            },
        },
    },
}
