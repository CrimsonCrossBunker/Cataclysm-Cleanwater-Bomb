local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "door_lock",
        name = ccb.content.plural_text("door lock set", "door lock sets"),
        description = ccb.content.text("Some wires and gears for connecting door handles and an unlocking knob to a latching mechanism, and a sturdy lock to go on the outer surface.  If installed on a door or a hatch, this can be used to lock it."),
        symbol = "+",
        color = "dark_gray",
        category = "veh_parts",
        mass_milligrams = 500000,
        volume_ml = 300,
        price_cents = 3000,
        price_postapoc_cents = 72,
    }
    item:material("steel", 1)
    content.add(item)
end
