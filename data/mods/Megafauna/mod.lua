local ccb = require("ccb")

return ccb.ModDefinition {
    id = "megafauna",
    name = ccb.content.text("Megafauna"),
    authors = { "merrygin" },
    maintainers = { "merrygin" },
    description = ccb.content.text("Adds extinct pleistocene megafauna to the game, replacing modern day and introduced animals."),
    category = "creatures",
    dependencies = { "ccb" },
    obsolete = false,
    ordered_data_files = true,
}
