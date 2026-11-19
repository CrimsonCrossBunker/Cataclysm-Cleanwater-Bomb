local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_prison_van",
    layout = {
        vehicle_placements = {
            { id = "prisoner_van_1", x = 7, y = 12, status = 1, rotation = 330 },
            { id = "motorcycle_enduro", x = 16, y = 8, chance = 75, status = -1, rotation = 45 },
        },
        monster_group_placements = {
            {
                group = "GROUP_ZOMBIE_PRISON",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 0, 1 },
                density = 0.1,
            },
        },
        loot_placements = {
            { id = "223_casing", x = { 15, 17 }, y = { 7, 9 }, chance = 100, repetitions = 60 },
            { id = "stanag30", x = { 15, 17 }, y = { 7, 9 }, chance = 60 },
            {
                id = "9mm_casing",
                x = { 4, 8 },
                y = { 11, 13 },
                repetitions = { 3, 6 },
                chance = 100,
            },
            { id = "corpse_gunned", x = 7, y = 12, chance = 100 },
            { id = "corpse_gunned", x = 7, y = 14, chance = 100 },
            { id = "shot_hull", x = { 6, 8 }, y = { 16, 18 }, repetitions = { 2, 5 }, chance = 100 },
        },
    },
}
