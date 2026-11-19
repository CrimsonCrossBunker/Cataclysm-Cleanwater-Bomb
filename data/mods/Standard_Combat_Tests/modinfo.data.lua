local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_day1",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "makeshift_machete", x = 11, y = 10, chance = 100 },
            { id = "mace_pipe", x = 12, y = 10, chance = 100 },
            { id = "spear_knife", x = 13, y = 10, chance = 100 },
            { id = "glock_17", x = 14, y = 10, ammo = 100, magazine = 100, chance = 100 },
            { id = "glock17_17", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_mid",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "fire_ax", x = 11, y = 10, chance = 100 },
            { id = "shillelagh", x = 12, y = 10, chance = 100 },
            { id = "knife_combat", x = 13, y = 10, chance = 100 },
            { group = "modular_ar15", x = 14, y = 10, ammo = 100, magazine = 100, chance = 100 },
            { id = "stanag30", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_late",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "nodachi", x = 11, y = 10, chance = 100 },
            { id = "broadsword", x = 11, y = 10, chance = 100 },
            { id = "mace", x = 12, y = 10, chance = 100 },
            { id = "lucern_hammer", x = 12, y = 10, chance = 100 },
            { id = "pike", x = 13, y = 10, chance = 100 },
            { id = "rapier", x = 13, y = 10, chance = 100 },
            { id = "m107a1", x = 14, y = 10, ammo = 100, chance = 100 },
            { id = "m107a1mag", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}
