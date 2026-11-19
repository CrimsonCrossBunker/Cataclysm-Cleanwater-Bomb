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
