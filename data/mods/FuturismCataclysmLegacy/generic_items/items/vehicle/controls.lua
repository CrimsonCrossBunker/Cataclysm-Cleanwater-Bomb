local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fcl_control_station",
        name = ccb.content.plural_text("control station", "control stations"),
        looks_like = "vehicle_dashboard",
        description = ccb.content.text("A large and complex piloting station from a military vehicle, including a camera station, steering tools, and electronics controls."),
        mass_milligrams = 9000000,
        melee_to_hit = -4,
        color = "red",
        symbol = "$",
        volume_ml = 6000,
        category = "veh_parts",
        price_cents = 60000,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "fcl_smart_omnicamera",
        name = ccb.content.plural_text("smart security camera", "smart security cameras"),
        copy_from = "omnicamera",
        looks_like = "omnicamera",
        description = ccb.content.text("A smart security camera you could connect to a display.  Not only is the field of vision great, but AI technology is also used for image prediction, which greatly improves the clarity of the image.  But its power consumption has also doubled."),
        mass_milligrams = 1500000,
        melee_to_hit = -4,
        price_cents = 25000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fcl_smart_omnicamera_reinforced",
        copy_from = "omnicamera",
        looks_like = "omnicamera",
        name = ccb.content.plural_text("reinforced smart security camera", "reinforced smart security cameras"),
        description = ccb.content.text("A smart security camera with a cage built around it to protect it from damage without reducing its effectiveness."),
        mass_milligrams = 1900000,
        melee_to_hit = -4,
        price_cents = 35000,
        price_postapoc_cents = 2500,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end
