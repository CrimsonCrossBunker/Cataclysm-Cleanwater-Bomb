local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "small_utility_vehicles",
    vehicles = {
        { id = "excavator", weight = 20 },
        { id = "trencher", weight = 20 },
        { id = "welding_cart", weight = 40 },
        { id = "engine_crane", weight = 60 },
        { id = "oa_work_light", weight = 80 },
    },
}
