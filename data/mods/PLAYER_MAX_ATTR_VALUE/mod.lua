local ccb = require("ccb")

return ccb.ModDefinition {
    id = "PLAYER_MAX_ATTR_VALUE",
    name = ccb.content.text("Remove attribute limits"),
    authors = { "LunaGlaze" },
    description = ccb.content.text("This mod adjusts the player's attribute cap to `int.max-2`, effectively removing the attribute cap restriction.  This mod needs to be placed at the bottom of the sorted list for it to work correctly."),
    category = "rebalance",
    dependencies = { "ccb" },
    world_options = {
        -- Sets a cap on maximum effective strength for characters.
        PLAYER_MAX_STR_VALUE = 2147483645,
        -- Sets a cap on maximum effective dexterity for characters.
        PLAYER_MAX_DEX_VALUE = 2147483645,
        -- Sets a cap on maximum effective perception for characters.
        PLAYER_MAX_PER_VALUE = 2147483645,
        -- Sets a cap on maximum effective intelligence for characters.
        PLAYER_MAX_INT_VALUE = 2147483645,
    },
}
