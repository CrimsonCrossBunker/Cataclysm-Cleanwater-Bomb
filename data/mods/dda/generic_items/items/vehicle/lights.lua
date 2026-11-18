local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "car_headlight",
        name = ccb.content.plural_text("car headlight", "car headlights"),
        description = ccb.content.text("A vehicle headlight to light up the way."),
        symbol = ";",
        color = "white",
        category = "veh_parts",
        mass_milligrams = 1000000,
        volume_ml = 1000,
        price_cents = 3000,
        price_postapoc_cents = 100,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "motorcycle_headlight",
        name = ccb.content.plural_text("motorcycle headlight", "motorcycle headlights"),
        description = ccb.content.text("A motorcycle headlight to light up the way."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 5000,
        price_postapoc_cents = 100,
        copy_from = "car_headlight",
        looks_like = "car_headlight",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "car_wide_headlight",
        name = ccb.content.plural_text("wide-angle car headlight", "wide-angle car headlights"),
        description = ccb.content.text("A wide-angle vehicle headlight to light up the way."),
        looks_like = "car_headlight",
        mass_milligrams = 2000000,
        volume_ml = 1250,
        price_cents = 4000,
        price_postapoc_cents = 150,
        copy_from = "car_headlight",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "headlight_reinforced",
        name = ccb.content.plural_text("reinforced headlight", "reinforced headlights"),
        description = ccb.content.text("A vehicle headlight with a cage built around it to protect it from damage without reducing its effectiveness."),
        mass_milligrams = 1200000,
        color = "light_cyan",
        symbol = ",",
        price_cents = 40000,
        price_postapoc_cents = 250,
        copy_from = "car_headlight",
        looks_like = "car_headlight",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "wide_headlight_reinforced",
        name = ccb.content.plural_text("reinforced wide-angle headlight", "reinforced wide-angle headlights"),
        description = ccb.content.text("A wide-angle vehicle headlight with a cage built around it to protect it from damage without reducing its effectiveness."),
        mass_milligrams = 4800000,
        volume_ml = 1250,
        copy_from = "headlight_reinforced",
        looks_like = "headlight_reinforced",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "light_emergency_red",
        name = ccb.content.plural_text("emergency vehicle light (red)", "emergency vehicle lights (red)"),
        description = ccb.content.text("A red light from the top of an emergency services vehicle."),
        mass_milligrams = 500000,
        melee_to_hit = -2,
        color = "red",
        price_cents = 40000,
        price_postapoc_cents = 100,
        copy_from = "car_headlight",
        looks_like = "car_headlight",
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "light_emergency_blue",
        name = ccb.content.plural_text("emergency vehicle light (blue)", "emergency vehicle lights (blue)"),
        description = ccb.content.text("A blue light from the top of an emergency services vehicle."),
        color = "blue",
        copy_from = "light_emergency_red",
        looks_like = "light_emergency_red",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "floodlight",
        name = ccb.content.plural_text("floodlight", "floodlights"),
        description = ccb.content.text("A large, heavy light designed to illuminate wide areas."),
        mass_milligrams = 2500000,
        melee_to_hit = -2,
        volume_ml = 2000,
        price_cents = 90000,
        price_postapoc_cents = 1500,
        copy_from = "car_headlight",
        looks_like = "car_headlight",
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "directed_floodlight",
        name = ccb.content.plural_text("directed floodlight", "directed floodlights"),
        description = ccb.content.text("A large, heavy light designed to illuminate a wide area in a half-circular cone."),
        copy_from = "floodlight",
        looks_like = "floodlight",
    }
    content.add(item)
end
