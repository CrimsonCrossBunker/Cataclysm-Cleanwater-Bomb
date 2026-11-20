local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "engine_combustion",
    abstract = true,
    category = "veh_parts",
    name = ccb.content.text_without_extraction("internal combustion engine"),
    materials = { "iron" },
    symbol = ":",
    color = "light_cyan",
    engine = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "engine_diesel",
    abstract = true,
    copy_from = "engine_combustion",
    name = ccb.content.text_without_extraction("base diesel engine"),
    faults = {
        { group = "any_ICE_engine_maintenance" },
        { group = "diesel_engine_maintenance" },
        { group = "any_ICE_defect" },
    },
    engine = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "engine_gasoline",
    abstract = true,
    copy_from = "engine_combustion",
    name = ccb.content.text_without_extraction("base gasoline engine"),
    faults = {
        { group = "any_ICE_engine_maintenance" },
        { group = "gasoline_engine_maintenance" },
        { group = "any_ICE_defect" },
    },
    engine = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "engine_steam",
    abstract = true,
    copy_from = "engine_combustion",
    name = ccb.content.text_without_extraction("base steam engine"),
    looks_like = "v12_diesel",
    faults = { { group = "steam_engine_maintenance" } },
    engine = {},
}

-- 50 cc moped engine, lawnmower engine, golf cart engine
ccb.content.define_item {
    id = "1cyl_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("0.05 L 1-cylinder engine", "0.05 L 1-cylinder engines"),
    description = ccb.content.text("A 50 cc gasoline engine, suitable for a lawnmower, golf cart or moped."),
    mass = "3750 g",
    volume = "12 L",
    price = "100 USD",
    survival_price = "10 USD",
    faults = { { fault = "fault_engine_starter" } },
    engine = {},
}

-- 200 cc scooter, dirt bike engine
ccb.content.define_item {
    id = "1cyl_combustion_large",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("0.2 L large 1-cylinder engine", "0.2 L large 1-cylinder engines"),
    description = ccb.content.text("A high-compression, 200 cc single-cylinder 4-stroke combustion engine, suitable for a dirt bike or scooter."),
    mass = "28 kg",
    volume = "42 L",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    faults = { { fault = "fault_engine_starter" } },
    engine = {},
}

-- 150 cc generator engine
ccb.content.define_item {
    id = "1cyl_combustion_med",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("0.2 L medium 1-cylinder engine", "0.2 L medium 1-cylinder engines"),
    description = ccb.content.text("A high-compression, 150 cc single-cylinder 4-stroke combustion engine, suitable for a dirt bike, scooter or generator."),
    mass = "15 kg",
    volume = "43793 ml",
    price = "130 USD",
    survival_price = "12 USD 50 cent",
    engine = {},
}

-- 200 cc scooter, dirtbike, or diesel generator
ccb.content.define_item {
    id = "engine_1cyl_diesel_large",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("0.2 L large 1-cylinder diesel engine", "0.2 L large 1-cylinder diesel engines"),
    description = ccb.content.text("A high-compression, 200 cc single-cylinder 4-stroke diesel combustion engine, suitable for a dirt bike, scooter, or generator."),
    mass = "28 kg",
    volume = "42 L",
    price = "100 USD",
    survival_price = "12 USD 50 cent",
    faults = { { fault = "fault_engine_starter" } },
    engine = {},
}

-- 25 cc hedge trimmer engine, bicycle motor
ccb.content.define_item {
    id = "1cyl_combustion_small",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("0.02 L small 1-cylinder engine", "0.02 L small 1-cylinder engines"),
    description = ccb.content.text("A small 25 cc gasoline engine, suitable for a hedge trimmer or installing on a bicycle."),
    mass = "2200 g",
    volume = "6 L",
    price = "60 USD",
    survival_price = "7 USD 50 cent",
    faults = {},
    engine = {},
}

ccb.content.define_item {
    id = "aero_engine_light",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("5.24 L light aero-engine", "5.24 L light aero-engines"),
    description = ccb.content.text("An air-cooled, 4-cylinder, horizontally opposed internal combustion engine, rated for 150 horsepower.  Commonly used on light aircraft."),
    mass = "126 kg",
    volume = "182 L",
    price = "800 USD",
    survival_price = "20 USD",
    engine = {},
}

-- 1600 cc normal car engine motor
ccb.content.define_item {
    id = "i4_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("1.6 L I4 engine", "1.6 L I4 engines"),
    description = ccb.content.text("A 1600 cc four-cylinder gasoline engine, commonly found in small passenger cars."),
    mass = "120 kg",
    volume = "164 L",
    price = "150 USD",
    survival_price = "12 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "i4_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("1.6 L I4 diesel engine", "1.6 L I4 diesel engines"),
    description = ccb.content.text("A four-cylinder diesel engine, commonly found in small passenger cars and light trucks."),
    mass = "120 kg",
    volume = "166 L",
    price = "160 USD",
    survival_price = "12 USD 50 cent",
    engine = {},
}

-- KS 520HD-V
ccb.content.define_item {
    id = "i1_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("0.5 L I1 diesel engine", "0.5 L I1 diesel engines"),
    description = ccb.content.text("A small, diesel powered one-cylinder, four-stroke air-cooled engine."),
    mass = "57 kg",
    volume = "66 L",
    price = "160 USD",
    survival_price = "12 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "i6_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("6 L I6 diesel engine", "6 L I6 diesel engines"),
    description = ccb.content.text("An industrial-sized 6-cylinder diesel engine, commonly called a straight-six.  About as powerful as a V6 engine but significantly larger for use in heavy equipment."),
    mass = "580 kg",
    volume = "500 L",
    price = "270 USD",
    survival_price = "15 USD",
    engine = {},
}

-- 600 cc fast motorbike or small car motor
ccb.content.define_item {
    id = "v2_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("0.6 L V2 engine", "0.6 L V2 engines"),
    description = ccb.content.text("A 600 cc, two-cylinder, gas engine for a fast motorcycle or very small car."),
    mass = "42 kg",
    volume = "70 L",
    price = "100 USD",
    survival_price = "10 USD",
    engine = {},
}

ccb.content.define_item {
    id = "v6_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("2.8 L V6 engine", "2.8 L V6 engines"),
    description = ccb.content.text("A powerful 6-cylinder gasoline engine strong enough for a pickup truck, SUV, or full-size van."),
    mass = "203 kg",
    volume = "191 L",
    price = "180 USD",
    survival_price = "15 USD",
    engine = {},
}

ccb.content.define_item {
    id = "v6_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("2.8 L V6 diesel engine", "2.8 L V6 diesel engines"),
    description = ccb.content.text("A powerful 6-cylinder diesel engine, typical of a bus, RV, large van, or armored personnel carrier."),
    mass = "207 kg",
    volume = "194 L",
    price = "200 USD",
    survival_price = "15 USD",
    engine = {},
}

ccb.content.define_item {
    id = "v8_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("4.5 L V8 engine", "4.5 L V8 engines"),
    description = ccb.content.text("A heavy-duty 8-cylinder gasoline engine, like you might find in a fire truck, ambulance, or tow truck."),
    mass = "238 kg",
    volume = "251 L",
    price = "250 USD",
    survival_price = "17 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "v8_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("4.5 L V8 diesel engine", "4.5 L V8 diesel engines"),
    description = ccb.content.text("A large 8-cylinder diesel engine, powerful enough for a semi truck, armored car, or Humvee."),
    mass = "242 kg",
    volume = "256 L",
    price = "265 USD",
    survival_price = "17 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "v12_combustion",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("7 L V12 engine", "7 L V12 engines"),
    description = ccb.content.text("A massive and extremely powerful 12-cylinder combustion engine, usually built into high-end sports cars."),
    mass = "240 kg",
    volume = "248 L",
    price = "360 USD",
    survival_price = "22 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "v12_diesel",
    copy_from = "engine_diesel",
    name = ccb.content.plural_text("7 L V12 diesel engine", "7 L V12 diesel engines"),
    description = ccb.content.text("A massive and extremely powerful 12-cylinder diesel engine, usually built into heavy trucks."),
    mass = "244 kg",
    volume = "253 L",
    price = "320 USD",
    survival_price = "22 USD 50 cent",
    engine = {},
}

ccb.content.define_item {
    id = "steam_watts_small",
    copy_from = "engine_steam",
    name = ccb.content.plural_text("makeshift steam engine", "makeshift steam engines"),
    description = ccb.content.text("A small, primitive steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    mass = "225000 g",
    volume = "62500 ml",
    price = "2 kUSD 250 USD",
    survival_price = "50 USD",
    engine = {},
}

ccb.content.define_item {
    id = "steam_triple_small",
    copy_from = "engine_steam",
    name = ccb.content.plural_text("small steam engine", "small steam engines"),
    description = ccb.content.text("A small steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    mass = "180000 g",
    volume = "37500 ml",
    price = "5 kUSD 550 USD",
    survival_price = "80 USD",
    engine = {},
}

ccb.content.define_item {
    id = "steam_triple_medium",
    copy_from = "engine_steam",
    name = ccb.content.plural_text("medium steam engine", "medium steam engines"),
    description = ccb.content.text("A medium-sized steam engine.  An integrated boiler burns coal to heat water into steam, driving a reciprocating shaft.  A condenser recaptures the water, making this a closed-cycle system."),
    mass = "280000 g",
    volume = "57500 ml",
    price = "8 kUSD 700 USD",
    survival_price = "100 USD",
    engine = {},
}

-- Based on Allison 250-C30R.  Doubled the published weight to account for a transmission.
-- The real materials used to make gas turbines are real-life superalloys and high-end stainless steels, but superalloy is reserved for sci-fi things.
-- I chose a tempered steel as it's a highest-end mundane steel in game. New material (aerospace_steel?) can be added later.
ccb.content.define_item {
    id = "small_turbine_engine",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("25 L 650 HP gas turbine engine", "25 L 650 HP gas turbine engines"),
    description = ccb.content.text("A small gas turbine engine, suitable for powering a small one or two-seat helicopter."),
    materials = { "qt_steel" },
    mass = "250 kg",
    volume = "260 L",
    price = "960 USD",
    survival_price = "25 USD",
    engine = {},
}

-- Based on T700 turboshaft engine.  Doubled the published weight to account for a transmission.
ccb.content.define_item {
    id = "medium_turbine_engine",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("38 L 1,900 HP gas turbine engine", "38 L 1,900 HP gas turbine engines"),
    description = ccb.content.text("A large gas turbine engine, usually used for military helicopters.  Known for its high rate of fuel consumption."),
    materials = { "qt_steel" },
    mass = "400 kg",
    volume = "400 L",
    price = "1 kUSD 920 USD",
    survival_price = "50 USD",
    engine = {},
}

-- Based on Rolls-Royce T406.  Doubled the published weight to account for a transmission.
ccb.content.define_item {
    id = "large_turbine_engine",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("119.5 L 6,000 HP gas turbine engine", "119.5 L 6,000 HP gas turbine engines"),
    description = ccb.content.text("A massive gas turbine engine, used to power the V-22 Osprey.  Known for its high rate of fuel consumption."),
    materials = { "qt_steel" },
    mass = "900 kg",
    volume = "900 L",
    price = "9 kUSD 600 USD",
    survival_price = "75 USD",
    engine = {},
}

-- Based on DARPA/Logos Technologies genset currently thought to be installed in the DARPA SilentHawk
ccb.content.define_item {
    id = "xedra_genset",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("prototype multifuel genset", "prototype multifuel gensets"),
    description = ccb.content.text("A spartan, prototype engine-generator made to burn many types of fuel in the field.  It has a small \"DARPA\" stamp on the casing."),
    mass = "15 kg",
    volume = "43793 ml",
    price = "20000 USD",
    survival_price = "100 USD 50 cent",
    engine = {},
}
