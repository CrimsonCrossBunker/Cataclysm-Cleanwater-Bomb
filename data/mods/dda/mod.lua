local ccb = require("ccb")

return ccb.ModDefinition {
    id = "ccb",
    name = ccb.content.text("Catharsis Covenant Basemodule"),
    description = ccb.content.text("Core content for Cataclysm-CB"),
    category = "content",
    core = true,
    data_path = "../../json",
    ordered_data_files = true,
}
