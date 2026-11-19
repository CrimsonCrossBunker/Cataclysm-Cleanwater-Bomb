local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "fcl_atomic_lamp",
    name = ccb.content.text("atomic lamp"),
    item = "fcl_atomic_lamp",
    location = "on_ceiling",
    categories = { "lighting" },
    color = "light_blue",
    durability = 20,
    description = ccb.content.text("A bright light, self-powered by an atomic decay reaction that never stops.  When turned on, it illuminates several squares inside the vehicle."),
    bonus = 30,
    folded_volume = "1 L",
    breaks_into = { { item = "scrap", probability = 50 } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "ATOMIC_LIGHT", "LEAK_DAM", "RADIOACTIVE" },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "fcl_atomic_light",
    copy_from = "fcl_atomic_lamp",
    name = ccb.content.text("atomic nightlight"),
    item = "fcl_atomic_light",
    description = ccb.content.text("A very dim light, self-powered by an atomic decay reaction that never stops.  When turned on, it illuminates a single square inside the vehicle that isn't suitable for crafting."),
    bonus = 5,
    folded_volume = "500 ml",
}
