local ccb = require("ccb")

return ccb.ModDefinition {
    id = "MMA",
    name = ccb.content.text("Mythical Martial Arts"),
    authors = { "Photoloss" },
    maintainers = { "Hymore246" },
    description = ccb.content.text("A collection of fictional, mythologically inspired or otherwise unrealistic martial arts."),
    category = "misc_additions",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
