local ccb = require("ccb")

return ccb.ModDefinition {
    id = "dda_tutorial",
    name = ccb.content.text("Tutorial"),
    description = ccb.content.text("Tutorial for Cataclysm-DDA"),
    category = "content",
    -- Marked as obsolete so it doesn't appear in the mod selection list
    obsolete = true,
    ordered_data_files = true,
}
