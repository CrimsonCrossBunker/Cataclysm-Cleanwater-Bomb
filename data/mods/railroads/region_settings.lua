local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
    highways = false,
    place_railroads = true,
    place_railroads_before_roads = true,
})

content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_houses = { { "railroad_station_city", 5 } },
})
