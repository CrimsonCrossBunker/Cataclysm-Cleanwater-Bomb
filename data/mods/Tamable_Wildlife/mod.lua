local ccb = require("ccb")

return ccb.ModDefinition {
    id = "Tamable_Wildlife",
    name = ccb.content.text("Tamable Wildlife"),
    authors = { "Termineitor244" },
    maintainers = { "Termineitor244" },
    description = ccb.content.text("Makes a lot of docile, but generally untamable wildlife, tamable."),
    category = "rebalance",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
