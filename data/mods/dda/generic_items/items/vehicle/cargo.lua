local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "basket",
        name = ccb.content.plural_text("wire basket", "wire baskets"),
        description = ccb.content.text("A large wire basket from a shopping cart."),
        mass_milligrams = 6000000,
        melee_to_hit = -2,
        color = "cyan",
        symbol = "]",
        techniques = { "DEF_DISARM" },
        volume_ml = 22500,
        category = "veh_parts",
        price_cents = 10000,
        price_postapoc_cents = 50,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("COOK", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end

do
    local item = content.Item {
        id = "bike_rack",
        name = ccb.content.plural_text("bike rack", "bike racks"),
        description = ccb.content.text("A collection of pipes, cams, and straps, mounted on the edge of a vehicle and used to support another vehicle for transport.  It must be mounted on a vehicle to be used."),
        mass_milligrams = 4000000,
        volume_ml = 6250,
        price_cents = 16000,
        price_postapoc_cents = 50,
        category = "veh_parts",
        symbol = "]",
        color = "light_gray",
        looks_like = "foldframe",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "cargo_lock",
        name = ccb.content.plural_text("cargo lock set", "cargo lock sets"),
        description = ccb.content.text("A set of locks designed to be installed on a vehicle.  Attached to a suitable cargo space, it will prevent other people from accessing the cargo and taking your stuff."),
        symbol = "+",
        color = "dark_gray",
        category = "veh_parts",
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 800,
        price_postapoc_cents = 50,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "folding_basket",
        name = ccb.content.plural_text("foldable wire basket", "foldable wire baskets"),
        description = ccb.content.text("A large wire basket from a shopping cart, modified to be foldable."),
        mass_milligrams = 7000000,
        copy_from = "basket",
        looks_like = "basket",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bike_basket",
        name = ccb.content.plural_text("bike basket", "bike baskets"),
        description = ccb.content.text("A simple bike basket.  It is small and foldable."),
        mass_milligrams = 1200000,
        volume_ml = 5000,
        price_cents = 3500,
        price_postapoc_cents = 50,
        copy_from = "basket",
        looks_like = "basket",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "cargo_rack",
        name = ccb.content.plural_text("cargo carrier", "cargo carriers"),
        description = ccb.content.text("A heavy frame outfitted with tie-downs and attachment points for carrying cargo."),
        mass_milligrams = 85330000,
        melee_to_hit = -2,
        color = "cyan",
        symbol = "]",
        volume_ml = 50000,
        category = "veh_parts",
        price_cents = 40000,
        price_postapoc_cents = 500,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "cargo_aisle",
        name = ccb.content.plural_text("floor trunk", "floor trunks"),
        description = ccb.content.text("A section of flooring with a cargo space beneath and a hinged door for access."),
        mass_milligrams = 19200000,
        color = "cyan",
        symbol = "]",
        volume_ml = 50000,
        category = "veh_parts",
        price_cents = 20000,
        price_postapoc_cents = 500,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "mounted_spare_tire",
        name = ccb.content.plural_text("mounted spare tire", "mounted spare tires"),
        description = ccb.content.text("A spare tire mounted on a carrier rig, ready to be attached to the rear bumper of a vehicle."),
        symbol = "o",
        color = "dark_gray",
        category = "veh_parts",
        mass_milligrams = 27600000,
        volume_ml = 18750,
        price_cents = 37500,
        price_postapoc_cents = 750,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- https://www.magliner.com/extruded-aluminum-nose-flush-mount-300248
    -- The linked item weighs about 4kg, added another 2kg for skid runners.
    local item = content.Item {
        id = "nose_plate",
        name = ccb.content.plural_text("nose plate", "nose plates"),
        description = ccb.content.text("An L-shaped aluminum plate with straps and skid runners for a hand truck.  If attached to a sturdy frame, you could use these to move furniture."),
        color = "light_gray",
        symbol = "]",
        mass_milligrams = 6000000,
        volume_ml = 7000,
        longest_side_mm = 500,
        category = "veh_parts",
        price_cents = 2000,
        price_postapoc_cents = 100,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
