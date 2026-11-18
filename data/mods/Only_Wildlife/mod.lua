local ccb = require("ccb")

return ccb.ModDefinition {
    id = "Only_Wildlife",
    name = ccb.content.text("No Monsters"),
    authors = { "Kodi Arfer" },
    description = ccb.content.text("Removes all monsters from the game, save for those in the WILDLIFE category."),
    category = "monster_exclude",
    dependencies = { "ccb" },
}
