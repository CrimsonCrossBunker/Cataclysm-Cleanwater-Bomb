local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "city_vehicles",
    vehicles = {
        { id = "bicycle_orichalcum", weight = 300 },
        { id = "dwarf_supercompact_car", weight = 1000 },
    },
}

ccb.content.define_vehicle_group {
    id = "suburban_home",
    vehicles = { { id = "bicycle_orichalcum", weight = 100 }, { id = "dwarf_supercompact_car", weight = 100 } },
}

ccb.content.define_vehicle_group {
    id = "dirtlot",
    vehicles = { { id = "bicycle_orichalcum", weight = 50 }, { id = "dwarf_supercompact_car", weight = 50 } },
}

ccb.content.define_vehicle_group {
    id = "parkinglot",
    vehicles = { { id = "bicycle_orichalcum", weight = 350 }, { id = "dwarf_supercompact_car", weight = 350 } },
}

ccb.content.define_vehicle_group {
    id = "campground_vehicles",
    vehicles = { { id = "bicycle_orichalcum", weight = 75 }, { id = "dwarf_supercompact_car", weight = 350 } },
}

ccb.content.define_vehicle_group {
    id = "bikeshop",
    vehicles = { { id = "bicycle_orichalcum", weight = 600 } },
}

ccb.content.define_vehicle_group {
    id = "back_alley",
    vehicles = { { id = "bicycle_orichalcum", weight = 450 } },
}

ccb.content.define_vehicle_group {
    id = "showroom_small_vehicles",
    vehicles = { { id = "bicycle_orichalcum", weight = 100 } },
}
