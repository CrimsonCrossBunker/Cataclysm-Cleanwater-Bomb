local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_prison_bus",
    layout = {
        vehicle_placements = { { id = "bus_prison", x = 17, y = 6, rotation = 270 } },
        monster_group_placements = {
            {
                group = "GROUP_ZOMBIE_PRISON",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 5 },
                density = 0.1,
            },
            {
                group = "GROUP_ZOMBIE_COP",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 0, 1 },
                density = 0.1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_prison_bus",
    layout = {
        vehicle_placements = { { id = "bus_prison", x = 5, y = 15, rotation = 180 } },
        monster_group_placements = {
            {
                group = "GROUP_ZOMBIE_PRISON",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 5 },
                density = 0.1,
            },
            {
                group = "GROUP_ZOMBIE_COP",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 0, 1 },
                density = 0.1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_prison_bus",
    layout = {
        vehicle_placements = {
            { id = "bus_prison", x = 12, y = 12, rotation = 270 },
            { id = "highway", x = 11, y = 11, rotation = 90 },
        },
        monster_group_placements = {
            {
                group = "GROUP_ZOMBIE_PRISON",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 5 },
                density = 0.1,
            },
            {
                group = "GROUP_ZOMBIE_COP",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 0, 1 },
                density = 0.1,
            },
            { group = "GROUP_ZOMBIE", x = { 0, 23 }, y = { 0, 23 }, density = 0.1 },
        },
    },
}
