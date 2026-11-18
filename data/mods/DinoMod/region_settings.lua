local content = require("ccb").content

content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_parks = { { "dinozoo", 25 } },
})
