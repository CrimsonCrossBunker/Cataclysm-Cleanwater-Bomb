local ccb = require("ccb")
local content = ccb.content

do
    -- Roughly in the 70 cm × 70 cm × 1.5 mm to 1 m × 1 m × 0.75 mm range. Has to be folded / rolled up when in inventory, so 75% density compared to solid block.
    local item = content.Item {
        id = "sheet_metal",
        name = ccb.content.plural_text("sheet metal", "sheet metal"),
        description = ccb.content.text("A thin sheet of metal."),
        mass_milligrams = 6000000,
        longest_side_mm = 1000,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 1000,
        category = "spare_parts",
        price_cents = 6000,
        price_postapoc_cents = 100,
        replace_qualities = true,
        stackable = true,
    }
    item:material("lc_steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "wood_plate",
        name = ccb.content.plural_text("wooden armor kit", "wooden armor kits"),
        description = ccb.content.text("A bundle of planks prepared to be used as vehicle armor."),
        mass_milligrams = 5600000,
        melee_to_hit = -2,
        color = "brown",
        symbol = "]",
        volume_ml = 3000,
        category = "veh_parts",
        price_cents = 12000,
        price_postapoc_cents = 100,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "steel_plate",
        name = ccb.content.plural_text("steel plating", "steel plating"),
        description = ccb.content.text("A piece of vehicle armor plating made of steel."),
        mass_milligrams = 12880000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 3000,
        category = "veh_parts",
        price_cents = 12000,
        price_postapoc_cents = 250,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "alloy_plate",
        name = ccb.content.plural_text("superalloy plating", "superalloy plating"),
        description = ccb.content.text("A piece of vehicle armor plating made of sturdy superalloy."),
        mass_milligrams = 10800000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 6000,
        category = "veh_parts",
        price_cents = 500000,
        price_postapoc_cents = 7500,
        replace_qualities = true,
    }
    item:material("superalloy", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "alloy_sheet",
        name = ccb.content.plural_text("superalloy sheet", "superalloy sheets"),
        description = ccb.content.text("A sheet of sturdy superalloy; incredibly hard, yet incredibly malleable."),
        mass_milligrams = 900000,
        color = "light_cyan",
        symbol = ",",
        volume_ml = 500,
        category = "veh_parts",
        price_cents = 35000,
        price_postapoc_cents = 500,
        replace_qualities = true,
    }
    item:material("superalloy", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    content.add(item)
end

do
    local item = content.Item {
        id = "spiked_plate",
        name = ccb.content.plural_text("spiked plating", "spiked plating"),
        description = ccb.content.text("A piece of vehicle armor plating made of steel.  It is covered with menacing spikes."),
        mass_milligrams = 12240000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 3500,
        category = "veh_parts",
        price_cents = 18500,
        price_postapoc_cents = 250,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "hard_plate",
        name = ccb.content.plural_text("hard plating", "hard platings"),
        description = ccb.content.text("A piece of very thick vehicle armor plating made of tempered steel.  Can be used as a makeshift anvil."),
        mass_milligrams = 32640000,
        melee_to_hit = -3,
        color = "light_cyan",
        symbol = "]",
        volume_ml = 3000,
        category = "veh_parts",
        price_cents = 16000,
        price_postapoc_cents = 500,
        replace_qualities = true,
    }
    item:material("qt_steel", 1)
    item:quality("COOK", 1)
    item:quality("ANVIL", 2)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "mil_plate",
        name = ccb.content.plural_text("military composite plating", "military composite platings"),
        description = ccb.content.text("A thick sheet of military-grade armor; the best bullet-stopper you can stick on a vehicle."),
        mass_milligrams = 16500000,
        melee_to_hit = -3,
        color = "green",
        symbol = "]",
        volume_ml = 3000,
        category = "veh_parts",
        price_cents = 16000,
        price_postapoc_cents = 750,
        replace_qualities = true,
    }
    item:material("qt_steel", 1)
    item:material("ceramic", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "chitin_plate",
        symbol = "]",
        color = "yellow",
        name = ccb.content.plural_text("chitin armor kit", "chitin armor kits"),
        description = ccb.content.text("A piece of light chitin plating made for a vehicle."),
        price_cents = 1200,
        price_postapoc_cents = 250,
        mass_milligrams = 2000000,
        volume_ml = 5500,
        melee_to_hit = -3,
        category = "veh_parts",
    }
    item:material("chitin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "acidchitin_plate",
        copy_from = "chitin_plate",
        looks_like = "chitin_plate",
        name = ccb.content.plural_text("biosilicified chitin armor kit", "biosilicified chitin armor kits"),
        description = ccb.content.text("A piece of durable silica-coated chitin plating made for a vehicle."),
    }
    item:material("acidchitin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "counterweight",
        name = ccb.content.plural_text("counterweight", "counterweights"),
        description = ccb.content.text("A heavy block of steel used for balancing other heavy things.  Can be used as a makeshift anvil."),
        mass_milligrams = 750000000,
        color = "dark_gray",
        symbol = "]",
        volume_ml = 330000,
        longest_side_mm = 1100,
        price_cents = 12000,
        price_postapoc_cents = 250,
        category = "veh_parts",
        replace_qualities = true,
    }
    item:material("iron", 1)
    item:quality("ANVIL", 2)
    content.add(item)
end
