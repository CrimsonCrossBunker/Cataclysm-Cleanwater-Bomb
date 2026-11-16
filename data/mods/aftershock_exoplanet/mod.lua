local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        GENERIC_PROFESSION_ID = "afs_salvor",
        GENERIC_SCENARIO_ID = "augustmoon",
        ZOMBIFY_INTO_ENABLED = false,
        WOUND_CHANCE = 0.0,
        CBM_SLOTS_ENABLED = true,
        GAME_EMP = true,
        CAPITALISM = true,
    },
}
