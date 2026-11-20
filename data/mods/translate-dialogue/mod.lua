local ccb = require("ccb")

return ccb.ModDefinition {
    id = "translate_dialogue",
    name = ccb.content.text("Translate Complex Dialogue"),
    authors = { "I-am-Erk" },
    maintainers = { "Tektolnes" },
    description = ccb.content.text("Adds a translation for some of the weirder dialogue in game.  Keeps the original flavor dialogue visible."),
    category = "accessibility",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
