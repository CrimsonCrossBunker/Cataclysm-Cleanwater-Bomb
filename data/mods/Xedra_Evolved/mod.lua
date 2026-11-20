local ccb = require("ccb")

return ccb.ModDefinition {
    id = "xedra_evolved",
    name = ccb.content.text("Xedra Evolved"),
    authors = { "Maleclypse", "Guardiandll", "StandingStorm" },
    maintainers = { "Maleclypse", "Guardiandll" },
    description = ccb.content.text("An urban fantasy content mod for Agent Mulder in the apocalypse.  Creates a multi decade timeline of dimensional spillage prior to the Cataclysm.  This spillage was characterized by thin places appearing where people could step through into another dimension, but things from those dimensions could wander into our world as well.  XEDRA proliferated into an alphabet soup of agencies dedicated to simultaneously stopping, controlling, and utilizing these thin places with varying degrees of success.  Contains monsters of various types, new professions and locations, new uses for existing skills,the new deduction skill, new magic systems, and content of every type that a multidimensional Cataclysm has to offer.  This is a heavily science-fantasy mod where you are as likely to encounter supernatural monsters as you are UFOs, Sasquatch, and Chupacabra.  Please examine the readme.md file for further details."),
    category = "content",
    conflicts = { "sorcerer", "aftershock_exoplanet" },
    dependencies = { "ccb" },
    loading_images = { "xedra1.png", "xedra2.png", "xedra3.png", "xedra4.png", "xedra5.png", "xedra6.png" },
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
