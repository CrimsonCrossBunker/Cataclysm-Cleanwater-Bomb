local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "elevator_shop_base",
    layout = {
        terrain = { ["#"] = "t_concrete_wall" },
        furniture = {
            F = "f_glass_fridge",
            O = "f_oven",
            c = "f_counter",
            d = "f_displaycase",
            h = "f_chair",
            s = "f_barstool",
        },
    },
}

-- TODO: These all need more groups and different items
ccb.content.define_mapgen_palette {
    id = "elevator_shop_drink",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "elevator_shop_food",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "elevator_shop_luxury",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "elevator",
    layout = {
        parameters = {
            elevator_state = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_central_elevator", weight = 1 },
                        { id = "t_central_elevator_closed", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["#"] = "t_concrete_wall",
            ["*"] = {
                { id = "t_door_metal_elocked", copies = 3 },
                { id = "t_door_metal_c", copies = 2 },
                { id = "t_door_metal_pickable", copies = 3 },
                { id = "t_door_metal_o", copies = 1 },
            },
            ["+"] = {
                { id = "t_door_c" },
                { id = "t_door_o" },
            },
            ["%"] = "t_ret_furn_target",
            ["&"] = "t_elevator_control",
            i = "t_metal_railing",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            ["0"] = "t_open_air",
            ["-"] = "t_door_metal_c",
            ["µ"] = "t_contraband_scanner",
            o = "t_reinforced_glass",
            O = {
                { id = "t_reinforced_glass_shutter" },
                { id = "t_reinforced_glass_shutter_open" },
            },
            _ = { parameter = "elevator_state", fallback = "t_central_elevator" },
            ["|"] = "t_bars",
            ["/"] = "t_door_bar_locked",
            ["°"] = "t_door_c",
        },
        furniture = {
            ["1"] = "f_counter",
            ["2"] = "f_counter",
            ["9"] = "f_console_broken",
            F = "f_fridge",
            L = "f_locker",
            R = "f_rack",
            S = "f_sink",
            Y = "f_trashcan",
            T = "f_table",
            b = "f_metal_bench",
            h = "f_chair",
            l = "f_locker",
            r = "f_rack",
        },
        item_groups = {
            L = {
                {
                    repetitions = { 1, 3 },
                    group = "locker_gym",
                    chance = 50,
                },
            },
            S = {
                { group = "SUS_kitchen_sink", chance = 50 },
            },
            y = {
                { group = "SUS_trash_trashcan", chance = 50 },
            },
            l = {
                { repetitions = 3, group = "locker_gym", chance = 50 },
            },
            R = {
                {
                    repetitions = { 1, 3 },
                    group = "elevator_fridge_drink",
                    chance = 50,
                },
                {
                    repetitions = { 1, 3 },
                    group = "elevator_fridge_food",
                    chance = 50,
                },
            },
        },
        nested_glyphs = {
            ["£"] = { id = "6x6_elevator_shop" },
            ["^"] = { id = "9x9_elevator_shop" },
            ["$"] = { id = "8x8_elevator_shop" },
            ["ù"] = { id = "12x12_elevator_shop" },
        },
        toilets = { "t" },
        computer_glyphs = {
            ["6"] = {
                name = "Elevator controls",
                chat_topics = { "elevator_controls_start" },
                dialogue_on_access = true,
                access_handler = "w16b_comp_elevator_controls",
            },
        },
        vending_glyphs = {
            V = { group = "vending_food_drink_items", lootable = true },
        },
    },
}
