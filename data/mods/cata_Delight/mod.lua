local ccb = require("ccb")

return ccb.ModDefinition {
    id = "cata_delight",
    name = ccb.content.text("Cataclysm Delight"),
    authors = { "续命狂蛤-江借时" },
    maintainers = { "续命狂蛤-江借时" },
    description = ccb.content.text("Cataclysm version of Farmer's Delight mod."),
    category = "content",
    ordered_data_files = true,
}
