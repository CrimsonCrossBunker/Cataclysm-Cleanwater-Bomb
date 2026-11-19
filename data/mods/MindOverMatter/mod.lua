local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    world_options = {
        -- Sets a cap on maximum effective strength for characters.
        PLAYER_MAX_STR_VALUE = 35,
        -- Sets a cap on maximum effective dexterity for characters.
        PLAYER_MAX_DEX_VALUE = 35,
        -- Sets a cap on maximum effective perception for characters.
        PLAYER_MAX_PER_VALUE = 35,
    },
}
