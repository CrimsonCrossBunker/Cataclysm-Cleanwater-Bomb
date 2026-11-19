local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_giant_snake_nest",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "             _          ",
            "                        ",
            "            --          ",
            "       _   ,,           ",
            "           ,,           ",
            "         _    _         ",
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
        terrain = {
            ["."] = "t_region_groundcover_swamp",
            _ = "t_region_groundcover_swamp",
            [","] = "t_pit_shallow",
            ["-"] = "t_trunk",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        corpse_placements = { { group = "GROUP_SWAMP", x = { 9 }, y = { 10 }, repetitions = { 1, 3 } } },
        item_groups = {
            _ = {
                { group = "corpses", chance = 10, repetitions = 1 },
                { group = "default_innawood_zombie_clothes", chance = 20 },
            },
        },
        monster_placements = {
            { id = "mon_rattlesnake_mega", x = 9, y = 11, patrol = { { x = 9, y = 9 } } },
            {
                id = "mon_rattlesnake_big_s",
                x = { 6, 15 },
                y = { 6, 15 },
                repetitions = { 2, 10 },
                chance = 50,
            },
        },
    },
}
