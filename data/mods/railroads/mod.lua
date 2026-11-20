local ccb = require("ccb")

return ccb.ModDefinition {
    id = "railroads",
    name = ccb.content.text("Railroads"),
    authors = { "ZhilkinSerg" },
    description = ccb.content.text("Adds a surface railway network, stations, bridges, level crossings and motorized draisines.  New stations include a fueled two-seat draisine.  Previously generated terrain is not rebuilt."),
    category = "buildings",
    dependencies = { "ccb" },
    ordered_data_files = true,
}
