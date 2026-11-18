local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "beeper",
        name = ccb.content.plural_text("back-up beeper", "back-up beepers"),
        description = ccb.content.text("A safety device intended to warn passersby of a vehicle moving in reverse.  Usage of it now seems terribly unwise."),
        mass_milligrams = 360000,
        symbol = ";",
        color = "light_gray",
        volume_ml = 250,
        melee_to_hit = -2,
        category = "veh_parts",
        price_cents = 6000,
        price_postapoc_cents = 100,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "stereo",
        name = ccb.content.plural_text("stereo system", "stereo systems"),
        description = ccb.content.text("A stereo system with speakers.  It is capable of being hooked up to a vehicle."),
        mass_milligrams = 800000,
        color = "red",
        symbol = "&",
        volume_ml = 3500,
        category = "veh_parts",
        price_cents = 800,
        price_postapoc_cents = 100,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "chimes",
        name = ccb.content.plural_text("chime loudspeakers", "chime loudspeakers"),
        description = ccb.content.text("A stereo system with loudspeakers and a built-in set of simple melodies that it will play.  Commonly used by ice cream trucks to draw the attention of children in the days when children wanted ice cream more than brains."),
        mass_milligrams = 2600000,
        color = "blue",
        symbol = "&",
        volume_ml = 4000,
        category = "veh_parts",
        price_cents = 5000,
        price_postapoc_cents = 250,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    content.add(item)
end
