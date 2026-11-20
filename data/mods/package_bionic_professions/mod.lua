local ccb = require("ccb")

return ccb.ModDefinition {
    id = "package_bionic_professions",
    name = ccb.content.text("Bionic Professions"),
    authors = { "Erk/Everyone" },
    description = ccb.content.text("Numerous bionic starting professions."),
    category = "content",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
