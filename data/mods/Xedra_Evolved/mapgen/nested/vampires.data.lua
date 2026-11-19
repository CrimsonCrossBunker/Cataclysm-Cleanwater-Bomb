local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "nested_vampire_pack",
    layout = {
        monster_placements = {
            { id = "mon_vampire_strigoi", x = 12, y = 12, patrol = { { x = 12, y = 12 } } },
            { group = "GROUP_VAMPIRE_MOROI_TYPES", x = 4, y = 4, repetitions = { 6, 10 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_vamp_nest_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " &   ",
            "   i ",
            "& 0  ",
            " i i ",
            "     ",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["0"] = "f_brazier", i = "f_coffin_o", ["&"] = "f_coffin_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        loot_placements = {
            {
                id = "blood_rice_pudding",
                x = { 2, 4 },
                y = { 1, 3 },
                chance = 60,
                repetitions = { 1, 2 },
            },
            { id = "charcoal", x = 2, y = 1, chance = 100, repetitions = { 3, 10 } },
            { id = "bucket", x = 1, y = 1, chance = 100 },
            { id = "water_clean", x = 3, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
        monster_placements = {
            { id = "mon_vampire_strigoi", x = { 0, 4 }, y = { 0, 4 }, chance = 8 },
            { group = "GROUP_VAMPIRE_MOROI_TYPES", x = { 0, 4 }, y = { 0, 4 }, chance = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_corpse_pile_W",
    layout = {
        size = { width = 5, height = 5 },
        palettes = { "standard_domestic_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_placements = { { id = "corpse_generic_human", x = { 0, 4 }, y = { 0, 4 }, chance = 65 } },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, intensity = { 1, 3 }, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_messy_nest_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " &   ",
            "   i ",
            "& 0  ",
            " i i ",
            "     ",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["0"] = "f_brazier", i = "f_coffin_o", ["&"] = "f_coffin_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        loot_placements = {
            {
                id = "blood_rice_pudding",
                x = { 2, 4 },
                y = { 1, 3 },
                chance = 60,
                repetitions = { 1, 2 },
            },
            { id = "charcoal", x = 2, y = 1, chance = 100, repetitions = { 3, 10 } },
            { id = "bucket", x = 1, y = 1, chance = 100 },
            { id = "water_clean", x = 3, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
        item_placements = { { id = "corpse_generic_human", x = { 0, 4 }, y = { 0, 4 }, chance = 65 } },
        field_placements = { { id = "fd_blood", x = { 0, 4 }, y = { 0, 4 }, intensity = { 1, 3 }, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_bat_house_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "%#++#%",
            "%1  1%",
            "#1  1#",
            "#1  1#",
            "%1  1%",
            "%#++#%",
        },
        terrain = {
            ["#"] = "t_reinforced_glass_shutter_open",
            ["+"] = "t_reinforced_door_glass_c",
            ["%"] = "t_reinforced_glass_shutter",
            ["$"] = "t_wall_glass",
        },
        furniture = { ["1"] = "f_bat_roost" },
        rotation = { 0, 3 },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_rose" }, furniture = "f_planter_mature" } },
    },
}
