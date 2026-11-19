local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        -- Sets a cap on maximum effective strength for characters.
        PLAYER_MAX_STR_VALUE = 40,
    },
}
