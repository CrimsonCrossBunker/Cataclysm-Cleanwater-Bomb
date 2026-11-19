local ccb = require("ccb")

ccb.content.define_vehicle_group {
    id = "suburban_home",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 300 },
    },
}

ccb.content.define_vehicle_group {
    id = "parkinglot",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "car_sports_atomic", weight = 100 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 300 },
    },
}

ccb.content.define_vehicle_group {
    id = "parkinglotbasic",
    vehicles = { { id = "bubble_car", weight = 50 } },
}

ccb.content.define_vehicle_group {
    id = "parking_garage",
    vehicles = { { id = "bubble_car", weight = 200 } },
}

ccb.content.define_vehicle_group {
    id = "junkyard_vehicles",
    vehicles = { { id = "bubble_car", weight = 20 } },
}

-- For cs_car_showroom
ccb.content.define_vehicle_group {
    id = "oa_vg_cs_vehicles",
    vehicles = { { id = "bubble_car", weight = 60 } },
}

ccb.content.define_vehicle_group {
    id = "afs_lab_cars",
    vehicles = { { id = "bubble_car", weight = 20 }, { id = "car_sports_atomic", weight = 10 } },
}

ccb.content.define_vehicle_group {
    id = "afs_lab_utility",
    vehicles = { { id = "welding_cart", weight = 5 }, { id = "engine_crane", weight = 3 } },
}

ccb.content.define_vehicle_group {
    id = "city_vehicles",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 500 },
    },
}

ccb.content.define_vehicle_group {
    id = "city_pileup",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 300 },
    },
}

ccb.content.define_vehicle_group {
    id = "highway",
    vehicles = {
        { id = "car_atomic", weight = 1500 },
        { id = "suv_atomic", weight = 1500 },
        { id = "compact_atomic", weight = 300 },
    },
}

ccb.content.define_vehicle_group {
    id = "city_vehicles",
    vehicles = { { id = "robotic_taxi", weight = 300 }, { id = "armored_robot_carrier", weight = 100 } },
}

ccb.content.define_vehicle_group {
    id = "city_pileup",
    vehicles = { { id = "robotic_taxi", weight = 500 } },
}

ccb.content.define_vehicle_group {
    id = "highway",
    vehicles = { { id = "armored_robot_carrier", weight = 100 } },
}

ccb.content.define_vehicle_group {
    id = "military_vehicles",
    vehicles = { { id = "armored_robot_carrier", weight = 200 } },
}

ccb.content.define_vehicle_group {
    id = "parkinglot",
    vehicles = { { id = "robotic_taxi", weight = 100 } },
}

ccb.content.define_vehicle_group {
    id = "atomic_city_cars",
    vehicles = {
        { id = "car_atomic", weight = 1500 },
        { id = "suv_atomic", weight = 1500 },
        { id = "compact_atomic", weight = 300 },
    },
}
