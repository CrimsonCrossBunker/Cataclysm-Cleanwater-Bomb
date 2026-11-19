local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "veh_portable_generator",
    copy_from = "ap_portable_generator",
    name = ccb.content.text("portable gasoline generator"),
    description = ccb.content.text("A small portable generator, normally used for camping.  This generator is installed in a vehicle."),
    delete = { flags = { "ENGINE", "E_DIESEL_FUEL", "OBSTACLE", "COVERED", "APPLIANCE", "FLUIDTANK" } },
    extend = { flags = { "USE_TANKS" } },
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 5 }, { "soldering_standard", 5 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "veh_diesel_generator",
    copy_from = "ap_diesel_generator",
    name = ccb.content.text("diesel generator"),
    description = ccb.content.text("A powerful, large generator primarily used for street construction.  This generator is installed in a vehicle."),
    delete = { flags = { "ENGINE", "E_DIESEL_FUEL", "OBSTACLE", "COVERED", "APPLIANCE", "FLUIDTANK" } },
    extend = { flags = { "USE_TANKS" } },
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "veh_military_generator",
    copy_from = "ap_military_generator",
    name = ccb.content.text("military diesel generator"),
    description = ccb.content.text("A powerful, large generator with a camouflage-painted casing.  This generator is installed in a vehicle."),
    delete = { flags = { "ENGINE", "E_DIESEL_FUEL", "OBSTACLE", "COVERED", "APPLIANCE", "FLUIDTANK" } },
    extend = { flags = { "USE_TANKS" } },
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "veh_12000_gasoline_generator",
    copy_from = "ap_12000_gasoline_generator",
    name = ccb.content.text("high-output gasoline generator"),
    description = ccb.content.text("A 12,000-watt gasoline generator that remains relatively portable while providing enough power for an entire house.  This generator is installed in a vehicle."),
    delete = { flags = { "ENGINE", "E_DIESEL_FUEL", "OBSTACLE", "COVERED", "APPLIANCE", "FLUIDTANK" } },
    extend = { flags = { "USE_TANKS" } },
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
    },
}
