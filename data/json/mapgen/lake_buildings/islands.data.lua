local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest",
    layout = {
        predecessor_mapgen = "forest",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest_thick",
    layout = {
        predecessor_mapgen = "forest_thick",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest_water",
    layout = {
        predecessor_mapgen = "forest_water",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_field",
    layout = {
        predecessor_mapgen = "field",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_sand",
    layout = {
        rows = {
            "********~./////.....~***",
            "***ddddddd/////.....~~**",
            "***ddddddd////........~*",
            "******~..///////....~~~*",
            "******~.//////////...~~*",
            "******~///////////....~~",
            "*~~~...///////////..~~~~",
            "~~.....////////////..~~~",
            "~~..////////////////...~",
            "~~..//////////////////.~",
            "~~..//////////////////.~",
            "~../////./////////////.~",
            "~..///////////////////.~",
            "~..///////////////////~~",
            "~..///////////////////.~",
            "~~.///////////////////.~",
            "~..////.//////////////~~",
            "~..///////////////////~~",
            "~..///////////////////.~",
            "~~.////////////.//////.~",
            "~~...///////////////..~~",
            "*~~.../////////////..~~*",
            "**~~~~~~~~////~..~~~****",
            "****~~**~~~//~~~~~~*****",
        },
        terrain = {
            ["/"] = "t_sand",
            ["~"] = "t_water_sh",
            ["*"] = "t_water_dp",
            ["8"] = "t_railroad_rubble",
            ["."] = "t_sand",
            d = "t_dock",
        },
        furniture = {
            ["."] = {
                { id = "f_boulder_medium", copies = 1 },
                { id = "f_boulder_small", copies = 1 },
                { id = "f_boulder_large", copies = 2 },
            },
        },
        fill_terrain = "t_sand",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
        vehicle_placements = {
            { id = "boat_motor_single", x = 4, y = 5, rotation = 180, chance = 10, status = 3 },
            { id = "canoe", x = 5, y = 0, rotation = 180, chance = 5, status = 0 },
        },
        loot_placements = {
            { id = "rope_30", x = 4, y = 1, chance = 100 },
            { id = "rope_30", x = 7, y = 2, chance = 100 },
        },
    },
}
