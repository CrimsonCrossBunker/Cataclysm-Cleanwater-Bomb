local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_XEDRA_serum_transport",
    layout = {
        vehicle_placements = {
            {
                id = "armored_car_xedra_vanguard",
                x = 7,
                y = 15,
                chance = 100,
                status = 1,
                rotation = 0,
            },
        },
        monster_placements = {
            { id = "mon_zombie_scientist", x = 5, y = 17 },
            { id = "mon_zombie_labsecurity", x = 3, y = 15 },
            { id = "mon_zombie_labsecurity", x = 4, y = 15 },
            { id = "mon_zombie_labsecurity", x = 7, y = 13 },
            { id = "mon_zombie_labsecurity", x = { 10, 15 }, y = { 3, 13 } },
        },
        loot_placements = {
            {
                id = "9mm_casing",
                x = { 6, 8 },
                y = { 12, 13 },
                repetitions = { 4, 9 },
                chance = 100,
            },
            {
                id = "9mm_casing",
                x = { 10, 13 },
                y = { 3, 13 },
                repetitions = { 8, 22 },
                chance = 100,
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 6, 8 }, y = { 12, 13 }, repetitions = { 3, 6 } },
            { id = "fd_blood", x = { 12, 15 }, y = { 2, 4 }, repetitions = { 5, 10 } },
        },
    },
}
