local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "police_pileup",
    vehicles = { { id = "bearcub", weight = 40 } },
}

ccb.content.define_vehicle_group {
    id = "city_pileup",
    vehicles = { { id = "bearcub", weight = 8 } },
}

ccb.content.define_vehicle_group {
    id = "military_vehicles",
    vehicles = { { id = "bearcub", weight = 5 } },
}
