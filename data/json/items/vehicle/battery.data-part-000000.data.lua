local ccb = require("ccb")

-- 58Ah @ 12VDC. Could supply ~833 watts for an hour
-- Approximate energy density 0.3 MJ/L / 0.14 MJ/Kg for lead-acid batteries
ccb.content.define_item {
    id = "battery_car",
    category = "veh_parts",
    name = ccb.content.plural_text("car battery", "car batteries"),
    description = ccb.content.text("A 12 V lead-acid battery used to power car electrical systems.  Can also be plugged into a static power grid."),
    ascii_picture = "battery_car",
    mass = "20 kg",
    volume = "10 L",
    price = "40 USD",
    survival_price = "5 USD",
    materials = { "plastic", "lead" },
    symbol = ":",
    color = "light_cyan",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 3000 } } },
    magazine = { ammunition = { "battery" }, capacity = 3000 },
}

-- 12Ah @ 12VDC. Could supply ~125 watts for an hour
ccb.content.define_item {
    id = "battery_motorbike",
    copy_from = "battery_car",
    name = ccb.content.plural_text("motorbike battery", "motorbike batteries"),
    description = ccb.content.text("A 12 V lead-acid battery used to power smaller vehicles' electrical systems."),
    ascii_picture = "battery_motorbike",
    looks_like = "battery_car",
    mass = "3000 g",
    volume = "1500 ml",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 450 } } },
    magazine = { capacity = 450 },
}

-- ~2.4Ah @ 12VDC. Could supply ~125 watts 30 minutes or so
ccb.content.define_item {
    id = "battery_motorbike_small",
    copy_from = "battery_car",
    name = ccb.content.plural_text("small motorbike battery", "small motorbike batteries"),
    description = ccb.content.text("A miniature 12 V lead-acid battery used to power smaller vehicles' electrical systems."),
    ascii_picture = "battery_motorbike_small",
    looks_like = "battery_motorbike",
    mass = "1500 g",
    volume = "750 ml",
    price = "15 USD",
    survival_price = "1 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 225 } } },
    magazine = { capacity = 225 },
}

-- Approximate energy density 2.1 MJ/L / 0.73 MJ/Kg for lithium nickel manganese cobalt oxide (NMC) batteries
ccb.content.define_item {
    id = "storage_battery",
    category = "veh_parts",
    name = ccb.content.plural_text("large storage battery", "large storage batteries"),
    description = ccb.content.text("A large storage battery containing many lithium-ion cells.  Could be installed into a storage battery case for easy removal from a vehicle, or just welded straight in."),
    ascii_picture = "storage_battery",
    mass = "75 kg",
    volume = "25 L",
    price = "2 kUSD",
    survival_price = "120 USD",
    materials = { "plastic", "lc_steel" },
    symbol = ":",
    color = "light_cyan",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "NO_REPAIR" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 50000 } } },
    melee_damage = { bash = 20 },
    magazine = { ammunition = { "battery" }, capacity = 50000 },
}

ccb.content.define_item {
    id = "large_storage_battery",
    copy_from = "storage_battery",
    name = ccb.content.plural_text("very large storage battery", "very large storage batteries"),
    description = ccb.content.text("A huge storage battery containing many lithium-ion cells.  Holds a tremendous amount of energy.  Could be installed into a storage battery case for easy removal from a vehicle, or just welded straight in.  Can also be plugged into a static power grid."),
    ascii_picture = "large_storage_battery",
    mass = "150 kg",
    volume = "50 L",
    price = "4 kUSD",
    survival_price = "250 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 100000 } } },
    melee_damage = { bash = 40 },
    magazine = { capacity = 100000 },
}

ccb.content.define_item {
    id = "medium_storage_battery",
    copy_from = "storage_battery",
    name = ccb.content.plural_text("medium storage battery", "medium storage batteries"),
    description = ccb.content.text("A medium storage battery containing multiple lithium-ion cells.  Can be plugged into a static power grid."),
    ascii_picture = "medium_storage_battery",
    mass = "15 kg",
    volume = "5 L",
    price = "500 USD",
    survival_price = "22 USD 50 cent",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 10000 } } },
    melee_damage = { bash = 14 },
    magazine = { capacity = 10000 },
}

ccb.content.define_item {
    id = "small_storage_battery",
    copy_from = "storage_battery",
    name = ccb.content.plural_text("small storage battery", "small storage batteries"),
    description = ccb.content.text("A small storage battery created with pre-Cataclysm lithium-ion technology.  Useful for crafting.  Can be plugged into a static power grid."),
    ascii_picture = "small_storage_battery",
    mass = "1500 g",
    volume = "500 ml",
    price = "50 USD",
    survival_price = "2 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1000 } } },
    melee_damage = { bash = 7 },
    magazine = { capacity = 1000 },
}
