local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "metal_propeller_item",
        category = "veh_parts",
        name = ccb.content.plural_text("aircraft propeller", "aircraft propellers"),
        description = ccb.content.text("A steel propeller and spinner from an airplane.  When attached to a vehicle, engine power will provide lift to any installed wings, allowing it to take off."),
        price_cents = 1200,
        price_postapoc_cents = 250,
        mass_milligrams = 24000000,
        volume_ml = 20000,
        looks_like = "small_helicopter_rotor",
        symbol = "X",
        color = "light_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wood_propeller_item",
        category = "veh_parts",
        name = ccb.content.plural_text("wooden aircraft propeller", "wooden aircraft propellers"),
        description = ccb.content.text("A wooden propeller and spinner from an airplane.  When attached to a vehicle, engine power will provide lift to any installed wings, allowing it to take off."),
        price_cents = 1200,
        price_postapoc_cents = 250,
        mass_milligrams = 17000000,
        volume_ml = 20000,
        looks_like = "small_helicopter_rotor",
        symbol = "X",
        color = "brown",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    -- About half the weight and volume of the wooden beam, assumes a good amount is lost in the recipe
    local item = content.Item {
        id = "sail_large_item",
        copy_from = "sail",
        looks_like = "sail",
        name = ccb.content.plural_text("large sail", "large sails"),
        description = ccb.content.text("A wooden mast with sails fit for a yacht or sloop, and about as much rigging as a single sailor can handle."),
        mass_milligrams = 18000000,
        volume_ml = 30000,
        price_cents = 30000,
        price_postapoc_cents = 2000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end
