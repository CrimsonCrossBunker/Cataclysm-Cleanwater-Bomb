local ccb = require("ccb")

-- Spawns a special monster fight and ID badge spwan if you have the yellow security badge.
ccb.content.define_mapgen {
    kind = "update",
    id = "magenta_security_card_spawn",
    layout = {
        loot_placements = { { id = "id_science_security_magenta", x = 21, y = 14, chance = 20 } },
        monster_placements = { { choices = { "mon_zombie_brute" }, x = 21, y = 14, chance = 100 } },
    },
}
