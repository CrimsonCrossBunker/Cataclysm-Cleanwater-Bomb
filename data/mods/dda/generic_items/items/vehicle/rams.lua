local ccb = require("ccb")
local content = ccb.content

do
    -- Recycling shredders (which I imagined this thing to be like) use tool steels or carbide blades (https://maxtormetal.com/shredder-blades-material-life/), but that seemed too hard to get, so I substituted a medium steel, as it cans still be found in larger quantities (in vehicle axles etc.)
    local item = content.Item {
        id = "tearer",
        category = "veh_parts",
        name = ccb.content.plural_text("shredder", "shredders"),
        description = ccb.content.text("This menacing-looking attachment is meant to be powered by a vehicle's engine.  Upon doing so, the circular blades of this device will rotate rapidly; anything in front of it is likely to be ripped to shreds.  It is sturdy enough to withstand multiple impacts, and is designed to detach if it would take a hit that would break it."),
        mass_milligrams = 29955000,
        volume_ml = 7500,
        price_cents = 10500,
        price_postapoc_cents = 2500,
        melee_to_hit = -3,
        symbol = "]",
        color = "light_cyan",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end
