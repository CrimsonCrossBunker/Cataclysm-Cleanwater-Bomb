local ccb = require("ccb")

return ccb.ModDefinition {
    id = "bombastic_perks",
    name = ccb.content.text("Bombastic Perks"),
    authors = { "bombasticSlacks" },
    maintainers = { "Maleclypse" },
    description = ccb.content.text("Killing enemies allows you to level up, unlocking powerful and fun perks for your character.  Just after game start a configuration menu should open to let you enable the mod."),
    category = "misc_additions",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
