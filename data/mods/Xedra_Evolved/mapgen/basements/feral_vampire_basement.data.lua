local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_N",
    weight = 100,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%% %%",
            "%   %",
            "%  G%",
            "%=KK%",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_earthbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "stash_food", x = { 2, 3 }, y = 3, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 3, chance = 70, repetitions = { 2, 4 } },
            { group = "feral_vampire_nest_dead_bodies", x = 1, y = 2, chance = 70 },
        },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, repetitions = { 0, 3 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 1, 3 }, y = { 1, 3 }, chance = 80 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_S",
    weight = 100,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "%   %",
            "%=  %",
            "%% %%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_earthbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
            {
                group = "feral_vampire_nest_dead_bodies",
                x = 1,
                y = 2,
                chance = 70,
                repetitions = { 1, 3 },
            },
        },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, repetitions = { 0, 3 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 1, 3 }, y = { 1, 3 }, chance = 80 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_E",
    weight = 100,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "%    ",
            "%=  %",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_sandbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
            {
                group = "feral_vampire_nest_dead_bodies",
                x = 1,
                y = 2,
                chance = 70,
                repetitions = { 1, 3 },
            },
        },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, repetitions = { 0, 3 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 1, 3 }, y = { 1, 3 }, chance = 80 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_W",
    weight = 100,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "    %",
            "%=  %",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_sandbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
            {
                group = "feral_vampire_nest_dead_bodies",
                x = 3,
                y = 2,
                chance = 70,
                repetitions = { 1, 3 },
            },
        },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, repetitions = { 0, 3 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 1, 3 }, y = { 1, 3 }, chance = 80 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_electronics_open",
    weight = 100,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "CyT..C",
            "C====C",
            "C=EE=C",
            ".===&.",
            ".h==Af",
            "BBB..f",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_placements = {
            { id = "television", x = 5, y = 5, chance = 100 },
            { id = "laptop", x = 1, y = 5, chance = 90 },
            { id = "multitool", x = 0, y = 5, chance = 100 },
            { id = "breadboard", x = 1, y = 5, chance = 95 },
            { id = "voltmeter", x = 1, y = 5, chance = 90 },
            { id = "multimeter", x = 1, y = 5, chance = 90 },
        },
        item_groups = {
            C = {
                { group = "elecsto_homapl", chance = 30, repetitions = { 0, 3 } },
                { group = "elecsto_persele", chance = 20, repetitions = { 0, 2 } },
                { group = "elecsto_diy", chance = 60, repetitions = { 2, 4 } },
            },
            f = {
                { group = "electronics", chance = 50, repetitions = { 1, 2 } },
                { group = "elecsto_entapl", chance = 30, repetitions = { 1, 2 } },
                { group = "elecsto_stor", chance = 40, repetitions = { 2, 4 } },
            },
            B = {
                { group = "elecsto_diy", chance = 60, repetitions = { 1, 4 } },
                { group = "elecsto_books", chance = 40, repetitions = { 1, 2 } },
            },
            ["&"] = { { group = "feral_vampire_nest_dead_bodies", chance = 50 } },
        },
        field_placements = { { id = "fd_blood", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 1, 6 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 0, 5 }, y = { 0, 5 }, chance = 95 } },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            B = "t_floor",
            C = "t_floor",
            y = "t_floor",
            T = "t_floor",
            f = "t_floor",
            E = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            A = "f_stool",
            B = "f_workbench",
            E = "f_sofa",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            f = "f_table",
            h = "f_chair",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_sewing_open",
    weight = 100,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "BBT..C",
            "Bh===C",
            "B=Af=C",
            ".==f=.",
            "Ed=f=C",
            "yE&..C",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            C = {
                { group = "SUS_tailoring_materials", chance = 80, repetitions = { 3, 6 } },
                { group = "leather_shop_repair", chance = 40, repetitions = { 2, 4 } },
            },
            f = {
                { group = "SUS_tailoring_materials", chance = 50, repetitions = { 1, 2 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 1, 2 } },
                { group = "leather_shop_repair", chance = 40, repetitions = { 2, 4 } },
            },
            d = {
                { group = "pants", chance = 100 },
                { group = "shirts", chance = 100 },
                { group = "leather_shop_accessories", chance = 10 },
            },
            B = {
                { group = "SUS_tailoring_tool_drawer", chance = 60, repetitions = { 0, 1 } },
                { group = "tailorbooks", chance = 60, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
            ["&"] = { { group = "feral_vampire_nest_dead_bodies", chance = 50 } },
        },
        field_placements = { { id = "fd_blood", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 1, 6 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 0, 5 }, y = { 0, 5 }, chance = 95 } },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            B = "t_floor",
            C = "t_floor",
            y = "t_floor",
            T = "t_floor",
            E = "t_floor",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            d = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            f = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = {
            A = "f_stool",
            B = "f_workbench",
            E = "f_armchair",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            d = "f_mannequin",
            b = "f_bench",
            f = "f_table",
            h = "f_chair",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
    },
}
