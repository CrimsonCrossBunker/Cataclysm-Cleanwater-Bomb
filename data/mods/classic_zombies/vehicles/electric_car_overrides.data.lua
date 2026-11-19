local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "car_hybrid",
    copy_from = "car_luxury",
    name = ccb.content.text("Luxury Station Wagon"),
}

ccb.content.define_vehicle {
    id = "car_micro_hybrid",
    copy_from = "car_micro",
    name = ccb.content.text("Microcar"),
}

ccb.content.define_vehicle {
    id = "car_micro_electric",
    copy_from = "car_micro",
    name = ccb.content.text("Microcar"),
}

ccb.content.define_vehicle {
    id = "scompact_hybrid",
    copy_from = "scompact",
    name = ccb.content.text("Supercompact Car"),
}

ccb.content.define_vehicle {
    id = "scompact_electric",
    copy_from = "scompact",
    name = ccb.content.text("Supercompact Car"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_stow",
    copy_from = "scompact_tandem_stow",
    name = ccb.content.text("Supercompact Tandem Car"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_hboard",
    copy_from = "scompact_tandem_hboard",
    name = ccb.content.text("Supercompact Tandem Car"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_2wheel_stow",
    copy_from = "scompact_tandem_2wheel_stow",
    name = ccb.content.text("Tandem Cabin Motorcycle"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_2wheel_hboard",
    copy_from = "scompact_tandem_2wheel_hboard",
    name = ccb.content.text("Tandem Cabin Motorcycle"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_3wheel_stow",
    copy_from = "scompact_tandem_3wheel_stow",
    name = ccb.content.text("Tandem Three-Wheeled Supercompact Car"),
}

ccb.content.define_vehicle {
    id = "scompact_tandem_electric_3wheel_hboard",
    copy_from = "scompact_tandem_3wheel_hboard",
    name = ccb.content.text("Tandem Three-Wheeled Supercompact Car"),
}

ccb.content.define_vehicle {
    id = "car_shootingbrake_electric",
    copy_from = "car_shootingbrake_v12",
    name = ccb.content.text("Premium Shooting Brake"),
}

ccb.content.define_vehicle {
    id = "car_shootingbrake_long_electric",
    copy_from = "car_shootingbrake_long_v12",
    name = ccb.content.text("Premium Shooting Brake"),
}

ccb.content.define_vehicle {
    id = "car_sedan_electric",
    copy_from = "car_sedan_luxury_v6",
    name = ccb.content.text("Luxury Sedan"),
}

ccb.content.define_vehicle {
    id = "car_sedan_luxury_electric",
    copy_from = "car_sedan_luxury_v6",
    name = ccb.content.text("Luxury Sedan"),
}

ccb.content.define_vehicle {
    id = "car_sedan_sports_electric",
    copy_from = "car_sedan_luxury_v6",
    name = ccb.content.text("Luxury Sedan"),
}

ccb.content.define_vehicle {
    id = "car_coupe_electric",
    copy_from = "car_coupe_sports_v6",
    name = ccb.content.text("V6 Sports Coupe"),
}

ccb.content.define_vehicle {
    id = "car_coupe_luxury_electric",
    copy_from = "car_coupe_luxury_v6",
    name = ccb.content.text("Luxury Coupe"),
}

ccb.content.define_vehicle {
    id = "car_coupe_sports_electric",
    copy_from = "car_coupe_sports_v12",
    name = ccb.content.text("V12 Sports Coupe"),
}

ccb.content.define_vehicle {
    id = "car_super_electric",
    copy_from = "car_super_v12",
    name = ccb.content.text("V12 Super Car"),
}

ccb.content.define_vehicle {
    id = "car_super_electric_alt",
    copy_from = "car_super_v12",
    name = ccb.content.text("V12 Super Car"),
}

ccb.content.define_vehicle {
    id = "car_sports_electric",
    copy_from = "car_super_v12",
    name = ccb.content.text("Sports Car"),
}

ccb.content.define_vehicle {
    id = "car_racing_electric",
    copy_from = "car_super_v12",
    name = ccb.content.text("Sports Car"),
}

ccb.content.define_vehicle {
    id = "electric_car",
    copy_from = "car_luxury",
    name = ccb.content.text("Luxury Station Wagon"),
}

ccb.content.define_vehicle {
    id = "suv_electric",
    copy_from = "suv",
    name = ccb.content.text("SUV"),
}

ccb.content.define_vehicle {
    id = "suv_electric_rack",
    copy_from = "suv",
    name = ccb.content.text("SUV with Bike Rack"),
    mounts = {
        { x = -4, y = -1, parts = { "bike_rack" } },
        { x = -4, y = 0, parts = { "bike_rack" } },
        { x = -4, y = 1, parts = { "bike_rack" } },
        { x = -4, y = 2, parts = { "bike_rack" } },
    },
}
