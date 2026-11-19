local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "orc_palette",
    layout = {
        item_groups = {
            ["="] = { group = "orc_village_storage", chance = 70, repetitions = { 1, 3 } },
            U = { group = "orc_village_foodstuffs", repetitions = { 1, 3 }, chance = 80 },
        },
        terrain = {
            ["3"] = "t_door_makeshift_c",
            ["1"] = "t_palisade",
            ["!"] = "t_pit_spiked",
            ["-"] = "t_wall_wattle",
            ["|"] = "t_wall_wattle",
            ["#"] = "t_dirtfloor_thatchroof",
            o = "t_dirtfloor_thatchroof",
            B = "t_dirtfloor_thatchroof",
            ["="] = "t_dirtfloor_thatchroof",
            I = "t_wall_log_half",
            ["."] = "t_dirt",
        },
        furniture = {
            t = "f_logstool",
            o = "f_firering",
            O = "f_firering",
            B = "f_straw_bed",
            ["="] = "f_rack_wood",
            H = "f_smoking_rack",
        },
    },
}

-- lore: brutally slaughtered human, only scraps of it remain. the goblins have taken everything they need from it and left the rest there to frighten every human that comes close to their outpost. can be reused for other purposes, such as humans eaten by animals.
ccb.content.define_mapgen {
    kind = "nested",
    id = "human_gore",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = {
            { id = "fd_blood", x = 0, y = 0, intensity = 2, age_turns = 0 },
            { id = "fd_gibs_flesh", x = 0, y = 0, intensity = 3, age_turns = 0 },
        },
        item_placements = {
            { id = "skull_human", x = 0, y = 0 },
            { id = "bone_human", amount = { 5, 13 }, x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "orc_village",
    layout = {
        rows = {
            "!!!111111111111111111111",
            "!XX1...................1",
            "1111....-----...----...1",
            "1.......|===|...|==|...1",
            "1.-----.|###|.|-|##|-|.1",
            "1.|BBB|.......|==####|.1",
            "1.|BoB|.......3#####B|.1",
            "1.|##=|.......|Bo##oB|.1",
            "1.--3--.......|BBB#BB|.1",
            "1.............|------|.1",
            "1......................1",
            "1.-----................1",
            "1.|BBB|...ttt..........1",
            "1.|Bo#3...tOt...|----|.1",
            "1.|#==|.........|=B##|.1",
            "1.-----........U|=#oB|.1",
            "1..............-|=B#B|.1",
            "1..............|=#B##|.1",
            "1UU............|=#BoB|.1",
            "1U.............|=#BBB|.1",
            "1H.............3###==|.1",
            "1U.11111.I...I.------|.1",
            "1UU1XXX1UI...I.........1",
            "1111!!!111...11111111111",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = { X = { choices = { { id = "human_gore", weight = 9 }, { id = "null", weight = 1 } } } },
        monster_group_placements = {
            {
                group = "GROUP_ALL_GOBLINS",
                x = { 3, 21 },
                y = { 4, 19 },
                density = 0.3,
                repetitions = { 3, 6 },
            },
        },
        fill_terrain = "t_dirt",
        palettes = { "orc_palette" },
    },
}

ccb.content.define_overmap_terrain {
    id = { "orc_village" },
    name = ccb.content.text("goblin outpost"),
    symbol = "G",
    color = "green",
    see_cost = "high",
    flags = { "RISK_HIGH" },
    vision_levels = "blends_till_details",
}
