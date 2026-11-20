local ccb = require("ccb")

return ccb.ModDefinition {
    id = "crazy_cataclysm",
    name = ccb.content.text("Crazy Cataclysm"),
    authors = { "Maya" },
    description = ccb.content.text("Want a little crazy in your Cataclysm?  Try this one."),
    category = "misc_additions",
    dependencies = { "ccb" },
    ordered_data_files = true,
    world_options = {
        CRAZY = true,
    },
}
