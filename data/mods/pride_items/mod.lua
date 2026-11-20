local ccb = require("ccb")

return ccb.ModDefinition {
    id = "pride_items",
    name = ccb.content.text("Pride Items"),
    authors = { "The Cataclysm: Dark Days Ahead team" },
    description = ccb.content.text("Adds pride-themed clothing variants and pins."),
    category = "content",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
