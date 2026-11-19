local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "FUNERAL",
    vehicles = {
        { id = "car", weight = 300 },
        { id = "hearse", weight = 200 },
        { id = "suv", weight = 100 },
        { id = "policecar", weight = 50 },
    },
}
