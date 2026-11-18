local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "vehicle_alternator",
        abstract = true,
        name = content.plural_text("vehicle alternator", "vehicle alternators"),
        category = "veh_parts",
        symbol = ",",
        color = "light_cyan",
    }
    item:material("lc_steel", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "alternator_car",
        copy_from = "vehicle_alternator",
        name = ccb.content.plural_text("car alternator", "car alternators"),
        description = ccb.content.text("A standard alternator used to power vehicle electrical systems."),
        mass_milligrams = 4000000,
        volume_ml = 2500,
        price_cents = 9000,
        price_postapoc_cents = 500,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "alternator_motorbike",
        copy_from = "vehicle_alternator",
        name = ccb.content.plural_text("motorbike alternator", "motorbike alternators"),
        description = ccb.content.text("A compact, lightweight alternator used to power small vehicle electrical systems."),
        mass_milligrams = 1100000,
        volume_ml = 1000,
        price_cents = 8000,
        price_postapoc_cents = 300,
    }
    content.add(item)
end

do
    -- based on: https://www.amazon.com/Wai-Danie-Generator-Waterproof-Alternating/dp/B07X2B1DVG
    local item = content.Item {
        id = "alternator_bicycle",
        copy_from = "vehicle_alternator",
        name = ccb.content.plural_text("bicycle alternator", "bicycle alternators"),
        description = ccb.content.text("A very lightweight alternator used to power a bicycle's headlights."),
        mass_milligrams = 420000,
        volume_ml = 133,
        price_cents = 8000,
        price_postapoc_cents = 250,
    }
    item:material("aluminum", 80)
    item:material("copper", 20)
    content.add(item)
end

do
    local item = content.Item {
        id = "alternator_truck",
        copy_from = "vehicle_alternator",
        name = ccb.content.plural_text("truck alternator", "truck alternators"),
        description = ccb.content.text("A larger and more powerful alternator used to power vehicle electrical systems."),
        mass_milligrams = 5800000,
        volume_ml = 3000,
        price_cents = 12000,
        price_postapoc_cents = 1000,
    }
    content.add(item)
end
