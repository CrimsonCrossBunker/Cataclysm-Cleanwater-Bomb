local ccb = require("ccb")

-- This palette is split from domestic_general_and_variant_palette because the construction palette needs more consideration than the other palettes
ccb.content.define_mapgen_palette {
    id = "domestic_general_construction_and_variant_palette",
    layout = {
        parameters = {
            construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_construction_palette", weight = 100 },
                        { id = "domestic_general_and_variant_palette", weight = 9900 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = { { parameter = "construction_palette" } },
    },
}

-- Standard variant distribution for homes: General: 97%, Abandoned: 0.6%, Construction: 1.00%, Survivor: 0.90%, Hoarder: 0.50%
-- Changes to standard_domestic_palette may also need applying to standard_domestic_abandoned_palette & standard_domestic_construction_palette.
ccb.content.define_mapgen_palette {
    id = "domestic_general_and_variant_palette",
    layout = {
        parameters = {
            variant_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_migration_palette", weight = 9700 },
                        { id = "standard_domestic_abandoned_palette", weight = 60 },
                        { id = "house_hoarder_palette", weight = 50 },
                        { id = "house_survivor_palette", weight = 90 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = { { parameter = "variant_palette" }, "parametrized_walls_palette" },
    },
}

-- Palette to replace most standard_domestic_palette use that adds a random level of pre-cata tidyness and post-cata damage.
-- Null here represents tidy
-- Null here represents untouched
-- Determines if house has alarm
-- Couldn't find an exact value of houses with alarms so estimated 25%, change if you have any good source
ccb.content.define_mapgen_palette {
    id = "standard_domestic_migration_palette",
    layout = {
        parameters = {
            tidyness_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "null_palette", weight = 6 },
                        { id = "standard_domestic_untidy_palette", weight = 3 },
                        { id = "standard_domestic_messy_palette", weight = 1 },
                    },
                },
                scope = "overmap_special",
            },
            damage_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "null_palette", weight = 2 },
                        { id = "standard_domestic_damage_palette", weight = 3 },
                        { id = "standard_domestic_damage_large_palette", weight = 1 },
                    },
                },
                scope = "overmap_special",
            },
            alarm_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "domestic_alarm_palette", weight = 1 },
                        { id = "domestic_locked_palette", weight = 3 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = {
            "standard_domestic_palette",
            { parameter = "damage_palette" },
            { parameter = "alarm_palette" },
            { parameter = "tidyness_palette" },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Makes all doors & windows have alarms
ccb.content.define_mapgen_palette {
    id = "domestic_alarm_palette",
    layout = {
        terrain = {
            ["*"] = {
                { id = "t_door_locked_alarm", copies = 2 },
                { id = "t_door_elocked_alarm", copies = 2 },
            },
            [":"] = "t_wall_glass_alarm",
            o = {
                { id = "t_window_domestic_alarm", copies = 10 },
                { id = "t_window_no_curtains_alarm" },
                { id = "t_window_open_alarm" },
                { id = "t_window_no_curtains_open_alarm" },
                { id = "t_curtains_alarm", copies = 5 },
            },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Makes no doors & windows have alarms
ccb.content.define_mapgen_palette {
    id = "domestic_locked_palette",
    layout = {
        terrain = {
            ["*"] = {
                { id = "t_door_locked", copies = 4 },
                { id = "t_door_elocked", copies = 3 },
                { id = "t_door_locked_peep", copies = 3 },
                { id = "t_door_elocked_peep", copies = 2 },
                { id = "t_door_c", copies = 2 },
                { id = "t_door_o", copies = 1 },
            },
            [":"] = "t_wall_glass",
            o = {
                { id = "t_window_domestic", copies = 10 },
                { id = "t_window_no_curtains" },
                { id = "t_window_open" },
                { id = "t_window_no_curtains_open" },
                { id = "t_curtains", copies = 5 },
            },
        },
    },
}

-- Intended as a palette for non-nested houses.  The default option for domestic buildings.  This one has no items and is used in standard_domestic_palette, these are split up as a (temporary) solution until #80078 has an implementation
-- Symbols still open for use: 0 ! $ % & _ = ~ ? / , ` and some symbols that conflict with json (like brackets).
ccb.content.define_mapgen_palette {
    id = "standard_domestic_palette_no_items",
    layout = {
        toilets = { "t" },
        nested_glyphs = {
            R = {
                choices = {
                    { id = "domestic_bookcase_nest_fiction", weight = 1750 },
                    { id = "domestic_bookcase_nest_fiction_and_nonfiction", weight = 850 },
                    { id = "domestic_bookcase_nest_plant", weight = 850 },
                    { id = "domestic_bookcase_nest_literature_enthusiast", weight = 500 },
                    { id = "domestic_bookcase_nest_table_book", weight = 500 },
                    { id = "domestic_bookcase_nest_cookbooks", weight = 350 },
                    { id = "domestic_bookcase_nest_manga", weight = 100 },
                    { id = "domestic_bookcase_nest_tailoring", weight = 100 },
                    { id = "domestic_bookcase_nest_computers", weight = 100 },
                    { id = "domestic_bookcase_nest_electronics", weight = 50 },
                    { id = "domestic_bookcase_nest_board_games", weight = 50 },
                    { id = "domestic_bookcase_nest_eclectic", weight = 50 },
                    { id = "domestic_bookcase_nest_martial_arts", weight = 25 },
                    { id = "domestic_bookcase_nest_medical", weight = 25 },
                    { id = "domestic_bookcase_nest_esoterica", weight = 25 },
                    { id = "domestic_bookcase_nest_judaica", weight = 10 },
                    { id = "domestic_bookcase_nest_european_comics", weight = 10 },
                },
            },
        },
        parameters = {
            house_fence_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_splitrail_fence", weight = 3 },
                        { id = "t_chainfence", weight = 2 },
                        { id = "t_fence", weight = 2 },
                        { id = "t_privacy_fence", weight = 1 },
                        { id = "t_drystone_wall_half", weight = 1 },
                    },
                },
            },
        },
        palettes = { "parametrized_walls_palette" },
        furniture = {
            a = "f_fireplace",
            b = "f_bigmirror",
            c = "f_statue",
            d = "f_dresser",
            e = "f_pool_table",
            f = "f_table",
            g = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
            h = "f_chair",
            i = "f_bench",
            j = "f_bench",
            k = "f_woodstove",
            l = "f_coffee_table",
            m = "f_glass_fridge",
            n = "f_dishwasher",
            p = "f_mailbox",
            q = "f_rack",
            r = "f_desk",
            s = "f_table",
            u = "f_rotary_clothesline",
            v = { { id = "f_gun_safe_el" }, { id = "f_safe_l" } },
            w = "f_rack_wood",
            x = "f_entertainment_center",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            z = "f_cardboard_box",
            A = "f_stool",
            B = "f_bathtub",
            C = "f_cupboard",
            D = "f_wardrobe",
            E = "f_armchair",
            F = "f_fridge",
            G = "f_camp_chair",
            H = "f_sofa",
            I = "f_desk",
            J = "f_counter",
            K = "f_tourist_table",
            L = "f_rack_coat",
            M = "f_displaycase",
            N = "f_workbench",
            O = { { id = "f_oven" }, { id = "f_gas_oven_microwave_combo" } },
            P = "f_filing_cabinet",
            Q = "f_rack_wood",
            S = "f_sink",
            T = "f_floor_lamp",
            U = "f_utility_shelf",
            V = "f_glass_cabinet",
            W = "f_washer",
            X = "f_birdbath",
            Y = "f_trashcan",
            Z = "f_dryer",
            ["1"] = "f_cupboard",
            ["2"] = "f_cupboard",
            ["3"] = "f_cupboard",
            ["4"] = "f_cupboard",
            ["5"] = "f_sink",
            ["6"] = "f_rack_wood",
            ["7"] = "f_cupboard",
            ["8"] = "f_counter",
            ["9"] = "f_shower",
            ["@"] = "f_bed",
            ["¤"] = "f_table",
            ["₸"] = "f_deckchair",
            ["∞"] = { { id = "f_foot_locker" }, { id = "f_foot_locker_aluminum" } },
            ["≠"] = "f_chest",
            ["Ø"] = "f_pinball_machine",
            ["Æ"] = "f_arcade_machine",
            ["ʭ"] = "f_ladder",
            ["ɱ"] = "f_console_broken",
        },
        terrain = {
            ["Ŧ"] = { parameter = "house_fence_type", fallback = "t_fence" },
            ["ɤ"] = {
                select = { parameter = "house_fence_type", fallback = "t_fence" },
                cases = {
                    t_splitrail_fence = "t_splitrail_fencegate_c",
                    t_chainfence = "t_chaingate_c",
                    t_fence = "t_fencegate_c",
                    t_privacy_fence = "t_privacy_fencegate_c",
                    t_drystone_wall_half = "t_chaingate_l",
                },
            },
            a = "t_thconc_floor",
            j = "t_region_groundcover_urban",
            p = "t_region_groundcover_urban",
            u = "t_region_groundcover_urban",
            X = "t_region_groundcover_urban",
            ["."] = "t_region_groundcover_urban",
            ["+"] = {
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 5 },
                { id = "t_door_locked_interior", copies = 1 },
            },
            ["*"] = {
                { id = "t_door_locked_peep", copies = 2 },
                { id = "t_door_locked_alarm" },
                { id = "t_door_locked", copies = 10 },
                { id = "t_door_elocked_peep", copies = 4 },
                { id = "t_door_elocked_alarm" },
                { id = "t_door_elocked", copies = 15 },
                { id = "t_door_c" },
                { id = "t_door_o", copies = 2 },
            },
            ["^"] = "t_gutter_downspout",
            ["¶"] = "t_door_glass_c",
            [":"] = "t_wall_glass",
            ["-"] = "t_sidewalk",
            o = {
                { id = "t_window_domestic", copies = 10 },
                { id = "t_window_no_curtains" },
                { id = "t_window_open" },
                { id = "t_window_no_curtains_open" },
                { id = "t_curtains", copies = 5 },
            },
            ["<"] = "t_wood_stairs_up",
            [">"] = "t_wood_stairs_down",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "standard_domestic_palette",
    layout = {
        nested_glyphs = {
            ["é"] = {
                choices = { { id = "domestic_freezer_nest", weight = 1 }, { id = "null", weight = 1 } },
            },
        },
        liquid_glyphs = { g = { id = "water_clean", amount = { 0, 100 } } },
        item_groups = {
            ["1"] = { { group = "SUS_dishes", chance = 100 }, { group = "SUS_silverware", chance = 100 } },
            ["2"] = { group = "SUS_cookware", chance = 100 },
            ["3"] = { { group = "SUS_utensils", chance = 50 }, { group = "SUS_knife_drawer", chance = 50 } },
            ["4"] = { group = "SUS_junk_drawer", chance = 100 },
            ["5"] = { group = "SUS_kitchen_sink", chance = 100 },
            ["6"] = {
                { group = "SUS_pantry", chance = 80 },
                { group = "cannedfood", chance = 20, repetitions = { 1, 2 } },
            },
            ["7"] = {
                { group = "SUS_breakfast_cupboard", chance = 30 },
                { group = "SUS_coffee_cupboard", chance = 50 },
                { group = "SUS_spice_collection", chance = 100 },
            },
            ["8"] = {
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 30, repetitions = { 1, 4 } },
                { group = "SUS_bathroom_medicine", chance = 40 },
                { group = "harddrugs_residential", chance = 2 },
            },
            ["9"] = { group = "shower", chance = 30, repetitions = { 1, 2 } },
            ["@"] = { group = "bed", chance = 50 },
            B = { group = "shower", chance = 10, repetitions = { 1, 2 } },
            D = {
                {
                    group = {
                        entries = {
                            { group = "SUS_wardrobe_mens", probability = 50 },
                            { group = "SUS_wardrobe_womens", probability = 50 },
                        },
                        kind = "distribution",
                    },
                },
            },
            F = { group = "SUS_fridge", chance = 100 },
            I = {
                { group = "SUS_desks_bedroom_unisex", chance = 5 },
                { group = "SUS_office_desk", chance = 25 },
            },
            J = { group = "kitchen_counters", chance = 5 },
            L = { group = "unisex_coat_rack", chance = 30, repetitions = { 1, 4 } },
            M = { group = "home_display_case", chance = 70 },
            N = {
                { group = "tools_common", chance = 20, repetitions = { 1, 2 } },
                { group = "hardware", chance = 30, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 10, repetitions = { 1, 2 } },
            },
            O = { group = "SUS_oven", chance = 100 },
            P = { group = "SUS_office_filing_cabinet", chance = 100 },
            Q = {
                { group = "shower", chance = 20 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "bed", chance = 30, repetitions = { 1, 2 } },
            },
            S = {
                { group = "SUS_bathroom_sink", chance = 80 },
                { group = "SUS_bathroom_medicine", chance = 60 },
            },
            U = {
                { group = "home_hw", chance = 20, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
                { group = "camping", chance = 5, repetitions = { 1, 2 } },
            },
            V = { group = "home_display_case", chance = 50 },
            W = { group = "laundry", chance = 50 },
            Y = { group = "SUS_trash_trashcan", chance = 30 },
            Z = { group = "laundry", chance = 100 },
            a = { group = "fireplace_fill", chance = 30, repetitions = { 2, 5 } },
            d = {
                {
                    group = {
                        entries = {
                            { group = "SUS_dresser_mens", probability = 50 },
                            { group = "SUS_dresser_womens", probability = 50 },
                        },
                        kind = "distribution",
                    },
                },
            },
            e = { group = "pool_table", chance = 30, repetitions = { 1, 2 } },
            f = {
                { group = "dishes_dining", chance = 30 },
                { group = "tea_dishes", chance = 10, repetitions = { 1, 2 } },
                { group = "baked_goods", chance = 5 },
                { group = "groce_condiment", chance = 10, repetitions = { 1, 2 } },
                { group = "dining", chance = 10 },
            },
            k = { group = "stash_wood", chance = 30, repetitions = { 2, 5 } },
            l = {
                { group = "elecsto_persele", chance = 10, repetitions = { 1, 3 } },
                { group = "livingroom", chance = 10, repetitions = { 1, 3 } },
            },
            m = { group = "SUS_fridge", chance = 80 },
            n = { group = "SUS_dishwasher", chance = 70 },
            p = { group = "mail", chance = 30, repetitions = { 2, 5 } },
            q = {
                { group = "tools_home", chance = 40 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "mechanics", chance = 1, repetitions = { 1, 2 } },
                { group = "camping", chance = 10 },
                { group = "tools_survival", chance = 5, repetitions = { 1, 2 } },
            },
            r = { { group = "SUS_office_desk", chance = 25 } },
            s = {
                { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
                { group = "livingroom", chance = 10, repetitions = { 1, 3 } },
            },
            t = { group = "SUS_toilet", chance = 10, repetitions = { 1, 3 } },
            v = {
                { group = "art", chance = 5 },
                { group = "art_all", chance = 10 },
                { group = "home_display_case", chance = 30 },
                { group = "harddrugs_residential", chance = 10, repetitions = { 1, 2 } },
                { group = "maps", chance = 2 },
                { group = "guns_pistol_common", chance = 25 },
                { group = "gemstones", chance = 30, repetitions = { 1, 2 } },
            },
            w = {
                { group = "shower", chance = 20 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "bed", chance = 30, repetitions = { 1, 2 } },
            },
            x = { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
            z = {
                { group = "allsporting", chance = 40, repetitions = { 1, 2 } },
                { group = "chem_home", chance = 50, repetitions = { 1, 2 } },
                { group = "child_items", chance = 30, repetitions = { 1, 2 } },
                { group = "stash_drugs", chance = 1 },
                { group = "maps", chance = 4 },
            },
            ["¤"] = { group = "nightstand", chance = 30 },
            ["≠"] = {
                { group = "toy_box", chance = 70, repetitions = { 2, 4 } },
                { group = "games", chance = 10, repetitions = { 1, 2 } },
                { group = "allsporting", chance = 5 },
            },
        },
        glyph_mappings = { ["÷"] = { item_spawns = { id = "doormat", chance = 55 } } },
        palettes = { "standard_domestic_palette_no_items" },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to overwrite certain common symbols with ones more appropriate for basements.
ccb.content.define_mapgen_palette {
    id = "standard_and_variant_domestic_basement_palette",
    layout = {
        parameters = {
            basement_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_basement_palette", weight = 99 },
                        { id = "flooded_domestic_basement_palette", weight = 1 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = { { parameter = "basement_palette" } },
    },
}

-- Intended to be used in conjunction with standard_and_variant_domestic_basement_palette.
-- Starting from 'a' this palette overwrites the standard_domestic_palette, any new additions to standard_domestic_palette need to be added after and any additions to flooded_domestic_basement_palette should be added before
ccb.content.define_mapgen_palette {
    id = "flooded_domestic_basement_palette",
    layout = {
        item_groups = {
            ["."] = {
                { group = "allsporting", chance = 1 },
                { group = "laundry", chance = 1 },
                { group = "SUS_trash_floor", chance = 1 },
            },
        },
        monster_glyphs = { ["."] = { group = "GROUP_SEWER", chance = 1 } },
        terrain = {
            ["<"] = "t_stairs_up",
            [" "] = "t_soil",
            ["^"] = "t_soil",
            ["#"] = "t_concrete_wall",
            ["|"] = "t_concrete_wall",
            ["."] = "t_water_sh_flood",
            ["!"] = "t_water_sh_flood",
            ["+"] = {
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 5 },
                { id = "t_door_locked_interior", copies = 1 },
            },
            c = "t_water_sh_flood",
            u = "t_water_sh_flood",
            ["Â"] = "t_water_sh_flood",
            ["Ö"] = "t_water_sh_flood",
            X = "t_water_sh_flood",
            a = "t_water_sh_flood",
            b = "t_water_sh_flood",
            d = "t_water_sh_flood",
            e = "t_water_sh_flood",
            f = "t_water_sh_flood",
            g = "t_water_sh_flood",
            h = "t_water_sh_flood",
            i = "t_water_sh_flood",
            j = "t_water_sh_flood",
            k = "t_water_sh_flood",
            l = "t_water_sh_flood",
            m = "t_water_sh_flood",
            n = "t_water_sh_flood",
            p = "t_water_sh_flood",
            q = "t_water_sh_flood",
            r = "t_water_sh_flood",
            s = "t_water_sh_flood",
            t = "t_water_sh_flood",
            v = "t_water_sh_flood",
            w = "t_water_sh_flood",
            x = "t_water_sh_flood",
            y = "t_water_sh_flood",
            z = "t_water_sh_flood",
            A = "t_water_sh_flood",
            B = "t_water_sh_flood",
            C = "t_water_sh_flood",
            D = "t_water_sh_flood",
            E = "t_water_sh_flood",
            F = "t_water_sh_flood",
            G = "t_water_sh_flood",
            H = "t_water_sh_flood",
            I = "t_water_sh_flood",
            J = "t_water_sh_flood",
            K = "t_water_sh_flood",
            L = "t_water_sh_flood",
            M = "t_water_sh_flood",
            N = "t_water_sh_flood",
            O = "t_water_sh_flood",
            P = "t_water_sh_flood",
            Q = "t_water_sh_flood",
            R = "t_water_sh_flood",
            S = "t_water_sh_flood",
            T = "t_water_sh_flood",
            U = "t_water_sh_flood",
            V = "t_water_sh_flood",
            W = "t_water_sh_flood",
            Y = "t_water_sh_flood",
            Z = "t_water_sh_flood",
            ["1"] = "t_water_sh_flood",
            ["2"] = "t_water_sh_flood",
            ["3"] = "t_water_sh_flood",
            ["4"] = "t_water_sh_flood",
            ["5"] = "t_water_sh_flood",
            ["6"] = "t_water_sh_flood",
            ["7"] = "t_water_sh_flood",
            ["8"] = "t_water_sh_flood",
            ["9"] = "t_water_sh_flood",
            ["@"] = "t_water_sh_flood",
            ["¤"] = "t_water_sh_flood",
            ["₸"] = "t_water_sh_flood",
            ["∞"] = "t_water_sh_flood",
            ["≠"] = "t_water_sh_flood",
            ["Ø"] = "t_water_sh_flood",
            ["Æ"] = "t_water_sh_flood",
            ["ʭ"] = "t_water_sh_flood",
            ["é"] = "t_water_sh_flood",
            ["â"] = "t_water_sh_flood",
        },
        furniture = {
            ["!"] = "f_locker",
            ["â"] = "f_home_furnace",
            c = "f_exercise",
            u = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["Â"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            ["Ö"] = { { id = "f_crate_c", copies = 2 }, { id = "f_crate_o", copies = 3 } },
            X = "f_punching_bag",
            a = "f_fireplace",
            A = "f_stool",
            F = "f_home_furnace",
            J = "f_counter",
            S = "f_sink",
            U = "f_utility_shelf",
            W = "f_washer",
            Z = "f_dryer",
            ["8"] = "f_counter",
            ["9"] = "f_shower",
            g = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
        },
    },
}

-- Intended to be used in conjunction with standard_and_variant_domestic_basement_palette.
-- Starting from 'a' this palette overwrites the standard_domestic_palette, any new additions to standard_domestic_palette need to be added after and any additions to standard_domestic_basement_palette should be added before
ccb.content.define_mapgen_palette {
    id = "standard_domestic_basement_palette",
    layout = {
        terrain = {
            ["<"] = "t_stairs_up",
            [" "] = "t_soil",
            ["^"] = "t_soil",
            ["#"] = "t_concrete_wall",
            ["|"] = "t_concrete_wall",
            ["."] = "t_thconc_floor",
            ["!"] = "t_thconc_floor",
            ["+"] = {
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 5 },
                { id = "t_door_locked_interior", copies = 1 },
            },
            c = "t_thconc_floor",
            u = "t_thconc_floor",
            ["Â"] = "t_thconc_floor",
            ["Ö"] = "t_thconc_floor",
            X = "t_thconc_floor",
            a = "t_thconc_floor",
            b = "t_thconc_floor",
            d = "t_thconc_floor",
            e = "t_thconc_floor",
            f = "t_thconc_floor",
            g = "t_thconc_floor",
            h = "t_thconc_floor",
            i = "t_thconc_floor",
            j = "t_thconc_floor",
            k = "t_thconc_floor",
            l = "t_thconc_floor",
            m = "t_thconc_floor",
            n = "t_thconc_floor",
            p = "t_thconc_floor",
            q = "t_thconc_floor",
            r = "t_thconc_floor",
            s = "t_thconc_floor",
            t = "t_thconc_floor",
            v = "t_thconc_floor",
            w = "t_thconc_floor",
            x = "t_thconc_floor",
            y = "t_thconc_floor",
            z = "t_thconc_floor",
            A = "t_thconc_floor",
            B = "t_thconc_floor",
            C = "t_thconc_floor",
            D = "t_thconc_floor",
            E = "t_thconc_floor",
            F = "t_thconc_floor",
            G = "t_thconc_floor",
            H = "t_thconc_floor",
            I = "t_thconc_floor",
            J = "t_thconc_floor",
            K = "t_thconc_floor",
            L = "t_thconc_floor",
            M = "t_thconc_floor",
            N = "t_thconc_floor",
            O = "t_thconc_floor",
            P = "t_thconc_floor",
            Q = "t_thconc_floor",
            R = "t_thconc_floor",
            S = "t_thconc_floor",
            T = "t_thconc_floor",
            U = "t_thconc_floor",
            V = "t_thconc_floor",
            W = "t_thconc_floor",
            Y = "t_thconc_floor",
            Z = "t_thconc_floor",
            ["1"] = "t_thconc_floor",
            ["2"] = "t_thconc_floor",
            ["3"] = "t_thconc_floor",
            ["4"] = "t_thconc_floor",
            ["5"] = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            ["7"] = "t_thconc_floor",
            ["8"] = "t_thconc_floor",
            ["9"] = "t_thconc_floor",
            ["@"] = "t_thconc_floor",
            ["¤"] = "t_thconc_floor",
            ["₸"] = "t_thconc_floor",
            ["∞"] = "t_thconc_floor",
            ["≠"] = "t_thconc_floor",
            ["Ø"] = "t_thconc_floor",
            ["Æ"] = "t_thconc_floor",
            ["ʭ"] = "t_thconc_floor",
            ["é"] = "t_thconc_floor",
            ["â"] = "t_thconc_floor",
        },
        furniture = {
            ["!"] = "f_locker",
            ["â"] = "f_home_furnace",
            c = "f_exercise",
            u = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["Â"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            ["Ö"] = { { id = "f_crate_c", copies = 2 }, { id = "f_crate_o", copies = 3 } },
            X = "f_punching_bag",
            a = "f_fireplace",
            A = "f_stool",
            J = "f_counter",
            S = "f_sink",
            U = "f_utility_shelf",
            W = "f_washer",
            Z = "f_dryer",
            ["8"] = "f_counter",
            ["9"] = "f_shower",
            g = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to add gray/white linoleum flooring under kitchen furniture
ccb.content.define_mapgen_palette {
    id = "standard_domestic_lino_kitchen",
    layout = {
        parameters = {
            linoleum_color_kitchen = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_linoleum_gray", weight = 1 },
                        { id = "t_linoleum_white", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            m = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            n = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            F = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            J = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            O = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["1"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["2"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["3"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["4"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["5"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["6"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["7"] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
            ["="] = { parameter = "linoleum_color_kitchen", fallback = "t_linoleum_gray" },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to add gray/white linoleum flooring under bathroom furniture
ccb.content.define_mapgen_palette {
    id = "standard_domestic_lino_bathroom",
    layout = {
        parameters = {
            linoleum_color_bathroom = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_linoleum_gray", weight = 1 },
                        { id = "t_linoleum_white", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            t = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            w = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            B = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            Q = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            S = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            ["8"] = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            ["9"] = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
            ["~"] = { parameter = "linoleum_color_bathroom", fallback = "t_linoleum_gray" },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to use open symbols for landscaping.
ccb.content.define_mapgen_palette {
    id = "standard_domestic_landscaping_palette",
    layout = {
        terrain = {
            ["%"] = {
                { id = "t_region_shrub" },
                { id = "t_region_shrub_fruit" },
                { id = "t_region_shrub_decorative" },
            },
            ["["] = {
                { id = "t_region_tree_fruit", copies = 2 },
                { id = "t_region_tree_nut", copies = 2 },
                { id = "t_region_tree_shade" },
            },
            ["!"] = "t_region_groundcover_urban",
            ["Ô"] = "t_region_groundcover_urban",
            _ = "t_pavement",
            ["`"] = "t_concrete",
        },
        furniture = {
            ["!"] = { { id = "f_region_flower", copies = 4 }, { id = "f_region_weed" } },
            ["Ô"] = "f_region_weed",
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to add blood and some property damage.
ccb.content.define_mapgen_palette {
    id = "standard_domestic_damage_palette",
    layout = {
        nested_glyphs = {
            ["+"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 3 },
                    { id = "destroyed_door_nested", weight = 1 },
                    { id = "null", weight = 16 },
                },
            },
            ["*"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 3 },
                    { id = "destroyed_door_nested", weight = 1 },
                    { id = "null", weight = 16 },
                },
            },
            o = {
                choices = {
                    { id = "damaged_window_nested", weight = 1 },
                    { id = "destroyed_window_nested", weight = 1 },
                    { id = "null", weight = 9 },
                },
            },
            ["¶"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 2 }, { id = "null", weight = 9 } },
            },
            [":"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 2 }, { id = "null", weight = 9 } },
            },
            b = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            d = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            e = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            f = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            h = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            i = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            j = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            l = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            m = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            p = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            r = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            s = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            u = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            w = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            x = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            y = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            z = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            A = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            C = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            D = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            G = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            I = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            J = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            K = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            L = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            M = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            Q = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            T = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            U = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            V = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            Y = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            ["6"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            ["¤"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            ["₸"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 79 } },
            },
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 1198 },
                },
            },
            [" "] = {
                choices = {
                    { id = "blood_field", weight = 2 },
                    { id = "bile_field", weight = 1 },
                    { id = "null", weight = 397 },
                },
            },
        },
    },
}

-- Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to add corpses and lots of property damage.
ccb.content.define_mapgen_palette {
    id = "standard_domestic_damage_large_palette",
    layout = {
        nested_glyphs = {
            ["+"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 1 },
                    { id = "destroyed_door_nested", weight = 3 },
                    { id = "null", weight = 6 },
                },
            },
            ["*"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 1 },
                    { id = "destroyed_door_nested", weight = 3 },
                    { id = "null", weight = 6 },
                },
            },
            o = {
                choices = {
                    { id = "damaged_window_nested", weight = 1 },
                    { id = "destroyed_window_nested", weight = 1 },
                    { id = "null", weight = 4 },
                },
            },
            ["¶"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 1 }, { id = "null", weight = 2 } },
            },
            [":"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 1 }, { id = "null", weight = 2 } },
            },
            b = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            d = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            e = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            f = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            h = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            i = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            j = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            l = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            m = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            p = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            r = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            s = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            u = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            w = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            x = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            y = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            z = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            A = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            C = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            D = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            G = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            I = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            J = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            K = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            L = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            M = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            Q = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            T = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            U = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            V = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            Y = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            ["6"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            ["¤"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            ["₸"] = {
                choices = { { id = "destroyed_furniture", weight = 1 }, { id = "null", weight = 9 } },
            },
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 598 },
                },
            },
            [" "] = {
                choices = {
                    { id = "corpse_blood_1x1", weight = 3 },
                    { id = "corpse_blood_casings_1x1", weight = 1 },
                    { id = "blood_field", weight = 8 },
                    { id = "bile_field", weight = 1 },
                    { id = "null", weight = 387 },
                },
            },
        },
    },
}

-- A disorganized but clean variant of the standard_domestic_palette. Adds out-of-place item spawns, such as dining items on desks and laundry on the floor. Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to overwrite certain common symbols with ones that generate an untidy look.  Symbols still open for use: ! $ % & _ = ~ - ? / , and more
ccb.content.define_mapgen_palette {
    id = "standard_domestic_untidy_palette",
    layout = {
        item_groups = {
            [" "] = { group = "untidy_floor_clutter", chance = 3 },
            ["1"] = {
                { group = "SUS_dishes", chance = 100 },
                { group = "SUS_silverware", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["2"] = {
                { group = "SUS_cookware", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["3"] = {
                { group = "SUS_utensils", chance = 50 },
                { group = "SUS_knife_drawer", chance = 50 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["4"] = {
                { group = "SUS_junk_drawer", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["5"] = {
                { group = "SUS_kitchen_sink", chance = 100 },
                { group = "dining", chance = 50, repetitions = { 2, 3 } },
                { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
            },
            ["7"] = {
                { group = "SUS_breakfast_cupboard", chance = 30 },
                { group = "SUS_coffee_cupboard", chance = 50 },
                { group = "SUS_spice_collection", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 25, repetitions = { 1, 2 } },
            },
            ["8"] = {
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 60, repetitions = { 1, 4 } },
                { group = "SUS_bathroom_medicine", chance = 40 },
                { group = "harddrugs_residential", chance = 2 },
            },
            ["9"] = { group = "shower", chance = 33, repetitions = { 2, 4 } },
            ["@"] = { { group = "bed", chance = 50 }, { group = "laundry", chance = 20 } },
            B = { group = "shower", chance = 30, repetitions = { 2, 3 } },
            C = { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
            E = { group = "coat_rack", chance = 20 },
            H = { group = "laundry", chance = 20 },
            I = {
                { group = "SUS_desks_bedroom_unisex", chance = 5 },
                { group = "SUS_office_desk", chance = 25, repetitions = { 1, 2 } },
                { group = "art_all", chance = 10 },
                { group = "mail", chance = 28, repetitions = { 1, 2 } },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "novels", chance = 20, repetitions = { 2, 3 } },
            },
            J = {
                { group = "kitchen_counters", chance = 25 },
                { group = "dishes_dining", chance = 25, repetitions = { 2, 3 } },
                { group = "dining", chance = 25, repetitions = { 2, 3 } },
                { group = "mail", chance = 33, repetitions = { 2, 3 } },
            },
            N = {
                { group = "tools_common", chance = 20, repetitions = { 1, 2 } },
                { group = "hardware", chance = 30, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 10, repetitions = { 1, 2 } },
                { group = "SUS_trash_hardware", chance = 33, repetitions = { 2, 5 } },
            },
            R = {
                { group = "homebooks", chance = 3, repetitions = { 1, 2 } },
                { group = "games", chance = 20, repetitions = { 2, 3 } },
                { group = "mail", chance = 25, repetitions = { 1, 3 } },
            },
            S = {
                { group = "SUS_bathroom_sink", chance = 50 },
                { group = "SUS_bathroom_medicine", chance = 20 },
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "shower", chance = 50, repetitions = { 2, 3 } },
            },
            W = { group = "laundry", chance = 75, repetitions = { 2, 3 } },
            Y = { group = "SUS_trash_trashcan", chance = 80 },
            f = {
                { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
                { group = "tea_dishes", chance = 20, repetitions = { 1, 2 } },
                { group = "baked_goods", chance = 5 },
                { group = "groce_condiment", chance = 10, repetitions = { 1, 2 } },
                { group = "dining", chance = 15 },
                { group = "novels", chance = 10 },
            },
            h = { group = "coat_rack", chance = 20 },
            l = {
                { group = "elecsto_persele", chance = 10, repetitions = { 1, 3 } },
                { group = "table_livingroom", chance = 10, repetitions = { 1, 3 } },
                { group = "dining", chance = 25, repetitions = { 2, 3 } },
                { group = "mail", chance = 20, repetitions = { 1, 3 } },
                { group = "novels", chance = 25 },
            },
            n = { group = "SUS_dishwasher", chance = 70, repetitions = { 2, 3 } },
            r = {
                { group = "SUS_office_desk", chance = 20 },
                { group = "art_all", chance = 10 },
                { group = "mail", chance = 28, repetitions = { 1, 4 } },
                { group = "dining", chance = 20, repetitions = { 1, 2 } },
                { group = "novels", chance = 25 },
            },
            s = {
                { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
                { group = "table_livingroom", chance = 10, repetitions = { 1, 3 } },
                { group = "mail", chance = 20, repetitions = { 1, 2 } },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "novels", chance = 20, repetitions = { 1, 2 } },
                { group = "art_all", chance = 10 },
            },
        },
    },
}

-- A disorganised and dirty variant of the standard_domestic_palette. Intended to be used in conjunction with standard_domestic_palette. Load the domestic palette first, then this one to overwrite certain common symbols with ones that generate an untidy and dirty look.  Symbols still open for use: ! $ % & _ = ~ - ? / , and more
ccb.content.define_mapgen_palette {
    id = "standard_domestic_messy_palette",
    layout = {
        item_groups = {
            [" "] = { group = "messy_floor_clutter", chance = 8 },
            ["1"] = {
                { group = "SUS_dishes", chance = 100 },
                { group = "SUS_silverware", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["2"] = {
                { group = "SUS_cookware", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["3"] = {
                { group = "SUS_utensils", chance = 50 },
                { group = "SUS_knife_drawer", chance = 50 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["4"] = {
                { group = "SUS_junk_drawer", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 33, repetitions = { 1, 2 } },
            },
            ["5"] = {
                { group = "SUS_kitchen_sink", chance = 100 },
                { group = "dining", chance = 50, repetitions = { 2, 3 } },
                { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
            },
            ["7"] = {
                { group = "SUS_breakfast_cupboard", chance = 30 },
                { group = "SUS_coffee_cupboard", chance = 50 },
                { group = "SUS_spice_collection", chance = 100 },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "mail", chance = 25, repetitions = { 1, 2 } },
            },
            ["8"] = {
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 60, repetitions = { 1, 4 } },
                { group = "SUS_bathroom_medicine", chance = 40 },
                { group = "harddrugs_residential", chance = 2 },
            },
            ["9"] = { group = "shower", chance = 33, repetitions = { 2, 4 } },
            ["@"] = { { group = "bed", chance = 50 }, { group = "laundry", chance = 20 } },
            B = { group = "shower", chance = 25, repetitions = { 2, 3 } },
            C = { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
            E = { group = "coat_rack", chance = 30 },
            H = { group = "laundry", chance = 20, repetitions = { 1, 3 } },
            I = {
                { group = "SUS_desks_bedroom_unisex", chance = 5 },
                { group = "SUS_office_desk", chance = 25, repetitions = { 1, 2 } },
                { group = "mail", chance = 28, repetitions = { 1, 2 } },
                { group = "dining", chance = 20, repetitions = { 1, 2 } },
                { group = "novels", chance = 25, repetitions = { 2, 3 } },
            },
            J = {
                { group = "kitchen_counters", chance = 25 },
                { group = "dishes_dining", chance = 25, repetitions = { 2, 3 } },
                { group = "dining", chance = 25, repetitions = { 2, 3 } },
                { group = "mail", chance = 33, repetitions = { 2, 3 } },
            },
            N = {
                { group = "tools_common", chance = 20, repetitions = { 1, 2 } },
                { group = "hardware", chance = 30, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 10, repetitions = { 1, 2 } },
                { group = "SUS_trash_hardware", chance = 33, repetitions = { 2, 5 } },
            },
            R = {
                { group = "homebooks", chance = 3, repetitions = { 1, 2 } },
                { group = "games", chance = 20, repetitions = { 2, 3 } },
                { group = "mail", chance = 25, repetitions = { 1, 3 } },
            },
            S = {
                { group = "SUS_bathroom_sink", chance = 50 },
                { group = "SUS_bathroom_medicine", chance = 20 },
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "shower", chance = 50, repetitions = { 2, 3 } },
            },
            W = { group = "laundry", chance = 75, repetitions = { 2, 3 } },
            Y = { group = "SUS_trash_trashcan", chance = 90 },
            f = {
                { group = "dishes_dining", chance = 50, repetitions = { 2, 3 } },
                { group = "tea_dishes", chance = 20, repetitions = { 1, 2 } },
                { group = "baked_goods", chance = 5 },
                { group = "groce_condiment", chance = 10, repetitions = { 1, 2 } },
                { group = "dining", chance = 10 },
                { group = "novels", chance = 15, repetitions = { 2, 3 } },
            },
            h = { group = "coat_rack", chance = 25 },
            l = {
                { group = "elecsto_persele", chance = 10, repetitions = { 1, 3 } },
                { group = "table_livingroom", chance = 10, repetitions = { 1, 3 } },
                { group = "dining", chance = 25, repetitions = { 2, 3 } },
                { group = "mail", chance = 20, repetitions = { 1, 3 } },
                { group = "novels", chance = 15, repetitions = { 2, 3 } },
            },
            n = { group = "SUS_dishwasher", chance = 70, repetitions = { 2, 3 } },
            r = {
                { group = "SUS_office_desk", chance = 30 },
                { group = "mail", chance = 28, repetitions = { 1, 4 } },
                { group = "dining", chance = 20, repetitions = { 2, 3 } },
                { group = "novels", chance = 25, repetitions = { 2, 3 } },
            },
            s = {
                { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
                { group = "table_livingroom", chance = 10, repetitions = { 1, 3 } },
                { group = "mail", chance = 20, repetitions = { 1, 2 } },
                { group = "dining", chance = 15, repetitions = { 1, 2 } },
                { group = "novels", chance = 25, repetitions = { 2, 3 } },
            },
        },
    },
}
