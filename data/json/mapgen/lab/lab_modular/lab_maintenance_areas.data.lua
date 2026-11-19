local ccb = require("ccb")

-- maintenance maze
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_maintenance_z-2&3_A" },
    weight = 200,
    layout = {
        rows = {
            "|||||||||||¢||||||||||||",
            "????|,,,,,|;;;;;;±,,,,,|",
            "????|,,,,,|;;|||||,,,,,|",
            "????|,,,,,||;|,,,|,,,,,|",
            "????|,,,,,|;;|,,,+,,,,,|",
            "????|,,,,,|;;|,,,|,,,,,|",
            "||||||±|+|||±||||||||+||",
            "|;;ȣ;;;|,,,,,|?????|,,,|",
            "||;|||||,,,,,|||||||,,,|",
            "||;|???|,,,,,|,,,|;|,,,|",
            "||;|???|,,,,,+,,,+;||+||",
            "|;;|???|,,,,,|,,,|;+,,0|",
            "|;||||||||||||||||||,|0|",
            "|;|?|;;;;;;;|??|,,,|,|0|",
            "|;|?|;|||||;|??|,,,+,70|",
            "|;|?|;|???|;|??|,,,|,|0|",
            "|ȣ|?|ȣ|???|;||||+|±|,,0|",
            "|;|||;|???|;||,,,|¢|,,,|",
            "|;;;;;|???|;||,,,|;|A,,|",
            "|;|||||???|;||,,,|;|NN,|",
            "|ȣ|???|||?|ȣ||||||;|||±|",
            "|;|???|;|||;||||||;|||¢|",
            "|;|???|;;;;;;;;;;;;;ȣ;;;",
            "|||???||||||||||||||||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        fill_terrain = "t_linoleum_gray",
        nested = {
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 20,
                y = 7,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 14,
                y = 17,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_EW_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 16,
                y = 13,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_EW_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 14,
                y = 3,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_EW_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 14,
                y = 9,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 50 },
                    { id = "lab_maintenance_5x5_open", weight = 50 },
                },
                x = 5,
                y = 1,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 50 },
                    { id = "lab_maintenance_5x5_open", weight = 50 },
                },
                x = 18,
                y = 1,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 50 },
                    { id = "lab_maintenance_5x5_open", weight = 50 },
                },
                x = 8,
                y = 7,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 0,
                y = 2,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 3,
                y = 8,
            },
            {
                choices = {
                    { id = "lab_maintenance_5x5_room_NE", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 6,
                y = 14,
            },
            {
                choices = {
                    { id = "lab_maintenance_5x5_room_NE", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 2,
                y = 19,
            },
        },
        monster_placements = { { id = "mon_grenade_hack", x = 20, y = 5, chance = 90 } },
    },
}

-- maintenance maze
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_maintenance_z-2&3_A" },
    weight = 200,
    layout = {
        rows = {
            "|||||||||||¢||||||||||||",
            "?????|,,,|;;;;;;;;;|???|",
            "?????|,,,|||||||||±|||||",
            "?????|,,,|,,,,,,,|,,000|",
            "?|||||,,,+,,,,,,,|,,,,,|",
            "?||;||UUU|,,,,,,,|,,,,,|",
            "?|;;||±|||,,,,,,,|,,,,,|",
            "?|;|||¢|?|,,,,,,,|,,,,,|",
            "?|;|?|;|?|,,,,,,,|,,,,,|",
            "?|;|?|;|?|,,,,,,,|,,007|",
            "?|;|?|;|?||+|||||||+||||",
            "?|;|||;|?|,,,|?|,,,,007|",
            "?|;;;;;|?|,,,|||,,,,,|0|",
            "?|;|||;|?|,,,|,,,,,,,|0|",
            "?|;|||||||,,,+,,,,,,700|",
            "?|;;;|???|,,,|,,,,,,,,,|",
            "?|;|||???|,,,|,,,,,,,,,|",
            "?|;|?????|,,,|,,,,,,,,,|",
            "?|;|?|||||||||±|||||||||",
            "?|;|?|;;;;;|;|¢|????????",
            "?|;|||;|;|||;|;|||||????",
            "?|;;;;;|;;;;;;;;ȣ;;|||||",
            "?|||||||||||||||||;;;;;;",
            "?????????????????|||||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        fill_terrain = "t_linoleum_gray",
        nested = {
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 6,
                y = 1,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 10,
                y = 11,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 50 },
                    { id = "lab_maintenance_5x5_open", weight = 50 },
                },
                x = 18,
                y = 4,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 50 },
                    { id = "lab_maintenance_5x5_open", weight = 50 },
                },
                x = 15,
                y = 13,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 5,
                y = 14,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 1,
                y = 0,
            },
        },
        monster_placements = { { id = "mon_grenade_hack", x = 20, y = 5, chance = 90 } },
    },
}

-- maintenance maze
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lab_maintenance_z-2&3_A" },
    weight = 200,
    layout = {
        rows = {
            "??|||||||||¢||||||||||||",
            "|||???|;;;;;;;;;;;;;;;||",
            "|;|???|||||±|||||||||±||",
            "|;|???|,,,|,,,,,|t|,,,||",
            "|;|||||,,,|,,,,,+,|,,,||",
            "|;;;;¢±,,,|,,,,,|S|,,,||",
            "|;|;||||+||,,,,,||||+|||",
            "|;|;|?|;;;+,,,,,+;;;;;;|",
            "|;;;|?|||;||||||||||||||",
            "|;|||||||;|,,,,,|?||||||",
            "|;|,,,,,|;|,,,,,|?|,,,||",
            "|ȣ|,,,,,|;|,,,,,|?|,,,||",
            "|;|,,,,,+;|,,,,,|?|,,,||",
            "|;|,,,,,|;|,,,,,||||+|||",
            "|;|,,,,,|;;;;;;;+,,,,,||",
            "|;||||||||||||+||,,,,,||",
            "|;;;;;;;;;;¢±,,,|,,,,,±¢",
            "|||;|;|||||||,,,|,,,,,||",
            "|?|;;;|???|t|,,,|,,,,,|?",
            "|||;|;|???|,+,,A|||||||?",
            "|;;;;;|???|S|,NN|???????",
            "|;||||||||||||||||||||||",
            "|;;;;;;ȣ;;;;;;;;;;;;;;;;",
            "||||||||||||||||||||||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        fill_terrain = "t_linoleum_gray",
        nested = {
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 7,
                y = 3,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 19,
                y = 3,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 19,
                y = 10,
            },
            {
                choices = {
                    { id = "lab_maintenance_3x3_NS_open", weight = 90 },
                    { id = "null", weight = 10 },
                },
                x = 13,
                y = 16,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 25 },
                    { id = "lab_maintenance_5x5_open", weight = 75 },
                },
                x = 11,
                y = 3,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 25 },
                    { id = "lab_maintenance_5x5_open", weight = 75 },
                },
                x = 11,
                y = 9,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 25 },
                    { id = "lab_maintenance_5x5_open", weight = 75 },
                },
                x = 17,
                y = 14,
            },
            {
                choices = {
                    { id = "lab_common_5x5_open", weight = 25 },
                    { id = "lab_maintenance_5x5_open", weight = 75 },
                },
                x = 3,
                y = 10,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 6,
                y = 17,
            },
            {
                choices = { { id = "lab_maintenance_5x5_room_S", weight = 90 }, { id = "null", weight = 10 } },
                x = 2,
                y = 0,
            },
        },
        monster_placements = { { id = "mon_grenade_hack", x = 20, y = 5, chance = 90 } },
    },
}
