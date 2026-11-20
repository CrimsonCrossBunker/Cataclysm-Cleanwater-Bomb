local ccb = require("ccb")

return ccb.ModDefinition {
    id = "perk_melee_system",
    name = ccb.content.text("Martial Mastery"),
    authors = { "John-Candlebury" },
    maintainers = { "John-Candlebury" },
    description = ccb.content.text("Fight enemies to level up and build your own fighting style."),
    category = "misc_additions",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
