local ccb = require("ccb")

-- Rated 28 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_apartment_fridge",
    name = ccb.content.text("fridge"),
    looks_like = "f_fridge",
    categories = { "cargo" },
    color = "light_blue",
    broken_color = "light_blue",
    damage_modifier = 80,
    durability = 100,
    description = ccb.content.text("A standard household refrigerator.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-42 W",
    size = "311 L",
    item = "apartment_fridge",
    location = "center",
    requirements = {
        removal = { duration = "2 m" },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
    },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    breaks_into = { { group = "apartment_fridge_destroyed" } },
    damage_reduction = { all = 32 },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- Rated 30 kwh on average, but since you use it, and it's upright, 1.5x as much
-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "ap_minifridge",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("minifridge"),
    looks_like = "f_fridge",
    categories = { "cargo" },
    description = ccb.content.text("A small fridge.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-45 W",
    size = "96 L",
    item = "minifridge",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "soldering_standard", 5 } },
        },
    },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    breaks_into = { { group = "minifridge_destroyed" } },
    damage_reduction = { all = 32 },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 34 kwh, but since you open it and use it, and because it's upright, 1.5 as much
ccb.content.define_vehicle_part {
    id = "ap_big_portable_fridge",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("food truck fridge"),
    description = ccb.content.text("A heavy, portable fridge.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    looks_like = "minifridge",
    epower = "-51 W",
    size = "250 L",
    item = "big_portable_fridge",
    breaks_into = { { group = "big_portable_fridge_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- Rated 94 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_glass_fridge",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("single glass door fridge"),
    looks_like = "f_glass_fridge",
    categories = { "cargo" },
    durability = 50,
    description = ccb.content.text("A commercial refrigerator with a glass door.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-141 W",
    size = "347 L",
    item = "glass_fridge",
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    breaks_into = { { group = "glass_fridge_destroyed" } },
    damage_reduction = { all = 16 },
}

-- Rated 240 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_glass_fridge_double",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("double glass door fridge"),
    looks_like = "f_glass_fridge",
    categories = { "cargo" },
    durability = 50,
    description = ccb.content.text("A commercial refrigerator with two glass doors.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-360 W",
    size = "991 L",
    item = "glass_fridge_double",
    requirements = {
        removal = { duration = "2 m" },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
    },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    breaks_into = { { group = "glass_fridge_double_destroyed" } },
    damage_reduction = { all = 16 },
}

-- Rated 40 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_heavy_duty_fridge",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("heavy-duty fridge"),
    looks_like = "f_fridge",
    categories = { "cargo" },
    description = ccb.content.text("A heavy-duty refrigerator.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-60 W",
    size = "700 L",
    item = "heavy_duty_fridge",
    requirements = {
        removal = { duration = "2 m" },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
    },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    breaks_into = { { group = "heavy_duty_fridge_destroyed" } },
    damage_reduction = { all = 32 },
}

-- Rated 137 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_display_fridge",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("display fridge"),
    looks_like = "f_fridge",
    categories = { "cargo" },
    description = ccb.content.text("A display fridge.  When turned on, it will cool the food inside, extending the time until the food spoils."),
    epower = "-205 W",
    size = "600 L",
    item = "display_fridge",
    requirements = {
        removal = { duration = "2 m" },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
    },
    breaks_into = { { group = "display_fridge_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FRIDGE",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
}

-- Rated 30 kwh on average, but since you use it, and it's upright, 1.5x as much
ccb.content.define_vehicle_part {
    id = "ap_apartment_freezer",
    copy_from = "ap_apartment_fridge",
    name = ccb.content.text("freezer"),
    looks_like = "f_fridge",
    categories = { "cargo" },
    description = ccb.content.text("A common upright freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    size = "122 L",
    epower = "-45 W",
    item = "apartment_freezer",
    requirements = {
        removal = { duration = "2 m" },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 5 } },
        },
    },
    breaks_into = { { group = "apartment_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
}

-- 31 kwh, but since you open and use it, and because it's upright, 1.5x as much
-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "ap_minifreezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("minifreezer"),
    description = ccb.content.text("A small freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    categories = { "cargo" },
    epower = "-46 W",
    size = "90 L",
    item = "minifreezer",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "soldering_standard", 5 } },
        },
    },
    breaks_into = { { group = "minifreezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
}

-- 22 kwh, but since you open it and use it, 1.2 as much
-- listed capacity is 99L, but internal dimensions are 117L. 100 L for round number.
ccb.content.define_vehicle_part {
    id = "ap_chest_minifreezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("chest minifreezer"),
    description = ccb.content.text("A small chest freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    looks_like = "f_chest_minifreezer",
    epower = "-26 W",
    item = "chest_minifreezer",
    size = "99 L",
    breaks_into = { { group = "chest_minifreezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 141 kwh, but since you open it and use it, and because it's upright, 1.5 as much
ccb.content.define_vehicle_part {
    id = "ap_big_portable_freezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("food truck freezer"),
    description = ccb.content.text("A heavy, portable freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    looks_like = "f_heavy_duty_freezer",
    epower = "-211 W",
    size = "250 L",
    item = "big_portable_freezer",
    breaks_into = { { group = "big_portable_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 30 kwh, but since you open it and use it, 1.2 as much
ccb.content.define_vehicle_part {
    id = "ap_chest_freezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("chest freezer"),
    description = ccb.content.text("A big chest freezer.  When turned on, it will freeze the food inside, preventing any further expiration.  Don't fall in!"),
    looks_like = "f_freezer",
    epower = "-36 W",
    size = "350 L",
    item = "chest_freezer",
    breaks_into = { { group = "chest_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 384 kwh, but since you open it and use it, and because it's upright, 1.5 as much
ccb.content.define_vehicle_part {
    id = "ap_heavy_duty_freezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("heavy-duty freezer"),
    description = ccb.content.text("A heavy-duty freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    looks_like = "f_heavy_duty_freezer",
    epower = "-576 W",
    size = "745 L",
    item = "heavy_duty_freezer",
    breaks_into = { { group = "heavy_duty_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 304 kwh, but since you open it and use it, and because it's upright, 1.5 as much
ccb.content.define_vehicle_part {
    id = "ap_glass_freezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("glass door freezer"),
    description = ccb.content.text("A glass door freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    looks_like = "f_glass_freezer",
    epower = "-456 W",
    size = "400 L",
    item = "glass_freezer",
    breaks_into = { { group = "glass_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 23 kwh, but since you open it and use it, 1.2 as much
ccb.content.define_vehicle_part {
    id = "ap_display_freezer",
    copy_from = "ap_apartment_freezer",
    name = ccb.content.text("display freezer"),
    description = ccb.content.text("A display freezer.  When turned on, it will freeze the food inside, preventing any further expiration."),
    looks_like = "f_display_freezer",
    epower = "-27 W",
    size = "320 L",
    item = "display_freezer",
    breaks_into = { { group = "display_freezer_destroyed" } },
    flags = {
        "CARGO",
        "OBSTACLE",
        "FREEZER",
        "COVERED",
        "ENABLED_DRAINS_EPOWER",
        "APPLIANCE",
        "CTRL_ELECTRONIC",
    },
    variants = { { symbols = "H", broken_symbols = "#" } },
}
