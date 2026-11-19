local ccb = require("ccb")

-- combines 2 5x5 convenience shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_convenience_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_convenience_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 convenience shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_convenience_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_convenience_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 pizza shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_pizza_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_pizza_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_pizza_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 pizza shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_pizza_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_pizza_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_pizza_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 Mexican restaurant areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_restaurant_mexican_front_A", x = 0, y = 0 },
            { id = "lab_5x5_restaurant_mexican_front_B", x = 0, y = 5 },
            { id = "lab_6x6_restaurant_mexican_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 Mexican restaurant areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_restaurant_mexican_front_A", x = 1, y = 0 },
            { id = "lab_5x5_restaurant_mexican_front_B", x = 1, y = 5 },
            { id = "lab_6x6_restaurant_mexican_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 coffee shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_coffee_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_coffee_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 coffee shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_coffee_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_coffee_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 bar areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_bar_front_A", x = 0, y = 0 },
            { id = "lab_5x5_bar_front_B", x = 0, y = 5 },
            { id = "lab_6x6_bar_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 bar areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_bar_front_A", x = 1, y = 0 },
            { id = "lab_5x5_bar_front_B", x = 1, y = 5 },
            { id = "lab_6x6_bar_kitchen", x = 0, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_res_8_NWD" },
    layout = {
        rows = {
            "|.....||¥==||||||||||||-",
            "|.....|;;;;;;;;;;;;;||..",
            "|.....|;;;;;;;;;;;;;|...",
            "|.....|;;;;;;;;;;;;;|...",
            "|.....|;;;;;;;;;;;;||...",
            "|.....|;;;;;;|||||;|....",
            "|.....|;;;;|||666|||....",
            "|.....|;;;;|n.....y.....",
            "|.....|;;;;|3..JA......h",
            "|.....|;;;;|5..J..A...hf",
            "|||+||||;;;|4..JA.....hf",
            "|......|;;;|O..JA.....hf",
            "|......|;;;|2..JA......h",
            "|......|;;;|1...........",
            "|......|;;;|||F7F|||....",
            "|......|;;;|;|||||^|....",
            "|......|;;;|;|||||^|....",
            "||||||||;;;|||bbb|||....",
            "|;;;;;;|;;;|......:.....",
            "|;;;;;;|;;;|.(.(..:...եե",
            "|;;^;;;|&;;|......)...եƨ",
            "|;;;;;;=;;;|..!.!.:...եƨ",
            "|;;;;;;|;;;|......)...եƨ",
            "|;;;;;;|;;;|.}.}..:...եե",
        },
        palettes = { "lab_common_palette", "lab_residential_palette", "standard_domestic_lino_bathroom" },
        traps = { ["("] = "tr_rollmat" },
        terrain = { ["¥"] = "t_card_science_maintenance_yellow" },
        furniture = {
            ["!"] = "f_exercise",
            ["}"] = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["{"] = "f_punching_bag",
        },
        fill_terrain = "t_linoleum_white",
        nested = {
            { id = "lab_17x17_shop", x = 1, y = 0 },
            { id = "lab_maintenance_6x6_open", x = 1, y = 18 },
        },
        trap_placements = { { id = "tr_light_on_res_8_NW", x = { 8, 10 }, y = { 1, 23 } } },
        monster_group_placements = {
            { group = "GROUP_LAB_RESEARCHERS", x = { 13, 22 }, y = { 8, 22 }, density = 0.08 },
            { group = "GROUP_LAB_MAINTENANCE", x = { 1, 4 }, y = { 2, 22 }, density = 0.1 },
        },
        monster_placements = {
            { id = "mon_lab_security_drone_GR", x = { 20, 22 }, y = { 2, 20 }, chance = 100 },
            { id = "mon_lab_security_drone_YM", x = 9, y = { 5, 20 }, chance = 100 },
            { id = "mon_skitterbot", x = 12, y = 15, chance = 100 },
            { id = "mon_skitterbot", x = 12, y = 16, chance = 100 },
            { id = "mon_skitterbot", x = 18, y = 15, chance = 100 },
            { id = "mon_skitterbot", x = 18, y = 16, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_res_8_NED" },
    layout = {
        rows = {
            "-||||||||||||==¥||.....|",
            "..||;;;;;;;;;;;;;|.....|",
            "...|;;;;;;;;;;;;;|.....|",
            "...|;;;;;;;;;;;;;|.....|",
            "...||;;;;;;;;;;;;|.....|",
            "....|;|||||;;;;;;|.....|",
            "....|||xxx|||;;;;|.....|",
            "......¶¶¶¶HT|;;;;|.....|",
            "h.....¶ll¶H.|;;;;|.....|",
            "fh....¶HHH¶.|;;;;|.....|",
            "fh....¶¶¶¶¶.|;;;||||+|||",
            "fh.....EsE..|;;;|......|",
            "h..........E|;;;|......|",
            "....yRY....T|;;;|......|",
            "....|||;a;|||;;;|......|",
            "....->|||||;|;;;|......|",
            "....X>|||||;|;;;|......|",
            "....|||PPP|||;;;||||||||",
            ".....:.....R|;;;|;;;;;;|",
            "եե...:.ErE.R|;;;|;;;;;;|",
            "ƨե...).ErE.R|;;&|;;;^;;|",
            "ƨե...:.....R|;;;=;;;;;;|",
            "ƨե...).ErE.R|;;;|;;;;;;|",
            "եե...:.ErE.R|;;;|;;;;;;|",
        },
        palettes = { "lab_common_palette", "lab_residential_palette", "standard_domestic_lino_bathroom" },
        terrain = {
            ["¥"] = "t_card_science_maintenance_yellow",
            ["ƶ"] = "t_card_science_mutagen_green",
            H = "t_carpet_concrete_yellow",
            l = "t_carpet_concrete_yellow",
        },
        fill_terrain = "t_linoleum_white",
        nested = {
            { id = "lab_17x17_shop_2", x = 17, y = 0 },
            { id = "lab_maintenance_6x6_open", x = 17, y = 18 },
        },
        trap_placements = { { id = "tr_light_on_res_8_NE", x = { 13, 15 }, y = { 1, 23 } } },
        monster_group_placements = {
            { group = "GROUP_LAB_RESEARCHERS", x = { 1, 8 }, y = { 8, 22 }, density = 0.05 },
            { group = "GROUP_LAB_MAINTENANCE", x = { 19, 21 }, y = { 2, 22 }, density = 0.1 },
        },
        monster_placements = {
            { id = "mon_lab_security_drone_YM", x = 14, y = { 5, 20 }, chance = 100 },
            { id = "mon_skitterbot", x = 11, y = 15, chance = 100 },
            { id = "mon_skitterbot", x = 11, y = 16, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_res_8_SWD" },
    layout = {
        rows = {
            "||||||||;;;||.....:.....",
            "|;;;;;|;;;;;||.{..|<....",
            "|;;;;;|&;;;;;|||||||||||",
            "|;;^;;=;;;;;;¥£££^|^££££",
            "|;;;;;|;;;;;;=;;♥♠|£;;;;",
            "|;;;;;|;;;;;;=;;♥♠|£;;;;",
            "|||||||;;;;;;=;;♥♠|£;;;;",
            "|;;;;;|;;;;;;|£££^|£££££",
            "|;;;;;|&;;;;;|||||||===¥",
            "|;;^;;=;;;;;;;;;;;;;;;;;",
            "|;;;;;|;;;;;;;;;;;;;;;;;",
            "|;;;;;|;;;;;;;;;;;;;;;;;",
            "|||||||;;;;;;;;;;;;;;;;;",
            "|||||||||||⁹⁹|||||||||||",
            "|||???????|UU|??????????",
            "__||||????|±||??????????",
            "_____||||||¢||||||||||||",
            "||_|__________________ȣ_",
            "?|_||||||_||||||||||||||",
            "?|_||||||_||_|||????????",
            "?|________||___|????????",
            "|||_||ȣ||_||_|||||||||||",
            "____||Г||____ȣ________ւ|",
            "||||||||||||||||||||||||",
        },
        palettes = { "lab_common_palette", "lab_residential_palette", "standard_domestic_lino_bathroom" },
        terrain = {
            L = "t_linoleum_gray",
            ["¥"] = "t_card_science_maintenance_yellow",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["Г"] = "t_ladder_down",
            ["ւ"] = "t_ladder_up",
        },
        furniture = { ["{"] = "f_punching_bag" },
        fill_terrain = "t_linoleum_white",
        nested = {
            { choices = { { id = "lab_cargo_5x5", weight = 100 } }, x = 1, y = 1 },
            { choices = { { id = "lab_cargo_5x5", weight = 100 } }, x = 1, y = 7 },
            {
                choices = {
                    { id = "lab_wall_chain_5x5", weight = 50 },
                    { id = "lab_wall_door_5x5", weight = 50 },
                    { id = "null", weight = 50 },
                },
                x = 1,
                y = 0,
            },
            {
                choices = {
                    { id = "lab_wall_chain_5x5", weight = 50 },
                    { id = "lab_wall_door_5x5", weight = 50 },
                    { id = "null", weight = 50 },
                },
                x = 1,
                y = 6,
            },
        },
        monster_group_placements = { { group = "GROUP_LAB_MAINTENANCE", x = { 1, 4 }, y = { 1, 22 }, density = 0.1 } },
        monster_placements = {
            {
                id = "mon_lab_security_drone_YM",
                x = { 8, 20 },
                y = { 10, 11 },
                chance = 100,
                repetitions = { 1, 2 },
            },
        },
        trap_placements = { { id = "tr_light_on_res_8_SW", x = { 8, 23 }, y = { 10, 12 } } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_res_8_SED" },
    layout = {
        rows = {
            ".....:.....||;;;||||||||",
            "....<|PPPP||;;;;;|;;;;;|",
            "|||||||||||;;;;;&|;;;;;|",
            "££££££^£££|;;;;;;=;;^;;|",
            ";;;;;;♦♣;;|;;;;;;|;;;;;|",
            ";;;;;;♦♣;;|;;;;;;|;;;;;|",
            ";;;;;;♦♣;;|;;;;;;|||||||",
            "££££££^£££|;;;;;;|;;;;;|",
            "===||||||||;;;;;&|;;;;;|",
            ";;;;;;;;;;;;;;;;;=;;^;;|",
            ";;;;;;;;;;;;;;;;;|;;;;;|",
            ";;;;;;;;;;;;;;;|||||||||",
            ";;;;;;;;;;;;;;;||_⁸⁴⁴|||",
            "|||||||||||⁹⁹||||_-⁴⁴|||",
            "??????????|UU|____-⁴⁴|||",
            "??????????|±||Q___||||||",
            "|||||||||||¢||U___|,<,00",
            "____________¢±UU__#,,,,,",
            "|||||||_|||||||||||_||||",
            "??????|_|?????????|UU|??",
            "??????|_||||||||||||||??",
            "??????|______________|||",
            "??????||||||||||||||____",
            "???????????????????|||||",
        },
        palettes = { "lab_common_palette", "lab_residential_palette", "standard_domestic_lino_bathroom" },
        terrain = {
            L = "t_linoleum_gray",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["⁸"] = "t_elevator_control_off",
            ["0"] = "t_sewage_pipe",
            ["⁴"] = "t_elevator",
        },
        fill_terrain = "t_linoleum_white",
        nested = {
            {
                choices = {
                    { id = "lab_maintenance_5x5_room_NE", weight = 100 },
                    { id = "null", weight = 0 },
                },
                x = 2,
                y = 18,
            },
            { choices = { { id = "lab_cargo_5x5", weight = 100 } }, x = 18, y = 1 },
            {
                choices = {
                    { id = "lab_wall_chain_5x5", weight = 50 },
                    { id = "lab_wall_door_5x5", weight = 50 },
                    { id = "null", weight = 50 },
                },
                x = 18,
                y = 0,
            },
            {
                choices = {
                    { id = "lab_wall_chain_5x5", weight = 50 },
                    { id = "lab_wall_door_5x5", weight = 50 },
                    { id = "null", weight = 50 },
                },
                x = 18,
                y = 6,
            },
        },
        monster_group_placements = { { group = "GROUP_LAB_MAINTENANCE", x = { 19, 21 }, y = { 1, 22 }, density = 0.1 } },
        trap_placements = { { id = "tr_light_on_res_8_SE", x = { 0, 14 }, y = { 10, 12 } } },
    },
}
