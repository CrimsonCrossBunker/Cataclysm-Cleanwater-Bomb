local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_crystal_field_monsters_migo",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MI-GO_CAMP_OM",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 4, 15 },
            },
            {
                group = "GROUP_MI-GO_PSIONS",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_crystal_field_monsters_nether",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_NETHER_PORTAL",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 8, 15 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_crystal_field_monsters_feral_psions",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_FERAL_PSYCHIC",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 3, 6 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_crystal_field_monsters_mixed",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_CRYSTAL_FIELD",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 10, 16 },
            },
            {
                group = "GROUP_CRYSTAL_FIELD_PSYCHOACTIVE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 2, 5 },
            },
        },
    },
}
