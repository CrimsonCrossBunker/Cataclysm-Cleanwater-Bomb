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
        { id = "rara_x", weight = 300 },
        { id = "rara_x_v3", weight = 75 },
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
    vehicles = {
        { id = "bubble_car", weight = 60 },
        { id = "rara_x", weight = 40 },
        { id = "rara_x_v3", weight = 10 },
        { id = "fcl_suv_geomagnetic_hover", weight = 20 },
    },
}

ccb.content.define_vehicle_group {
    id = "city_vehicles",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 500 },
        { id = "fcl_suv_geomagnetic_hover", weight = 50 },
    },
}

ccb.content.define_vehicle_group {
    id = "city_pileup",
    vehicles = {
        { id = "car_atomic", weight = 1000 },
        { id = "suv_atomic", weight = 1000 },
        { id = "compact_atomic", weight = 300 },
        { id = "fcl_suv_geomagnetic_hover", weight = 50 },
    },
}

ccb.content.define_vehicle_group {
    id = "highway",
    vehicles = {
        { id = "car_atomic", weight = 1500 },
        { id = "suv_atomic", weight = 1500 },
        { id = "compact_atomic", weight = 300 },
        { id = "rara_x", weight = 800 },
        { id = "rara_x_v3", weight = 200 },
        { id = "fcl_suv_geomagnetic_hover", weight = 50 },
    },
}

ccb.content.define_vehicle_group {
    id = "atomic_city_cars",
    vehicles = {
        { id = "car_atomic", weight = 1500 },
        { id = "suv_atomic", weight = 1500 },
        { id = "compact_atomic", weight = 300 },
    },
}

ccb.content.define_vehicle_group {
    id = "military_vehicles",
    vehicles = {
        { id = "fcl_plating_alloy_military_cargo_truck", weight = 100 },
        { id = "fcl_plating_alloy_military_cargo_truck_b", weight = 100 },
        { id = "fcl_plating_alloy_humvee", weight = 50 },
        { id = "fcl_plating_alloy_humvee_gl", weight = 25 },
        { id = "fcl_plating_alloy_humvee_tow", weight = 12 },
        { id = "fcl_plating_alloy_apc", weight = 50 },
        { id = "fcl_plating_alloy_apc-gl", weight = 25 },
        { id = "fcl_plating_alloy_aapc-mg", weight = 25 },
        { id = "fcl_plating_alloy_aapc-gl", weight = 12 },
    },
}
