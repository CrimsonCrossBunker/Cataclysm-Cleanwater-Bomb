local ccb = require("ccb")

-- Fully stocked, unlooted variant.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "farm_supply_1", "farm_supply_2" }, { "farm_supply_3", "farm_supply_4" } },
    layout = {
        rows = {
            "________________________________________________",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,Ü,,",
            "_____Ù____________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,Ü,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,__Ú_,__Ú_,__Û_,____,__Ú_,__Û_,__Ú_,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,Ü,,",
            "_,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",
            "_,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",
            " f...f   # SS #&&&&&&&&&# SS #&&&&&&# SS #&&&&# ",
            " f..Df   b SS b /   /   b SS b  /   & SS &  / & ",
            " f..Df / b SS b        /b SS b    / & SS &    & ",
            " f...f   # SS #&&&&&&&&&# SS #&&&&&&# SS #&&&&# ",
            " |x|||===||!!|||||||||||||!!||====|||fFFfffffff ",
            " |........^rr^mVØØ..õõõõg^rr^.......|....úúúúùf ",
            " W.1.1.2.2.rr.............rr..ww.dd.|........ùf ",
            " |.1.1.2.2.rr..$..$..$..$.rr..oo.ee.|^...^^..ùf ",
            " |.1.1.2.2.rr..c..c..c..c.rr........|^...ýý..ùf ",
            " |.........rr.............rr........|^...üü..ùf ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrr.00..00.|^...ÌÌ..ùf ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrr........|^........f ",
            " |.........rr.............rr.ÉÉÉÉÉÉ.|.........f ",
            " W.3333333.rr.6.6..77..88.rr........|..ÁÁÁÁÁÁ.f ",
            " |.........rr.6.6..77..88.rr.éééééé.|..ÓÓÓÓÓÓ.f ",
            " |.3333333.rr.6.6.........rr........|.........f ",
            " |.........rr.......BBB...rr.êêêêêê.|..ÎÎÎÎÎÎ.f ",
            " |..g......rr.............rr........|..÷÷÷÷÷÷.f ",
            " |..c.n.çç.rr.9.9.9.9.9.9.rr.ëëëëëë.|.........f ",
            " |..c.n....rr.9.9.9.9.9.9.rr........|..ææææææ.f ",
            " W..c.n.çç.rr.9.9.9.9.9.9.rr.ÈÈÈÈÈÈ.|.........f ",
            " |.........rr.............rr........|..^^^^^^.f ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!..^^^^^^.f ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!.........f ",
            " |.............rr........||+||||||x||..ËËËËËË.f ",
            " |.......4.4.4.rr.55..55.|..^|þHH..g|.........f ",
            " |.cc$c..4.4.4.rr........|...|.....q|..ÍÍÍÍÍÍ.f ",
            " |.......4.4.4.rr.55..55.|g..|.pp..j|..ÏÏÏÏÏÏ.f ",
            "<|.ààáá^.................|s.T|z.h...|.........f ",
            " ||||||||||||W|||||||W|||||||||X||x||ffffffffff ",
            "                                                ",
        },
        toilets = { "T" },
        item_groups = {
            ["$"] = { group = "cash_register_random", chance = 100 },
            [","] = {
                group = {
                    entries = {
                        { item = "null", probability = 300 },
                        { group = "SUS_trash_floor", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            ["."] = {
                group = {
                    entries = {
                        { item = "null", probability = 600 },
                        { group = "SUS_trash_floor", probability = 2 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            ["0"] = {
                group = {
                    entries = {
                        { group = "salty_snacks", probability = 75 },
                        { group = "candy_chocolate", probability = 20 },
                        { group = "liquor_and_spirits", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 4 },
            },
            ["1"] = { group = "petstore_shelves", chance = 80, repetitions = { 0, 3 } },
            ["2"] = {
                group = {
                    entries = {
                        { group = "dishes_utility", probability = 40 },
                        { group = "dishes_dining", probability = 15 },
                        { group = "kitchen_appliances", probability = 15 },
                        { group = "silverware", probability = 15 },
                        { group = "dinnerware", probability = 15 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 3 },
            },
            ["3"] = {
                group = {
                    entries = {
                        { group = "camping", probability = 40 },
                        { group = "hiking", probability = 40 },
                        { group = "tools_survival", probability = 5 },
                        { group = "tools_tailor", probability = 5 },
                        { group = "tools_hunting", probability = 5 },
                        { group = "book_survival", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 3 },
            },
            ["4"] = { group = "sports", chance = 50, repetitions = { 0, 4 } },
            ["5"] = {
                group = {
                    entries = {
                        { group = "toy_store", probability = 95 },
                        { group = "child_hats", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 3 },
            },
            ["6"] = { group = "clothing_outdoor_shoes", chance = 70, repetitions = { 0, 2 } },
            ["7"] = { group = "clothing_watch", chance = 60, repetitions = { 1, 2 } },
            ["8"] = { group = "clothing_glasses", chance = 60, repetitions = { 1, 2 } },
            ["9"] = {
                group = {
                    entries = {
                        { group = "clothing_outdoor_torso", probability = 45 },
                        { group = "clothing_outdoor_pants", probability = 45 },
                        { group = "underwear", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 2 },
            },
            D = { group = "SUS_trash_dumpster", chance = 70 },
            O = {
                group = {
                    entries = {
                        { item = "null", probability = 400 },
                        { group = "SUS_trash_floor", probability = 2 },
                        { item = "football", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            T = { group = "SUS_toilet", chance = 50 },
            V = { group = "vending_drink_items", chance = 70, repetitions = { 3, 10 } },
            _ = {
                group = {
                    entries = {
                        { item = "null", probability = 300 },
                        { group = "SUS_trash_floor", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            c = {
                group = {
                    entries = {
                        { group = "SUS_office_supplies", probability = 80 },
                        { group = "book_survival", probability = 10 },
                        { group = "supplies_hardware", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 10,
            },
            g = { group = "SUS_trash_trashcan_public", chance = 70 },
            n = {
                group = {
                    entries = {
                        { item = "fishing_hook_basic", probability = 70 },
                        { item = "fish_bait", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 3 },
            },
            p = {
                group = {
                    entries = {
                        { group = "SUS_office_supplies", probability = 70 },
                        { group = "office_breakroom", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 1, 3 },
            },
            q = { group = "SUS_office_filing_cabinet", chance = 100, repetitions = { 1, 5 } },
            r = {
                group = {
                    entries = {
                        { item = "null", probability = 600 },
                        { group = "SUS_trash_floor", probability = 2 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            s = { group = "coffee_bathroom", chance = 40 },
            z = {
                group = {
                    entries = {
                        { group = "stash_drugs", probability = 70 },
                        { group = "jewelry_safe", probability = 25 },
                        { group = "my_precious", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            ["È"] = {
                group = {
                    entries = {
                        { group = "tools_mechanic", probability = 70 },
                        { group = "supplies_electronics", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 5 },
            },
            ["É"] = {
                group = {
                    entries = {
                        { group = "tools_common", probability = 40 },
                        { group = "tools_entry", probability = 5 },
                        { group = "consumer_electronics", probability = 25 },
                        { group = "box_of_batteries_unopened", probability = 25 },
                        { group = "ammo_heavy_batteries_full", probability = 25 },
                        { group = "tools_lighting", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 4 },
            },
            ["Ë"] = {
                group = {
                    entries = {
                        { group = "tools_earthworking", probability = 90 },
                        { group = "tools_entry", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 3 },
            },
            ["Í"] = {
                group = {
                    entries = {
                        { group = "farm_supply_animal_feed", probability = 93 },
                        { group = "farm_supply_riding_gear", probability = 7 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 1, 4 },
            },
            ["Î"] = {
                group = {
                    entries = {
                        { group = "fertilizers", probability = 80 },
                        { item = "fungicide", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 6 },
            },
            ["Ï"] = { group = "farm_supply_quicklime_and_saltpetre", chance = 40, repetitions = { 1, 4 } },
            ["Ø"] = {
                group = {
                    entries = {
                        { group = "hardware_books", probability = 80 },
                        { group = "novels", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 4 },
            },
            ["à"] = {
                group = {
                    entries = {
                        { group = "guns_rifle_common_display", probability = 40 },
                        { group = "guns_shotgun_common_display", probability = 60 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 3 },
            },
            ["á"] = {
                group = {
                    entries = {
                        { group = "ammo_hunting", probability = 55 },
                        { group = "mags_common", probability = 35 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 5 },
            },
            ["æ"] = {
                group = {
                    entries = {
                        { group = "farming_tools", probability = 50 },
                        { group = "farm_supply_wire", probability = 50 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 7 },
            },
            ["ç"] = { group = "fishing_items", chance = 100, repetitions = { 0, 2 } },
            ["é"] = {
                group = {
                    entries = {
                        { group = "tools_tailor", probability = 50 },
                        { item = "thread", count = { 5, 20 }, probability = 10 },
                        { item = "cotton_patchwork", count = { 20, 50 }, probability = 10 },
                        { item = "felt_patch", count = { 5, 25 }, probability = 10 },
                        { item = "leather", count = { 3, 15 }, probability = 10 },
                        { group = "sewing_group", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 6 },
            },
            ["ê"] = {
                group = {
                    entries = {
                        { group = "tools_plumbing", probability = 70 },
                        { group = "plumbing_bulk", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 5 },
            },
            ["ë"] = {
                group = {
                    entries = {
                        { group = "tools_carpentry", probability = 70 },
                        { group = "supplies_woodcrafts", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 5 },
            },
            ["õ"] = {
                group = {
                    entries = {
                        { item = "log", probability = 50, count = { 5, 10 } },
                        { item = "stick_long", probability = 30, count = { 10, 20 } },
                        { item = "stick", probability = 20, count = { 5, 10 } },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 4 },
            },
            ["÷"] = { group = "farming_seeds", chance = 100, repetitions = { 3, 12 } },
            ["ù"] = { group = "farm_supply_soil_and_sand", chance = 100, repetitions = { 1, 6 } },
            ["ú"] = { group = "farm_supply_rocks", chance = 100, repetitions = { 1, 6 } },
            ["þ"] = { group = "SUS_fridge_breakroom", chance = 80 },
        },
        monster_placements = {
            {
                group = "GROUP_VANILLA",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 3 },
            },
            {
                group = "GROUP_POLICE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 0, 3 },
            },
            {
                group = "GROUP_VANILLA",
                x = { 24, 47 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 4 },
            },
            {
                group = "GROUP_ZOMBIE",
                x = { 4, 23 },
                y = { 26, 44 },
                chance = 80,
                repetitions = { 0, 7 },
            },
            {
                group = "GROUP_ZOMBIE",
                x = { 24, 46 },
                y = { 26, 44 },
                chance = 80,
                repetitions = { 0, 7 },
            },
            { group = "FERAL_HUMANS", x = { 32, 34 }, y = { 43, 44 }, chance = 80 },
        },
        vehicle_glyphs = {
            ["Ü"] = { id = "farm_vehicles", chance = 50, rotation = 180 },
            ["Ú"] = { id = "parkinglotbasic", chance = 15, rotation = 90 },
            ["Û"] = { id = "parkinglotbasic", chance = 20, rotation = 90, status = 1 },
            ["Ù"] = { id = "industrial_transport", chance = 10, rotation = 180 },
        },
        fill_terrain = "t_thconc_floor",
        palettes = { "farm_supply_palette" },
        terrain = { ["<"] = "t_ladder_up" },
    },
}

-- Looted variant. Guns, some camping supplies, and some other equipment is missing.
ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        { "farm_supply_looted_1", "farm_supply_looted_2" },
        { "farm_supply_looted_3", "farm_supply_looted_4" },
    },
    layout = {
        rows = {
            "________________________________________________",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,Ü,,",
            "_____Ù____________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "__________________________________________,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,Ü,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,__Ú_,__Ú_,__Û_,____,__Ú_,__Û_,__Ú_,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,,,,",
            "_,,,,,_,____,____,____,____,____,____,____,,,Ü,,",
            "_,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",
            "_,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",
            " f...f   # SS #&&&&&&&&&# SS #&&&&&&# SS #&&&&# ",
            " f..Df   b SS b /   /   b SS b  /   & SS &  / & ",
            " f..Df / b SS b        /b SS b    / & SS &    & ",
            " f...f   # SS #&&&&&&&&&# SS #&&&&&&# SS #&&&&# ",
            " |x|||===||!!|||||||||||||!!||====|||fFFfffffff ",
            " |........^rr^mVØØ..õõõõg^rr^.......|....úúúúùf ",
            " W.1.1.2.2.rr.............rr..ww.dd.|........ùf ",
            " |.1.1.2.2.rr..$..$..$..$.rr..oo.ee.|^...^^..ùf ",
            " |.1.1.2.2.rr..c..c..c..c.rr........|^...ýý..ùf ",
            " |.........rr.............rr........|^...üü..ùf ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrr.00..00.|^...ÌÌ..ùf ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrr........|^........f ",
            " |.........rr.............rr.ÉÉÉÉÉÉ.|.........f ",
            " W.3333333.rr.6.6..77..88.rr........|..ÁÁÁÁÁÁ.f ",
            " |.........rr.6.6..77..88.rr.éééééé.|..ÓÓÓÓÓÓ.f ",
            " |.3333333.rr.6.6.........rr........|.........f ",
            " |.........rr.......BBB...rr.êêêêêê.|..ÎÎÎÎÎÎ.f ",
            " |..g......rr.............rr........|..÷÷÷÷÷÷.f ",
            " |..c.n.çç.rr.9.9.9.9.9.9.rr.ëëëëëë.|.........f ",
            " |..c.n....rr.9.9.9.9.9.9.rr........|..ææææææ.f ",
            " W..c.n.çç.rr.9.9.9.9.9.9.rr.ÈÈÈÈÈÈ.|.........f ",
            " |.........rr.............rr........|..^^^^^^.f ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!..^^^^^^.f ",
            " |.rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!.........f ",
            " |.............rr........||+||||||x||..ËËËËËË.f ",
            " |.......4.4.4.rr.55..55.|..^|þHH..g|.........f ",
            " |.cc$c..4.4.4.rr........|...|.....q|..ÍÍÍÍÍÍ.f ",
            " |.......4.4.4.rr.55..55.|g..|.pp..j|..ÏÏÏÏÏÏ.f ",
            "<|.ààáá^.................|s.T|z.h...|.........f ",
            " ||||||||||||W|||||||W|||||||||X||x||ffffffffff ",
            "                                                ",
        },
        toilets = { "T" },
        nested = { { x = 24, y = 24, id = "farm_supply_fence_destruction" } },
        nested_glyphs = {
            ["à"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["á"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["ç"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            n = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["1"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["2"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["3"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["4"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["5"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["6"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["7"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["8"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["9"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["0"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["É"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["é"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["ê"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["ë"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["È"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["Ë"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["æ"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["÷"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["Î"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["Ø"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["õ"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            ["$"] = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
            W = { choices = { { id = "1x1_bash", weight = 10 }, { id = "null", weight = 90 } } },
        },
        item_groups = {
            ["$"] = { group = "cash_register_looted", chance = 50 },
            [","] = {
                group = {
                    entries = {
                        { item = "null", probability = 200 },
                        { group = "SUS_trash_floor", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            ["."] = {
                group = {
                    entries = {
                        { item = "null", probability = 500 },
                        { group = "SUS_trash_floor", probability = 2 },
                        { group = "ammo_casings", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            ["0"] = {
                group = {
                    entries = {
                        { group = "salty_snacks", probability = 75 },
                        { group = "candy_chocolate", probability = 20 },
                        { group = "liquor_and_spirits", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 4 },
            },
            ["1"] = { group = "petstore_shelves", chance = 70, repetitions = { 0, 3 } },
            ["2"] = {
                group = {
                    entries = {
                        { group = "dishes_utility", probability = 40 },
                        { group = "dishes_dining", probability = 15 },
                        { group = "kitchen_appliances", probability = 15 },
                        { group = "silverware", probability = 15 },
                        { group = "dinnerware", probability = 15 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 3 },
            },
            ["3"] = {
                group = {
                    entries = {
                        { group = "camping", probability = 40 },
                        { group = "hiking", probability = 40 },
                        { group = "tools_survival", probability = 5 },
                        { group = "tools_tailor", probability = 5 },
                        { group = "tools_hunting", probability = 5 },
                        { group = "book_survival", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 20,
                repetitions = { 0, 2 },
            },
            ["4"] = { group = "sports", chance = 50, repetitions = { 0, 4 } },
            ["5"] = {
                group = {
                    entries = {
                        { group = "toy_store", probability = 95 },
                        { group = "child_hats", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 70,
                repetitions = { 0, 3 },
            },
            ["6"] = { group = "clothing_outdoor_shoes", chance = 40, repetitions = { 0, 2 } },
            ["7"] = { group = "clothing_watch", chance = 60, repetitions = { 0, 2 } },
            ["8"] = { group = "clothing_glasses", chance = 60, repetitions = { 0, 2 } },
            ["9"] = {
                group = {
                    entries = {
                        { group = "clothing_outdoor_torso", probability = 45 },
                        { group = "clothing_outdoor_pants", probability = 45 },
                        { group = "underwear", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 60,
                repetitions = { 0, 2 },
            },
            D = { group = "SUS_trash_dumpster", chance = 70 },
            O = {
                group = {
                    entries = {
                        { item = "null", probability = 400 },
                        { group = "SUS_trash_floor", probability = 5 },
                        { item = "football", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            T = { group = "SUS_toilet", chance = 50 },
            V = { group = "vending_drink_items", chance = 20, repetitions = { 0, 8 } },
            _ = {
                group = {
                    entries = {
                        { item = "null", probability = 200 },
                        { group = "SUS_trash_floor", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            c = {
                group = {
                    entries = {
                        { group = "SUS_office_supplies", probability = 80 },
                        { group = "book_survival", probability = 10 },
                        { group = "supplies_hardware", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 10,
            },
            g = { group = "SUS_trash_trashcan_public", chance = 70 },
            n = {
                group = {
                    entries = {
                        { item = "fishing_hook_basic", probability = 70 },
                        { item = "fish_bait", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 2 },
            },
            p = {
                group = {
                    entries = {
                        { group = "SUS_office_supplies", probability = 70 },
                        { group = "office_breakroom", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 1, 3 },
            },
            q = { group = "SUS_office_filing_cabinet", chance = 100, repetitions = { 1, 3 } },
            r = {
                group = {
                    entries = {
                        { item = "null", probability = 500 },
                        { group = "SUS_trash_floor", probability = 2 },
                        { group = "ammo_casings", probability = 1 },
                        { group = "farm_supply_floor_surprises", probability = 1 },
                    },
                    kind = "collection",
                },
                chance = 100,
            },
            s = { group = "coffee_bathroom", chance = 40 },
            z = {
                group = {
                    entries = {
                        { group = "stash_drugs", probability = 70 },
                        { group = "jewelry_safe", probability = 25 },
                        { group = "my_precious", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 30,
            },
            ["È"] = {
                group = {
                    entries = {
                        { group = "tools_mechanic", probability = 70 },
                        { group = "supplies_electronics", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 60,
                repetitions = { 0, 5 },
            },
            ["É"] = {
                group = {
                    entries = {
                        { group = "tools_common", probability = 40 },
                        { group = "tools_entry", probability = 5 },
                        { group = "consumer_electronics", probability = 25 },
                        { group = "box_of_batteries_unopened", probability = 25 },
                        { group = "ammo_heavy_batteries_full", probability = 25 },
                        { group = "tools_lighting", probability = 5 },
                    },
                    kind = "collection",
                },
                chance = 50,
                repetitions = { 0, 3 },
            },
            ["Ë"] = {
                group = {
                    entries = {
                        { group = "tools_earthworking", probability = 90 },
                        { group = "tools_entry", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 3 },
            },
            ["Í"] = {
                group = {
                    entries = {
                        { group = "farm_supply_animal_feed", probability = 93 },
                        { group = "farm_supply_riding_gear", probability = 7 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 1, 4 },
            },
            ["Î"] = {
                group = {
                    entries = {
                        { group = "fertilizers", probability = 80 },
                        { item = "fungicide", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 90,
                repetitions = { 0, 6 },
            },
            ["Ï"] = { group = "farm_supply_quicklime_and_saltpetre", chance = 35, repetitions = { 1, 4 } },
            ["Ø"] = {
                group = {
                    entries = {
                        { group = "hardware_books", probability = 80 },
                        { group = "novels", probability = 20 },
                    },
                    kind = "collection",
                },
                chance = 100,
                repetitions = { 0, 4 },
            },
            ["à"] = {
                group = {
                    entries = {
                        { group = "guns_rifle_common_display", probability = 60 },
                        { group = "guns_shotgun_common_display", probability = 40 },
                    },
                    kind = "collection",
                },
                chance = 7,
                repetitions = { 0, 2 },
            },
            ["á"] = {
                group = {
                    entries = {
                        { group = "ammo_hunting", probability = 55 },
                        { group = "mags_common", probability = 35 },
                    },
                    kind = "collection",
                },
                chance = 7,
                repetitions = { 0, 4 },
            },
            ["æ"] = {
                group = {
                    entries = {
                        { group = "farming_tools", probability = 50 },
                        { group = "farm_supply_wire", probability = 50 },
                    },
                    kind = "collection",
                },
                chance = 90,
                repetitions = { 0, 7 },
            },
            ["ç"] = { group = "fishing_items", chance = 100, repetitions = { 0, 2 } },
            ["é"] = {
                group = {
                    entries = {
                        { group = "tools_tailor", probability = 50 },
                        { item = "thread", count = { 5, 20 }, probability = 10 },
                        { item = "cotton_patchwork", count = { 20, 50 }, probability = 10 },
                        { item = "felt_patch", count = { 5, 25 }, probability = 10 },
                        { item = "leather", count = { 3, 15 }, probability = 10 },
                        { group = "sewing_group", probability = 10 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 6 },
            },
            ["ê"] = {
                group = {
                    entries = {
                        { group = "tools_plumbing", probability = 70 },
                        { group = "plumbing_bulk", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 80,
                repetitions = { 0, 5 },
            },
            ["ë"] = {
                group = {
                    entries = {
                        { group = "tools_carpentry", probability = 70 },
                        { group = "supplies_woodcrafts", probability = 30 },
                    },
                    kind = "collection",
                },
                chance = 60,
                repetitions = { 0, 5 },
            },
            ["õ"] = {
                group = {
                    entries = {
                        { item = "log", probability = 50, count = { 5, 10 } },
                        { item = "stick_long", probability = 30, count = { 10, 20 } },
                        { item = "stick", probability = 20, count = { 5, 10 } },
                    },
                    kind = "collection",
                },
                chance = 60,
                repetitions = { 0, 4 },
            },
            ["÷"] = { group = "farming_seeds", chance = 100, repetitions = { 3, 12 } },
            ["ù"] = { group = "farm_supply_soil_and_sand", chance = 100, repetitions = { 1, 6 } },
            ["ú"] = { group = "farm_supply_rocks", chance = 100, repetitions = { 1, 6 } },
            ["þ"] = { group = "SUS_fridge_breakroom", chance = 50 },
        },
        monster_placements = {
            {
                group = "GROUP_VANILLA",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 2, 5 },
            },
            {
                group = "GROUP_POLICE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 1, 3 },
            },
            {
                group = "GROUP_VANILLA",
                x = { 24, 47 },
                y = { 0, 23 },
                chance = 60,
                repetitions = { 2, 4 },
            },
            {
                group = "GROUP_ZOMBIE",
                x = { 4, 23 },
                y = { 26, 44 },
                chance = 60,
                repetitions = { 3, 8 },
            },
            {
                group = "GROUP_ZOMBIE",
                x = { 24, 46 },
                y = { 26, 44 },
                chance = 80,
                repetitions = { 3, 8 },
            },
            { group = "FERAL_HUMANS", x = { 32, 34 }, y = { 43, 44 }, chance = 100 },
        },
        corpse_placements = { { group = "FERAL_HUMANS", x = 7, y = 42 } },
        vehicle_glyphs = {
            ["Ü"] = { id = "farm_vehicles", chance = 50, rotation = 180 },
            ["Ú"] = { id = "parkinglotbasic", chance = 15, rotation = 90 },
            ["Û"] = { id = "parkinglotbasic", chance = 20, rotation = 90, status = 1 },
            ["Ù"] = { id = "industrial_transport", chance = 10, rotation = 180 },
        },
        liquid_placements = {
            { id = "gasoline", x = { 0, 23 }, y = { 0, 17 }, amount = { 1, 50 }, one_in = 1 },
            { id = "gasoline", x = { 24, 40 }, y = { 0, 17 }, amount = { 1, 50 }, one_in = 1 },
        },
        fill_terrain = "t_thconc_floor",
        palettes = { "farm_supply_palette", "farm_supply_looted_palette" },
        terrain = { ["<"] = "t_ladder_up" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        { "farm_supply_roof_1", "farm_supply_roof_2" },
        { "farm_supply_roof_3", "farm_supply_roof_4" },
    },
    layout = {
        rows = {
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            " ---------------------------------------------- ",
            " -............................................- ",
            " -............................................- ",
            " -.............~~~~~~~~~......................- ",
            " -.............~~~~~~~~~......................- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            " -.............................~~.............- ",
            " -.............................~~.............- ",
            " -.............................~~.............- ",
            " -.............................~~.............- ",
            " -.............~~~~~~~~~.......~~.............- ",
            " -.............~~~~~~~~~.......~~.............- ",
            " -.............................~~.............- ",
            " -.............................~~.............- ",
            " -.............................~~.............- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            " -............................................- ",
            ">-............................................- ",
            " ---------------------------------------------- ",
            "                                                ",
        },
        terrain = {
            ["."] = "t_flat_roof",
            [" "] = "t_open_air",
            ["~"] = "t_glass_roof",
            ["-"] = "t_metal_railing",
            [">"] = "t_ladder_down",
        },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = {
                    { id = "roof_2x2_utilities_b", weight = 20 },
                    { id = "roof_2x2_utilities_c", weight = 10 },
                    { id = "roof_2x2_utilities_d", weight = 35 },
                    { id = "roof_2x2_utilities", weight = 35 },
                },
                x = { 26, 30 },
                y = { 40, 44 },
            },
            {
                choices = {
                    { id = "roof_2x2_infrastructure", weight = 50 },
                    { id = "roof_2x2_infrastructure_2", weight = 50 },
                },
                x = { 26, 30 },
                y = { 25, 35 },
            },
            {
                choices = {
                    { id = "null", weight = 70 },
                    { id = "roof_3x3_wine", weight = 15 },
                    { id = "roof_6x6_survivor", weight = 15 },
                },
                x = { 4, 9 },
                y = { 26, 40 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "farm_supply_fence_destruction",
    layout = {
        size = { width = 24, height = 24 },
        tile_edits = {
            { shape = "point", operation = "bash", x = 22, y = { 0, 20 } },
            { shape = "point", operation = "bash", x = 22, y = { 0, 20 }, repetitions = { 0, 1 } },
        },
    },
}
