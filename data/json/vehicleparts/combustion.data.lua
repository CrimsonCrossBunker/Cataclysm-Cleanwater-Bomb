local ccb = require("ccb")

-- A combustion engine.  Burns fuel from a tank in the vehicle.
ccb.content.define_vehicle_part {
    abstract = "engine_combustion",
    categories = { "movement" },
    location = "engine_block",
    color = "light_red",
    broken_color = "red",
    damage_modifier = 80,
    backfire_threshold = 0.25,
    backfire_frequency = 20,
    noise_factor = 15,
    damaged_power_factor = 0.25,
    m2c = 50,
    flags = { "ENGINE", "E_COMBUSTION", "E_ALTERNATOR", "E_HIGHER_SKILL", "E_HEATER" },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

-- 30% energy efficiency
-- A combustion engine for use on aircraft.  Burns gasoline or avgas fuel from a tank in the vehicle.
ccb.content.define_vehicle_part {
    abstract = "aero_engine",
    copy_from = "engine_combustion",
    fuel_type = "avgas",
    fuel_options = { "avgas", "gasoline" },
    m2c = 60,
}

-- 40% energy efficiency
-- A combustion engine.  Burns diesel fuel from a tank in the vehicle.  Can also burn biodiesel or kerosene, though somewhat less efficiently.
ccb.content.define_vehicle_part {
    abstract = "diesel_engine",
    copy_from = "engine_combustion",
    fuel_type = "diesel",
    fuel_options = { "diesel", "biodiesel", "lamp_oil", "motor_oil", "jp8" },
    m2c = 65,
    extend = { flags = { "E_COLD_START", "E_DIESEL_FUEL" } },
}

-- 30% energy efficiency
-- A combustion engine.  Burns gasoline fuel from a tank in the vehicle.
ccb.content.define_vehicle_part {
    abstract = "gasoline_engine",
    copy_from = "engine_combustion",
    fuel_type = "gasoline",
    m2c = 60,
}

-- 25% energy efficiency
-- An advanced combustion engine.  Burns gasoline or diesel or aviation fuel from a tank in the vehicle.  Can also burn kerosene, though somewhat less efficiently.  Better power-to-weight ratio than a traditional engine, but consumes more fuel.
ccb.content.define_vehicle_part {
    abstract = "gas_turbine_engine",
    copy_from = "engine_combustion",
    fuel_type = "gasoline",
    fuel_options = { "gasoline", "diesel", "lamp_oil", "jp8", "motor_oil", "avgas", "biodiesel" },
    m2c = 60,
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_i6",
    copy_from = "diesel_engine",
    item = "i6_diesel",
    description = ccb.content.text("An industrial-sized 6-cylinder diesel engine, commonly called a straight-six.  About as powerful as a V6 engine but significantly larger for use in heavy equipment."),
    durability = 400,
    epower = "-350 W",
    power = "223800 W",
    energy_consumption = "559500 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 40 } },
        { item = "ch_steel_chunk", count = { 30, 40 } },
        { item = "scrap", count = { 30, 40 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 100 },
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_inline4",
    copy_from = "diesel_engine",
    item = "i4_diesel",
    description = ccb.content.text("A four-cylinder diesel engine, commonly found in small passenger cars and light trucks."),
    durability = 300,
    epower = "-200 W",
    power = "93250 W",
    energy_consumption = "266000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 20, 30 } },
        { item = "ch_steel_chunk", count = { 20, 30 } },
        { item = "scrap", count = { 20, 30 } },
    },
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
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 50 },
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_inline1",
    copy_from = "diesel_engine",
    durability = 300,
    item = "i1_diesel",
    description = ccb.content.text("A small, diesel powered one-cylinder, four-stroke air-cooled engine."),
    epower = "-200 W",
    power = "23300 W",
    energy_consumption = "58200 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 10, 20 } },
        { item = "ch_steel_chunk", count = { 10, 20 } },
        { item = "scrap", count = { 10, 20 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 1 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_v6",
    copy_from = "diesel_engine",
    item = "v6_diesel",
    description = ccb.content.text("A powerful 6-cylinder diesel engine, typical of a bus, RV, large van, or armored personnel carrier."),
    durability = 400,
    epower = "-250 W",
    power = "149200 W",
    energy_consumption = "373000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 40 } },
        { item = "ch_steel_chunk", count = { 30, 40 } },
        { item = "scrap", count = { 30, 40 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 100 },
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_v8",
    copy_from = "diesel_engine",
    item = "v8_diesel",
    description = ccb.content.text("A large 8-cylinder diesel engine, powerful enough for a semi truck, armored car, or Humvee."),
    durability = 400,
    epower = "-350 W",
    power = "242450 W",
    energy_consumption = "606250 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 40 } },
        { item = "ch_steel_chunk", count = { 30, 40 } },
        { item = "scrap", count = { 30, 40 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 5 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 100 },
}

ccb.content.define_vehicle_part {
    id = "engine_1cyl",
    copy_from = "gasoline_engine",
    item = "1cyl_combustion",
    description = ccb.content.text("A 50 cc gasoline engine, suitable for a lawnmower, golf cart or moped."),
    durability = 150,
    power = "7370 W",
    energy_consumption = "18425 W",
    folded_volume = "12 L",
    breaks_into = {
        { item = "ch_steel_lump", count = { 1, 2 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 1 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 40 },
}

ccb.content.define_vehicle_part {
    id = "engine_1cyl_large",
    copy_from = "gasoline_engine",
    item = "1cyl_combustion_large",
    description = ccb.content.text("A high-compression, 200 cc single-cylinder 4-stroke combustion engine, suitable for a dirt bike or scooter."),
    durability = 150,
    power = "21000 W",
    energy_consumption = "49800 W",
    folded_volume = "42 L",
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 8 } },
        { item = "ch_steel_chunk", count = { 4, 8 } },
        { item = "scrap", count = { 4, 8 } },
    },
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
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 2 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 40 },
}

ccb.content.define_vehicle_part {
    id = "engine_1cyl_med",
    copy_from = "engine_1cyl_large",
    item = "1cyl_combustion_med",
    description = ccb.content.text("A high-compression, 150 cc single-cylinder 4-stroke combustion engine, suitable for a dirt bike, scooter or generator."),
}

ccb.content.define_vehicle_part {
    id = "engine_1cyl_diesel_large",
    copy_from = "diesel_engine",
    item = "engine_1cyl_diesel_large",
    description = ccb.content.text("A high-compression, 200 cc single-cylinder 4-stroke diesel combustion engine, suitable for a dirt bike, scooter, or generator."),
    durability = 150,
    power = "22000 W",
    energy_consumption = "55000 W",
    folded_volume = "42 L",
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 8 } },
        { item = "ch_steel_chunk", count = { 4, 8 } },
        { item = "scrap", count = { 4, 8 } },
    },
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
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 2 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 40 },
}

ccb.content.define_vehicle_part {
    id = "engine_1cyl_small",
    copy_from = "gasoline_engine",
    item = "1cyl_combustion_small",
    description = ccb.content.text("A small 25 cc gasoline engine, suitable for a hedge trimmer or installing on a bicycle."),
    durability = 120,
    power = "3728 W",
    energy_consumption = "9320 W",
    folded_volume = "6 L",
    breaks_into = {
        { item = "ch_steel_lump", count = { 0, 1 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 40 },
}

ccb.content.define_vehicle_part {
    id = "engine_aero_light",
    copy_from = "aero_engine",
    item = "aero_engine_light",
    description = ccb.content.text("An air-cooled, 4-cylinder, horizontally opposed internal combustion engine, rated for 150 horsepower.  Commonly used on light aircraft."),
    durability = 300,
    epower = "-200 W",
    power = "111900 W",
    energy_consumption = "373000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 40 } },
        { item = "ch_steel_chunk", count = { 30, 40 } },
        { item = "scrap", count = { 30, 40 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 2 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 50 },
}

ccb.content.define_vehicle_part {
    id = "engine_inline4",
    copy_from = "gasoline_engine",
    item = "i4_combustion",
    description = ccb.content.text("A 1600 cc four-cylinder gasoline engine, commonly found in small passenger cars."),
    durability = 300,
    epower = "-150 W",
    power = "93250 W",
    energy_consumption = "311000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 20, 30 } },
        { item = "ch_steel_chunk", count = { 20, 30 } },
        { item = "scrap", count = { 20, 30 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 50 },
}

ccb.content.define_vehicle_part {
    id = "engine_v12",
    copy_from = "gasoline_engine",
    item = "v12_combustion",
    description = ccb.content.text("A massive and extremely powerful 12-cylinder combustion engine, usually built into high-end sports cars."),
    durability = 600,
    epower = "-350 W",
    power = "447600 W",
    energy_consumption = "1492000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 45, 58 } },
        { item = "ch_steel_chunk", count = { 45, 58 } },
        { item = "scrap", count = { 45, 58 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 5 },
                { "repair_welding_alloys", 4 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 110 },
}

ccb.content.define_vehicle_part {
    id = "diesel_engine_v12",
    copy_from = "diesel_engine",
    item = "v12_diesel",
    description = ccb.content.text("A massive and extremely powerful 12-cylinder diesel engine, usually built into heavy trucks."),
    durability = 600,
    epower = "-400 W",
    power = "447600 W",
    energy_consumption = "1119000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 45, 58 } },
        { item = "ch_steel_chunk", count = { 45, 58 } },
        { item = "scrap", count = { 45, 58 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 5 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 8 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 8 },
                { "repair_welding_alloys", 2 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 110 },
}

ccb.content.define_vehicle_part {
    id = "engine_v6",
    copy_from = "gasoline_engine",
    item = "v6_combustion",
    description = ccb.content.text("A powerful 6-cylinder gasoline engine strong enough for a pickup truck, SUV, or full-size van."),
    durability = 400,
    epower = "-200 W",
    power = "149200 W",
    energy_consumption = "497500 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 40 } },
        { item = "ch_steel_chunk", count = { 30, 40 } },
        { item = "scrap", count = { 30, 40 } },
    },
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
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 2 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 100 },
}

ccb.content.define_vehicle_part {
    id = "engine_v8",
    copy_from = "gasoline_engine",
    item = "v8_combustion",
    description = ccb.content.text("A heavy-duty 8-cylinder gasoline engine, like you might find in a fire truck, ambulance, or tow truck."),
    durability = 400,
    epower = "-250 W",
    power = "242450 W",
    energy_consumption = "808200 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 40, 50 } },
        { item = "ch_steel_chunk", count = { 40, 50 } },
        { item = "scrap", count = { 40, 50 } },
    },
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
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 4 },
                { "repair_welding_alloys", 3 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 100 },
}

ccb.content.define_vehicle_part {
    id = "engine_vtwin",
    copy_from = "gasoline_engine",
    item = "v2_combustion",
    description = ccb.content.text("A 600 cc, two-cylinder, gas engine for a fast motorcycle or very small car."),
    durability = 200,
    epower = "-50 W",
    power = "37300 W",
    energy_consumption = "124500 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 7, 15 } },
        { item = "ch_steel_chunk", count = { 7, 15 } },
        { item = "scrap", count = { 7, 15 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 1 },
                { "repair_welding_alloys", 1 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 60 },
}

-- 50% energy efficiency
ccb.content.define_vehicle_part {
    abstract = "steam_engine",
    copy_from = "engine_combustion",
    fuel_type = "coal_lump",
    fuel_options = { "coal_lump", "charcoal" },
    looks_like = "diesel_engine_v12",
    m2c = 65,
    extend = { flags = { "E_COLD_START" } },
    backfire_threshold = 0.7,
    backfire_frequency = 10,
    noise_factor = 20,
    damage_reduction = { all = 75 },
}

ccb.content.define_vehicle_part {
    id = "engine_steam_makeshift",
    copy_from = "steam_engine",
    item = "steam_watts_small",
    description = ccb.content.text("A small, primitive steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    durability = 200,
    power = "55950 W",
    energy_consumption = "112000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 60 } },
        { item = "ch_steel_chunk", count = { 30, 60 } },
        { item = "scrap", count = { 30, 60 } },
        { item = "water", count = { 50, 120 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "vehicle_wrench_1", 1 } },
        },
    },
    damage_reduction = { all = 40 },
}

ccb.content.define_vehicle_part {
    id = "engine_steam_small",
    copy_from = "steam_engine",
    item = "steam_triple_small",
    description = ccb.content.text("A small steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    durability = 200,
    power = "93250 W",
    energy_consumption = "186500 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 60 } },
        { item = "ch_steel_chunk", count = { 30, 60 } },
        { item = "scrap", count = { 30, 60 } },
        { item = "water", count = { 50, 120 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 5 }, { "vehicle_wrench_1", 1 } },
        },
    },
    damage_reduction = { all = 45 },
}

ccb.content.define_vehicle_part {
    id = "engine_steam_medium",
    copy_from = "steam_engine",
    item = "steam_triple_medium",
    description = ccb.content.text("A medium-sized steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    durability = 200,
    epower = "-20 W",
    power = "149200 W",
    energy_consumption = "298500 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 30, 60 } },
        { item = "ch_steel_chunk", count = { 30, 60 } },
        { item = "scrap", count = { 30, 60 } },
        { item = "water", count = { 50, 120 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_standard", 6 }, { "vehicle_wrench_1", 1 } },
        },
    },
    damage_reduction = { all = 50 },
}

ccb.content.define_vehicle_part {
    id = "engine_turbine_small",
    copy_from = "gas_turbine_engine",
    item = "small_turbine_engine",
    description = ccb.content.text("A small gas turbine engine, suitable for powering a small one or two-seat helicopter."),
    durability = 400,
    epower = "-10 W",
    power = "484705 W",
    energy_consumption = "1938820 W",
    breaks_into = {
        { item = "alloy_plate", count = { 1, 2 } },
        { item = "ch_steel_lump", count = { 45, 58 } },
        { item = "ch_steel_chunk", count = { 45, 58 } },
        { item = "scrap", count = { 45, 58 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 5 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 8 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "repair_welding_alloys", 2 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 60 },
}

ccb.content.define_vehicle_part {
    id = "engine_turbine_medium",
    copy_from = "gas_turbine_engine",
    item = "medium_turbine_engine",
    description = ccb.content.text("A large gas turbine engine, usually used for military helicopters.  Known for its high rate of fuel consumption."),
    durability = 400,
    epower = "-10 W",
    power = "1416830 W",
    energy_consumption = "5667320 W",
    breaks_into = {
        { item = "alloy_plate", count = { 2, 4 } },
        { item = "ch_steel_lump", count = { 50, 65 } },
        { item = "ch_steel_chunk", count = { 50, 65 } },
        { item = "scrap", count = { 50, 65 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 8 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 6 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 9 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 5 },
                { "repair_welding_alloys", 3 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 65 },
}

ccb.content.define_vehicle_part {
    id = "engine_turbine_large",
    copy_from = "gas_turbine_engine",
    item = "large_turbine_engine",
    description = ccb.content.text("A massive gas turbine engine, used to power the V-22 Osprey.  Known for its high rate of fuel consumption."),
    durability = 400,
    epower = "-10 W",
    power = "4474199 W",
    energy_consumption = "17896796 W",
    breaks_into = {
        { item = "alloy_plate", count = { 4, 6 } },
        { item = "ch_steel_lump", count = { 100, 120 } },
        { item = "ch_steel_chunk", count = { 100, 120 } },
        { item = "scrap", count = { 100, 120 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 9 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 7 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 10 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 7 },
                { "repair_welding_alloys", 5 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 70 },
}

ccb.content.define_vehicle_part {
    id = "xedra_genset",
    copy_from = "engine_1cyl_large",
    item = "xedra_genset",
    fuel_options = { "gasoline", "diesel", "lamp_oil", "jp8", "motor_oil", "avgas", "biodiesel" },
    m2c = 25,
    energy_consumption = "100000 W",
    description = ccb.content.text("A spartan, prototype engine-generator made to burn all fuels."),
    noise_factor = 1,
}
