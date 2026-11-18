local content = require("ccb").content

content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_houses = { { "safe_house", 5 } },
    add_shops = { { "xe_crystalline_spire", 5 } },
    add_parks = { { "vampire_cathedral", 50 } },
})
