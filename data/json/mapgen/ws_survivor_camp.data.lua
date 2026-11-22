local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ws_survivor_camp" },
    weight = 1000,
    layout = {
        rows = {
            "       pp      pp       ",
            " pppppppp      pppppppp ",
            "pppppppp        pppppppp",
            "pppssr          ssr  ppp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp                    pp",
            "pp                    pp",
            "pp           ww       pp",
            "pp ssr       ww ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp         O          pp",
            "pp                    pp",
            "pp                    pp",
            "pp ssr          ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp                    pp",
            "pp                    pp",
            "pp                    pp",
            "ppp                  ppp",
            "pppppppppppppppppppppppp",
            " pppppppppppppppppppppp ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        predecessor_mapgen = "field",
        terrain = {
            O = "t_pit_shallow",
            p = {
                { id = "t_pit_spiked" },
                { id = "t_region_groundcover" },
            },
        },
        furniture = { O = "f_firering" },
        item_groups = {
            c = { group = "sc_loot_rare", chance = 30 },
            r = { group = "sc_loot_general", chance = 30 },
            s = { group = "sc_loot_equipment", chance = 30 },
            w = { group = "stash_wood", chance = 30 },
        },
        nested_glyphs = {
            E = {
                choices = {
                    { id = "tent_3x3_E", weight = 10 },
                    { id = "tent_5x5_E", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
            W = {
                choices = {
                    { id = "tent_3x3_W", weight = 10 },
                    { id = "tent_5x5_W", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
        },
        monster_group_placements = {
            { x = 11, y = 10, group = "GROUP_PREPPER_HOUSE" },
            { x = 10, y = 9, group = "GROUP_PREPPER_HOUSE" },
            { x = 12, y = 8, group = "GROUP_PREPPER_HOUSE" },
        },
        vehicle_placements = {
            {
                x = 11,
                y = 4,
                id = "surv_car",
                chance = 20,
                rotation = 270,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ws_survivor_camp" },
    weight = 10,
    layout = {
        rows = {
            "       pp      pp       ",
            " pppppppp      pppppppp ",
            "pppppppp        pppppppp",
            "pppssr          ssr  ppp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp                    pp",
            "pp                    pp",
            "pp           ww       pp",
            "pp ssr       ww ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp         O          pp",
            "pp                    pp",
            "pp                    pp",
            "pp ssr          ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp                    pp",
            "pp                    pp",
            "pp                    pp",
            "ppp                  ppp",
            "pppppppppppppppppppppppp",
            " pppppppppppppppppppppp ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        predecessor_mapgen = "field",
        terrain = {
            O = "t_pit_shallow",
            p = {
                { id = "t_pit_spiked" },
            },
        },
        furniture = { O = "f_firering" },
        item_groups = {
            c = {
                repetitions = { 2, 3 },
                group = "sc_loot_rare",
                chance = 50,
            },
            r = {
                repetitions = { 2, 3 },
                group = "sc_loot_general",
                chance = 70,
            },
            s = {
                repetitions = { 2, 3 },
                group = "sc_loot_equipment",
                chance = 85,
            },
            w = {
                repetitions = { 2, 3 },
                group = "stash_wood",
                chance = 100,
            },
        },
        nested_glyphs = {
            E = {
                choices = {
                    { id = "tent_3x3_E", weight = 10 },
                    { id = "tent_5x5_E", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
            W = {
                choices = {
                    { id = "tent_3x3_W", weight = 10 },
                    { id = "tent_5x5_W", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
        },
        vehicle_placements = {
            {
                x = 11,
                y = 4,
                id = "surv_car",
                chance = 70,
                rotation = 270,
            },
        },
        npc_placements = {
            { x = 10, y = 11, id = "survivor_camper" },
        },
        faction_areas = {
            {
                x = { 0, 23 },
                y = { 0, 23 },
                id = "no_faction",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ws_survivor_camp" },
    weight = { global = "ws_survivor_camp_weight", fallback = 25 },
    layout = {
        fill_terrain = "t_dirt",
        rows = {
            "_______pp      pp_______",
            "_pppppppp      pppppppp_",
            "pppppppp  A     pppppppp",
            "pppssr          ssr  ppp",
            "ppsE        A  sW     pp",
            "ppr c          r c    pp",
            "pp      A             pp",
            "pp                    pp",
            "pp           ww       pp",
            "pp ssr       ww ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp         O          pp",
            "pp        A           pp",
            "pp            A       pp",
            "pp ssr          ssr   pp",
            "ppsE           sW     pp",
            "ppr c          r c    pp",
            "pp                    pp",
            "pp           A        pp",
            "pp                    pp",
            "ppp                  ppp",
            "pppppppppppppppppppppppp",
            "_pppppppppppppppppppppp_",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            _ = "t_region_groundcover",
            O = "t_pit_shallow",
            p = {
                { id = "t_pit_spiked", copies = 3 },
                { id = "t_dirt", copies = 3 },
                { id = "t_region_groundcover", copies = 1 },
            },
        },
        furniture = { O = "f_firering" },
        item_groups = {
            c = { group = "sc_loot_rare", chance = 30 },
            r = { group = "sc_loot_general", chance = 30 },
            s = { group = "sc_loot_equipment", chance = 30 },
            w = { group = "stash_wood", chance = 30 },
        },
        nested_glyphs = {
            E = {
                choices = {
                    { id = "tent_b_3x3_E", weight = 10 },
                    { id = "tent_b_5x5_E", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
            W = {
                choices = {
                    { id = "tent_b_3x3_W", weight = 10 },
                    { id = "tent_b_5x5_W", weight = 20 },
                    { id = "null", weight = 5 },
                },
            },
            A = {
                choices = {
                    { id = "survivor_corpse", weight = 1 },
                    { id = "corpses_bones_only", weight = 25 },
                    { id = "null", weight = 75 },
                },
            },
        },
        vehicle_placements = {
            {
                x = 11,
                y = 4,
                id = "surv_car",
                chance = 20,
                status = -1,
                rotation = 270,
            },
        },
    },
}
