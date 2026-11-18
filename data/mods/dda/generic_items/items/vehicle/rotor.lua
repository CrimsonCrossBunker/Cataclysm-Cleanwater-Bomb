local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "heavy_duty_military_rotor",
        category = "veh_parts",
        name = ccb.content.plural_text("heavy-duty military rotors", "sets of heavy-duty military rotors"),
        description = ccb.content.text("A set of four rotor blades from a military attack helicopter."),
        price_cents = 23400,
        price_postapoc_cents = 500,
        mass_milligrams = 452000000,
        volume_ml = 452000,
        looks_like = "xl_wind_turbine",
        symbol = "X",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_helicopter_rotor",
        category = "veh_parts",
        name = ccb.content.plural_text("small civilian helicopter rotors", "sets of small civilian helicopter rotors"),
        description = ccb.content.text("A set of four rotor blades from a civilian light helicopter."),
        price_cents = 1200,
        price_postapoc_cents = 250,
        mass_milligrams = 251000000,
        volume_ml = 251000,
        looks_like = "xl_wind_turbine",
        symbol = "X",
        color = "blue",
    }
    item:material("mc_steel", 1)
    content.add(item)
end
