local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
    rivers = false,
    lakes = false,
    ocean = false,
    ravines = false,
    forests = false,
    highways = false,
})
