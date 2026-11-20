local ccb = require("ccb")

return ccb.ModDefinition {
    id = "mindovermatter",
    name = ccb.content.text("Mind Over Matter"),
    authors = { "StandingStorm" },
    maintainers = { "StandingStorm" },
    description = ccb.content.text("Psionic powers for Cataclysm.  The Readme contains extensive information on how the process of gaining and using powers works, so make sure to check it if you're confused."),
    category = "content",
    dependencies = { "ccb" },
    conflicts = { "aftershock_exoplanet" },
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
