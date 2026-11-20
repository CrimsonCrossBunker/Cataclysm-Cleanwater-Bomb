local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_engine_belt_drive",
    name = ccb.content.text("Worn drive belt"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("Required for operation of an attached alternator."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.7,
    flags = { "NO_ALTERNATOR_CHARGE" },
}

ccb.content.define_fault {
    id = "fault_engine_glow_plug",
    name = ccb.content.text("Faulty glow plugs"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("Help when starting an engine in low ambient temperatures."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.7,
    flags = { "BAD_COLD_START" },
}

-- This INTENTIONALLY does not have a fault_type.
ccb.content.define_fault {
    id = "fault_engine_immobiliser",
    name = ccb.content.text("Active immobilizer"),
    description = ccb.content.text("An immobilizer device prevents starting of the vehicle without the appropriate key."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.25,
    flags = { "IMMOBILIZER" },
}

ccb.content.define_fault {
    id = "fault_engine_pump_diesel",
    name = ccb.content.text("Faulty diesel pump"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("Required to pump and pressurize diesel from a vehicle's tank."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.7,
    flags = { "BAD_FUEL_PUMP" },
}

ccb.content.define_fault {
    id = "fault_engine_filter_air",
    name = ccb.content.text("Expired air filter"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("An expired filter reduces fuel efficiency and increases smoke production."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.9,
    flags = { "DOUBLE_FUEL_CONSUMPTION", "EXTRA_EXHAUST" },
}

ccb.content.define_fault {
    id = "fault_engine_filter_fuel",
    name = ccb.content.text("Expired fuel filter"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("An expired filter reduces performance and increases the chance of backfires."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.7,
    flags = { "REDUCE_ENG_POWER", "ENG_BACKFIRE" },
}

ccb.content.define_fault {
    id = "fault_engine_pump_fuel",
    name = ccb.content.text("Faulty fuel pump"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("Required to pump gasoline from a vehicle's tank."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.7,
    flags = { "BAD_FUEL_PUMP" },
}

ccb.content.define_fault {
    id = "fault_engine_starter",
    name = ccb.content.text("Faulty starter motor"),
    fault_type = "engine_maintenance",
    description = ccb.content.text("Required to initially start the engine."),
    item_prefix = ccb.content.text("faulty"),
    price_modifier = 0.5,
    flags = { "BAD_STARTER" },
}

-- Reduced contact area, but not 0. Making the contact area lower actually reduces the effect of low traction and high rolling resistance.
ccb.content.define_fault {
    id = "fault_punctured_tires",
    name = ccb.content.text("Punctured tire"),
    fault_type = "mechanical_damage",
    description = ccb.content.text("Something made a hole in the tire, and it is now as flat as the ground it drives onto."),
    price_modifier = 0.0,
    contact_area_mod = 0.75,
    rolling_resistance_mod = 10.0,
    vehicle_move_penalty_mod = 2,
    item_suffix = ccb.content.text("deflating"),
    flags = { "FLAT_TIRE" },
}

-- INTENTIONALLY CANNOT BE REPAIRED. It must be replaced. You aren't fixing this!
-- Reduced contact area, but not 0. The rim is now in contact. Making the contact area lower actually reduces the effect of low traction and high rolling resistance.
-- No rubber left to be worn/punctured. This blocks those faults
ccb.content.define_fault {
    id = "fault_flat_tire_riding_on_rims",
    name = ccb.content.text("Down to rims"),
    fault_type = "mechanical_damage",
    description = ccb.content.text("This used to be an entire wheel, but now it's just rim.  Bits of shredded rubber are jutting out of the cracked rim, the result of continuing to drive with a completely flat tire.  It needs total replacement."),
    price_modifier = 0.0,
    contact_area_mod = 0.5,
    rolling_resistance_mod = 30.0,
    vehicle_move_penalty_mod = 5,
    blocks = { "fault_tire_treads", "fault_punctured_tires" },
    item_suffix = ccb.content.text("rim"),
    flags = { "FLAT_TIRE" },
}

ccb.content.define_fault {
    id = "fault_tire_treads",
    name = ccb.content.text("Worn tire treads"),
    fault_type = "mechanical_damage",
    description = ccb.content.text("The treads on this tire are worn down.  This cannot be repaired, and affects handling slightly."),
    price_modifier = 0.0,
    contact_area_mod = 0.85,
    rolling_resistance_mod = 1.05,
    item_suffix = ccb.content.text("worn"),
}

-- Hardcoded effects. Allows locked doors to be opened from the outside.
ccb.content.define_fault {
    id = "fault_broken_window",
    fault_type = "mechanical_damage",
    name = ccb.content.text("broken window"),
    description = ccb.content.text("Something broke through this door's window."),
    item_suffix = ccb.content.text("broken window"),
}

-- INTENTIONALLY CANNOT BE REPAIRED. It must be replaced. You aren't fixing this!
-- These values are meant to instantly render the vehicle part 'destroyed'.
ccb.content.define_fault {
    id = "fault_axle_broken",
    name = ccb.content.text("Broken axle"),
    description = ccb.content.text("This primitive wheel's axle has completely snapped.  The wheel will have to be replaced entirely."),
    instant_damage = 4000,
    degradation_mod = 4000,
    price_modifier = 0.0,
    item_suffix = ccb.content.text("broken axle"),
}

-- This damage causes the wheel to have worse steering until 'repaired'. The fault itself cannot be mended and will continue to impair its ability as a wheel.
ccb.content.define_fault {
    id = "fault_cracked_rim",
    name = ccb.content.text("Cracked"),
    description = ccb.content.text("This primitive wheel has been damaged by riding rough."),
    instant_damage = 1000,
    price_modifier = 0.1,
    contact_area_mod = 0.7,
    rolling_resistance_mod = 1.5,
    item_suffix = ccb.content.text("cracked"),
}
