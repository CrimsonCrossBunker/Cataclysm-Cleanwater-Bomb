local ccb = require("ccb")

return ccb.ModDefinition {
    ordered_data_files = true,
    entry = "lua/main.lua",
}
