local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "personal_aircraft_small",
    vehicles = { { id = "aircanoe", weight = 60 }, { id = "airboat", weight = 40 } },
}

ccb.content.define_vehicle_group {
    id = "personal_aircraft_large",
    vehicles = { { id = "airship", weight = 100 } },
}
