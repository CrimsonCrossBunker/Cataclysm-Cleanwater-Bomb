local ccb = require("ccb")

return ccb.ModDefinition {
    id = "DinoMod",
    name = ccb.content.text("DinoMod"),
    maintainers = { "ephemeralstoryteller", "damien", "LyleSy" },
    description = ccb.content.text("Adds dinosaurs.  Some rideable, others less friendly.  Life will find a way."),
    category = "creatures",
    dependencies = { "ccb" },
    ordered_data_files = true,
    world_options = {
        -- Sets a cap on maximum effective strength for characters.
        PLAYER_MAX_STR_VALUE = 40,
    },
}
