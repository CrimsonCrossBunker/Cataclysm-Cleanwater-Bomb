local ccb = require("ccb")

return ccb.ModDefinition {
    id = "extra_mut_scens",
    name = ccb.content.text("Extra Mutated Scenarios"),
    authors = { "Saicchi" },
    description = ccb.content.text("Extra scenarios with all possible mutation traits and thresholds."),
    category = "misc_additions",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
