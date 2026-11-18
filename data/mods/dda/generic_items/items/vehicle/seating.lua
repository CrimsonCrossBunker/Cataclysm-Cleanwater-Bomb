local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "seat",
        name = ccb.content.plural_text("bucket seat", "bucket seats"),
        description = ccb.content.text("A soft car seat made from synthetic fabric."),
        mass_milligrams = 9071000,
        melee_to_hit = -2,
        color = "red",
        symbol = "0",
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 35000,
        price_postapoc_cents = 100,
    }
    item:material("nylon", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "seat_leather",
        copy_from = "seat",
        looks_like = "seat",
        name = ccb.content.plural_text("leather bucket seat", "leather bucket seats"),
        description = ccb.content.text("A soft car seat covered with leather."),
        price_cents = 60000,
        price_postapoc_cents = 250,
    }
    item:material("leather", 1)
    item:material("nylon", 1)
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "seat_bench",
        name = ccb.content.plural_text("bench seat", "bench seats"),
        description = ccb.content.text("A wide, flat seat like you'd find in the back of a sedan, upholstered with soft nylon."),
        mass_milligrams = 9071000,
        melee_to_hit = -2,
        color = "red",
        symbol = "0",
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 35000,
        price_postapoc_cents = 100,
    }
    item:material("nylon", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "seat_bench_leather",
        copy_from = "seat",
        looks_like = "seat",
        name = ccb.content.plural_text("leather bench seat", "leather bench seats"),
        description = ccb.content.text("A wide, flat seat like you'd find in the back of a sedan, upholstered with leather."),
        price_cents = 60000,
        price_postapoc_cents = 250,
    }
    item:material("leather", 1)
    item:material("nylon", 1)
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "saddle",
        name = ccb.content.plural_text("saddle", "saddles"),
        description = ccb.content.text("A padded wedge that you straddle, like a bicycle or motorcycle."),
        mass_milligrams = 300000,
        volume_ml = 1250,
        price_cents = 2500,
        price_postapoc_cents = 250,
        copy_from = "seat",
        looks_like = "seat",
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end
