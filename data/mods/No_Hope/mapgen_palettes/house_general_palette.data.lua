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

-- Standard variant distribution for homes: General: 90%, Abandoned: 5%, Construction: 1.00%, Survivor: 2%, Hoarder: 2%
-- Changes to standard_domestic_palette may also need applying to standard_domestic_abandoned_palette & standard_domestic_construction_palette.
ccb.content.define_mapgen_palette {
    id = "domestic_general_and_variant_palette",
    layout = {
        parameters = {
            variant_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_migration_palette", weight = 9000 },
                        { id = "standard_domestic_abandoned_palette", weight = 200 },
                        { id = "house_hoarder_palette", weight = 200 },
                        { id = "house_survivor_palette", weight = 200 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = {
            { parameter = "variant_palette" },
            "parametrized_walls_palette",
            "no_hope_damage_palette",
        },
    },
}

-- Palette to replace most standard_domestic_palette use that adds a random level of pre-cata tidyness and post-cata damage.
-- Determines if house has alarm
ccb.content.define_mapgen_palette {
    id = "standard_domestic_migration_palette",
    layout = {
        parameters = {
            tidyness_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_untidy_palette", weight = 40 },
                        { id = "standard_domestic_messy_palette", weight = 60 },
                    },
                },
                scope = "overmap_special",
            },
            damage_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "standard_domestic_damage_palette", weight = 40 },
                        { id = "standard_domestic_damage_large_palette", weight = 60 },
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
            "parametrized_walls_palette",
        },
    },
}

-- Adjusts vanilla palette to make houses not using the above more damaged.
ccb.content.define_mapgen_palette {
    id = "standard_domestic_palette_no_items",
    layout = {
        palettes = { "parametrized_walls_palette" },
        terrain = {
            ["+"] = {
                { id = "t_door_b", copies = 20 },
                { id = "t_door_frame", copies = 10 },
                { id = "t_door_o", copies = 70 },
                { id = "t_door_c", copies = 5 },
                { id = "t_door_locked_interior", copies = 3 },
            },
            ["*"] = {
                { id = "t_door_b_peep", copies = 20 },
                { id = "t_door_o_peep", copies = 70 },
                { id = "t_door_frame", copies = 10 },
                { id = "t_door_locked_peep", copies = 2 },
                { id = "t_door_locked_alarm" },
                { id = "t_door_locked", copies = 5 },
                { id = "t_door_c" },
            },
            o = {
                { id = "t_window_frame", copies = 5 },
                { id = "t_window_domestic", copies = 5 },
                { id = "t_window_no_curtains" },
                { id = "t_window_open" },
                { id = "t_window_no_curtains_open" },
                { id = "t_curtains", copies = 5 },
            },
        },
    },
    extend = true,
}

ccb.content.define_mapgen_palette {
    id = "standard_domestic_palette",
    layout = {
        liquid_glyphs = { g = { id = "water_clean", amount = { 0, 100 } } },
        item_groups = {
            ["1"] = { { group = "SUS_dishes", chance = 20 }, { group = "SUS_silverware", chance = 20 } },
            ["2"] = { group = "SUS_cookware", chance = 20 },
            ["3"] = { { group = "SUS_utensils", chance = 20 }, { group = "SUS_knife_drawer", chance = 20 } },
            ["4"] = { group = "SUS_junk_drawer", chance = 20 },
            ["5"] = { group = "SUS_kitchen_sink", chance = 20 },
            ["6"] = {
                { group = "SUS_pantry", chance = 5 },
                { group = "cannedfood", chance = 5, repetitions = { 1, 2 } },
            },
            ["7"] = {
                { group = "SUS_breakfast_cupboard", chance = 5 },
                { group = "SUS_coffee_cupboard", chance = 5 },
            },
            ["8"] = {
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 30 },
                { group = "SUS_bathroom_medicine", chance = 20 },
                { group = "harddrugs", chance = 2 },
            },
            ["9"] = { group = "shower", chance = 30, repetitions = { 1, 2 } },
            ["@"] = { group = "bed", chance = 20 },
            B = { group = "shower", chance = 10, repetitions = { 1, 2 } },
            D = {
                { group = "SUS_wardrobe_mens", chance = 20, repetitions = { 1, 2 } },
                { group = "SUS_wardrobe_womens", chance = 20, repetitions = { 1, 2 } },
            },
            F = { group = "SUS_fridge_healthy_vegan", chance = 10 },
            I = {
                { group = "SUS_desks_bedroom_unisex", chance = 5 },
                { group = "SUS_office_desk", chance = 25 },
            },
            J = { group = "kitchen_counters", chance = 5 },
            L = { group = "unisex_coat_rack", chance = 30, repetitions = { 1, 4 } },
            M = { group = "home_display_case", chance = 20 },
            N = {
                { group = "tools_common", chance = 20, repetitions = { 1, 2 } },
                { group = "hardware", chance = 30, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 10, repetitions = { 1, 2 } },
            },
            O = { group = "SUS_oven", chance = 50 },
            P = { group = "SUS_office_filing_cabinet", chance = 80 },
            Q = {
                { group = "shower", chance = 20 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "bed", chance = 30, repetitions = { 1, 2 } },
            },
            R = {
                { group = "homebooks", chance = 20, repetitions = { 1, 4 } },
                { group = "games", chance = 20, repetitions = { 1, 2 } },
            },
            S = {
                { group = "SUS_bathroom_sink", chance = 20 },
                { group = "SUS_bathroom_medicine", chance = 20 },
            },
            U = {
                { group = "home_hw", chance = 20, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 20, repetitions = { 1, 2 } },
                { group = "camping", chance = 5, repetitions = { 1, 2 } },
            },
            V = { group = "home_display_case", chance = 20 },
            W = { group = "laundry", chance = 20 },
            Y = { group = "SUS_trash_trashcan", chance = 30, repetitions = { 1, 4 } },
            Z = { group = "laundry", chance = 20 },
            a = { group = "fireplace_fill", chance = 30, repetitions = { 2, 5 } },
            d = {
                { group = "SUS_dresser_mens", chance = 20, repetitions = { 1, 2 } },
                { group = "SUS_dresser_womens", chance = 20, repetitions = { 1, 2 } },
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
            m = { group = "SUS_fridge_healthy_vegan", chance = 10 },
            n = { group = "SUS_dishwasher", chance = 70 },
            p = { group = "mail", chance = 30, repetitions = { 2, 5 } },
            q = {
                { group = "tools_home", chance = 30 },
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
                { group = "home_display_case", chance = 30 },
                { group = "harddrugs", chance = 10, repetitions = { 1, 2 } },
                { group = "maps", chance = 2 },
                { group = "guns_pistol_common", chance = 10 },
                { group = "gemstones", chance = 30, repetitions = { 1, 2 } },
            },
            w = {
                { group = "shower", chance = 20 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "bed", chance = 30, repetitions = { 1, 2 } },
            },
            x = { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
            z = {
                { group = "allsporting", chance = 20, repetitions = { 1, 2 } },
                { group = "chem_home", chance = 20, repetitions = { 1, 2 } },
                { group = "child_items", chance = 30, repetitions = { 1, 2 } },
                { group = "stash_drugs", chance = 1 },
                { group = "maps", chance = 7 },
            },
            ["≠"] = {
                { group = "toy_box", chance = 30, repetitions = { 1, 2 } },
                { group = "games", chance = 5, repetitions = { 1, 2 } },
                { group = "allsporting", chance = 5 },
            },
        },
        glyph_mappings = { ["÷"] = { item_spawns = { id = "doormat", chance = 55 } } },
        palettes = { "standard_domestic_palette_no_items" },
    },
}
