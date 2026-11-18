local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "motor_enhanced",
        name = ccb.content.plural_text("enhanced electric motor", "enhanced electric motors"),
        description = ccb.content.text("A powerful high-performance electric motor, as found in those consumer electric sports cars with ridiculous, ludicrous, or similarly hyperbolic acceleration options.  It needs a lot of battery power."),
        mass_milligrams = 120000000,
        volume_ml = 140000,
        price_cents = 68000,
        price_postapoc_cents = 2500,
        copy_from = "motor",
        looks_like = "motor",
    }
    item:material("lc_steel", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_super",
        name = ccb.content.plural_text("super electric motor", "super electric motors"),
        description = ccb.content.text("A massive and extremely powerful electric motor, delivering high torque at the cost of significant power drain, this would be well suited to an electric racing car."),
        mass_milligrams = 140000000,
        volume_ml = 200000,
        price_cents = 80000,
        price_postapoc_cents = 3500,
        copy_from = "motor",
        looks_like = "motor",
    }
    item:material("lc_steel", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_large",
        name = ccb.content.plural_text("large electric motor", "large electric motors"),
        description = ccb.content.text("A heavy-duty electrical motor, capable of propelling a full-size car or SUV through electric power alone, provided you have the battery capacity."),
        mass_milligrams = 90000000,
        melee_to_hit = -3,
        symbol = ":",
        volume_ml = 75000,
        price_cents = 22000,
        price_postapoc_cents = 1500,
        copy_from = "motor",
        looks_like = "motor",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_small",
        name = ccb.content.plural_text("small electric motor", "small electric motors"),
        description = ccb.content.text("A light-duty electrical motor, strong enough for an electric mopeds, golf carts, and even hybrid mopeds."),
        mass_milligrams = 4000000,
        volume_ml = 6000,
        price_cents = 2000,
        price_postapoc_cents = 500,
        copy_from = "motor",
        looks_like = "motor",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_tiny",
        name = ccb.content.plural_text("tiny electric motor", "tiny electric motors"),
        description = ccb.content.text("A tiny electric motor just the right size for providing a gentle boost for a bicycle, or similarly light vehicles."),
        mass_milligrams = 2500000,
        color = "light_cyan",
        symbol = ",",
        volume_ml = 750,
        category = "veh_parts",
        price_cents = 2000,
        price_postapoc_cents = 100,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "motor_train1300",
        name = ccb.content.plural_text("1,300 HP electric train engine", "1,300 HP electric train engines"),
        description = ccb.content.text("A 1,300 horsepower 3-phase 60 Hz electric engine.  Normally used in trains."),
        mass_milligrams = 2000000000,
        volume_ml = 250000,
        price_cents = 120000,
        price_postapoc_cents = 8000,
        copy_from = "motor",
        looks_like = "motor",
    }
    content.add(item)
end
