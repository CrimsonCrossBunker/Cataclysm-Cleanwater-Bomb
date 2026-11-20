local ccb = require("ccb")

return ccb.ModDefinition {
    id = "generic_guns",
    name = ccb.content.text("Generic Guns"),
    authors = { "Tonkatsu" },
    maintainers = { "CleverRaven" },
    description = ccb.content.text("Replaces guns and ammo with generic types.  Warning: can cause issues with other gun mods."),
    category = "accessibility",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
