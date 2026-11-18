local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_oxygen_candle",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("oxygen candle", "oxygen candles"),
        description = ccb.content.text("An ignitable device that produces oxygen through an exothermic chemical reaction.  Often stocked as the last backup in case of total life support failure.  You could activate it, but that would just waste it."),
        mass_milligrams = 840000,
        volume_ml = 500,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "diamond_press",
        category = "tools",
        name = ccb.content.plural_text("folded diamond press", "folded diamond presses"),
        description = ccb.content.text("Matrioshka Fabritechnics this device that can create pressures beyond those that create diamonds.  Once deployed it can be used to craft ultratech marvels that require substances of singular qualities."),
        mass_milligrams = 8464000,
        volume_ml = 11356,
        price_cents = 5000,
        price_postapoc_cents = 45000,
        looks_like = "kiln",
        symbol = "u",
        color = "light_green",
    }
    item:clear_use_actions()
    item:deploy_furniture("f_diamond_press")
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_survival_heater",
        name = ccb.content.plural_text("portable survival heater", "portable survival heaters"),
        description = ccb.content.text("When deployed and powered this device can warm a small room enough to doff your EVA gear."),
        looks_like = "large_space_heater",
        mass_milligrams = 1224000,
        melee_to_hit = -3,
        color = "red",
        symbol = ";",
        volume_ml = 9464,
        category = "veh_parts",
        price_cents = 100000,
        price_postapoc_cents = 100000,
    }
    item:clear_use_actions()
    item:deploy_appliance("afs_survival_heater")
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_tripod_light",
        name = ccb.content.plural_text("portable survival lamp", "portable survival lamps"),
        description = ccb.content.text("A small folded metal tripod that can be deployed to illuminate an area around itself."),
        looks_like = "f_floor_lamp",
        mass_milligrams = 825000,
        melee_to_hit = 0,
        volume_ml = 871,
        longest_side_mm = 430,
        symbol = "L",
        color = "white",
        category = "veh_parts",
        price_cents = 2000,
        price_postapoc_cents = 2000,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_appliance("afs_tripod_light")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end
