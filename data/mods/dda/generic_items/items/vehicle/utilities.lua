local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mountable_cooler",
        name = ccb.content.plural_text("vehicle cooler", "vehicle coolers"),
        description = ccb.content.text("A vehicle-mounted area cooler.  Install a muffler in another part of the vehicle to direct the exhaust heat to that location."),
        mass_milligrams = 12500000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "C",
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 20000,
        price_postapoc_cents = 1500,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "integrated_cooler",
        copy_from = "mountable_cooler",
        looks_like = "mountable_cooler",
        name = ccb.content.plural_text("small integrated cooler", "small integrated coolers"),
        description = ccb.content.text("A small vehicle-mounted area cooler."),
        mass_milligrams = 6000000,
        volume_ml = 3750,
        price_cents = 10000,
        price_postapoc_cents = 750,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "mountable_heater",
        name = ccb.content.plural_text("vehicle heater", "vehicle heaters"),
        description = ccb.content.text("Set of tubes, that move heat from the engine into the vehicle cabin, heating it up."),
        mass_milligrams = 12500000,
        melee_to_hit = -3,
        color = "red",
        symbol = ";",
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 20000,
        price_postapoc_cents = 1500,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "mountable_heater_small",
        copy_from = "mountable_heater",
        looks_like = "mountable_heater",
        name = ccb.content.plural_text("small vehicle heater", "small vehicle heaters"),
        mass_milligrams = 6000000,
        volume_ml = 3750,
        price_cents = 10000,
        price_postapoc_cents = 750,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "towel_hanger",
        name = ccb.content.plural_text("towel hanger", "towel hangers"),
        description = ccb.content.text("A towel hanger with towels.  You can use it to dry yourself."),
        mass_milligrams = 2000000,
        melee_to_hit = -3,
        color = "brown",
        symbol = "-",
        volume_ml = 2500,
        category = "veh_parts",
        price_cents = 3000,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "recharge_station",
        name = ccb.content.plural_text("recharging station", "recharging stations"),
        description = ccb.content.text("A universal recharging station designed to operate on vehicle power.  While on, it will steadily charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space.  The system can only be installed onto existing storage compartments, and is controlled from a dashboard or electronics control unit."),
        mass_milligrams = 10000000,
        melee_to_hit = -4,
        color = "light_blue",
        symbol = "-",
        volume_ml = 5000,
        category = "veh_parts",
        price_cents = 90000,
        price_postapoc_cents = 1000,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "battery_charger",
        name = ccb.content.plural_text("battery charger", "battery chargers"),
        description = ccb.content.text("A small device for recharging batteries, given a source of electricity.  It will slowly charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space.  It can only be installed onto existing vehicle's storage compartments, and is controlled from a dashboard or electronics control unit."),
        mass_milligrams = 100000,
        volume_ml = 250,
        price_cents = 1500,
        price_postapoc_cents = 100,
        looks_like = "cable",
        copy_from = "recharge_station",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "washing_machine",
        name = ccb.content.plural_text("vehicle washing machine", "vehicle washing machines"),
        description = ccb.content.text("A very small washing machine designed for use in vehicles."),
        mass_milligrams = 15000000,
        color = "light_blue",
        symbol = "{",
        volume_ml = 90000,
        category = "veh_parts",
        price_cents = 60000,
        price_postapoc_cents = 500,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "programmable_autopilot",
        name = ccb.content.plural_text("programmable autopilot", "programmable autopilots"),
        description = ccb.content.text("A computer system hooked up to the steering and engine of a vehicle to allow it to follow simple paths."),
        mass_milligrams = 11246000,
        color = "light_blue",
        symbol = "A",
        volume_ml = 10000,
        category = "veh_parts",
        price_cents = 90000,
        price_postapoc_cents = 2500,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "vh_autoclave",
        name = ccb.content.plural_text("vehicle autoclave", "vehicle autoclaves"),
        description = ccb.content.text("This autoclave has been rigged to run off a vehicle power grid."),
        price_cents = 162654,
        price_postapoc_cents = 1500,
        symbol = "A",
        color = "yellow",
        mass_milligrams = 34500000,
        volume_ml = 76000,
        copy_from = "washing_machine",
        looks_like = "washing_machine",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "dishwasher",
        name = ccb.content.plural_text("vehicle dishwasher", "vehicle dishwashers"),
        description = ccb.content.text("A very small dishwasher designed for use in vehicles."),
        looks_like = "washing_machine",
        copy_from = "washing_machine",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fridgetank",
        copy_from = "washing_machine",
        looks_like = "washing_machine",
        name = ccb.content.plural_text("refrigerated tank (60 L)", "refrigerated tanks (60 L)"),
        description = ccb.content.text("A 60 L refrigerated tank for keeping liquids cool.  Provides some insulation from outside weather."),
        insulation = 10,
        volume_ml = 72000,
        mass_milligrams = 48000000,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 60000, max_weight_milligrams = 400000000, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "fridgetank_large",
        copy_from = "washing_machine",
        name = ccb.content.plural_text("refrigerated tank (100 L)", "refrigerated tanks (100 L)"),
        description = ccb.content.text("A 100 L refrigerated tank for keeping liquids cool.  Provides some insulation from outside weather."),
        looks_like = "fridgetank",
        insulation = 10,
        volume_ml = 112000,
        mass_milligrams = 67000000,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 100000, max_weight_milligrams = 500000000, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "heattank",
        copy_from = "fridgetank",
        looks_like = "fridgetank",
        name = ccb.content.plural_text("heated tank", "heated tanks"),
        description = ccb.content.text("A 60 L heated tank for keeping liquids from freezing.  Provides some insulation from outside weather."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "water_faucet",
        name = ccb.content.plural_text("water faucet", "water faucets"),
        description = ccb.content.text("A metal faucet that can be attached to a water tank for easy access."),
        mass_milligrams = 900000,
        melee_to_hit = -3,
        color = "light_gray",
        symbol = ";",
        volume_ml = 750,
        category = "veh_parts",
        price_cents = 3000,
        price_postapoc_cents = 50,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end
