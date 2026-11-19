local ccb = require("ccb")

return ccb.ModDefinition {
    id = "sorcerer",
    name = ccb.content.text("Sorcerer"),
    authors = { "Lightwave" },
    maintainers = { "Lightwave" },
    description = ccb.content.text("A different way to play Magiclysm.  Gain spells and spell levels from killing enemies instead of reading books."),
    category = "rebalance",
    conflicts = { "xedra_evolved" },
    dependencies = { "ccb", "magiclysm" },
    ordered_data_files = true,
}
