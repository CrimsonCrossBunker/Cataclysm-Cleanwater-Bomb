local ccb = require("ccb")

return ccb.ModDefinition {
    id = "magiclysm",
    name = ccb.content.text("Magiclysm"),
    authors = { "KorGgenT", "GuardianDll", "Aptronym", "LaVeyanFiend", "Maleclypse", "Standing-Storm" },
    maintainers = { "Maleclypse", "Standing-Storm" },
    description = ccb.content.text("Cataclysm but with magic spells!"),
    category = "content",
    dependencies = { "ccb" },
    ordered_data_files = true,
    world_options = {
        -- Sets a cap on maximum effective strength for characters.
        PLAYER_MAX_STR_VALUE = 35,
        -- Sets a cap on maximum effective dexterity for characters.
        PLAYER_MAX_DEX_VALUE = 35,
        -- Sets a cap on maximum effective perception for characters.
        PLAYER_MAX_PER_VALUE = 35,
        -- Sets a cap on maximum effective inteligence for characters.
        PLAYER_MAX_INT_VALUE = 35,
    },
}
