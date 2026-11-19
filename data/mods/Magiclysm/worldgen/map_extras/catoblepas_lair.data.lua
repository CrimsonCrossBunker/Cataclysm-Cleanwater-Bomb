local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_catoblepas_lair",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "          ---           ",
            "           TTT--        ",
            "         -T---T-        ",
            "        -T-----T        ",
            "        T--C----T-      ",
            "      --T-------T-      ",
            "       -T----c--T       ",
            "       --T-X---T        ",
            "         -TX--T--       ",
            "         --TTT--        ",
            "            --          ",
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
            T = {
                { id = "t_region_tree_forest", copies = 1 },
                { id = "t_region_groundcover_swamp", copies = 1 },
                { id = "t_region_shrub_swamp", copies = 1 },
            },
            ["-"] = {
                { id = "t_region_groundcover_swamp", copies = 3 },
                { id = "t_region_shrub_swamp", copies = 1 },
            },
            C = {
                { id = "t_region_groundcover_swamp", copies = 3 },
                { id = "t_region_shrub_swamp", copies = 1 },
            },
            c = {
                { id = "t_region_groundcover_swamp", copies = 3 },
                { id = "t_region_shrub_swamp", copies = 1 },
            },
            X = "t_region_groundcover_swamp",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            X = {
                { group = "corpses", chance = 5, repetitions = 1 },
                { group = "default_zombie_death_drops", chance = 85 },
            },
        },
        monster_glyphs = { C = { id = "mon_catoblepas" }, c = { id = "mon_catoblepas", chance = 80 } },
    },
}
