local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tyrant_sample",
        symbol = "q",
        color = "light_red",
        name = ccb.content.plural_text("tyrant sample", "tyrant samples"),
        description = ccb.content.text("A sample of tissues and liquids from a living tyrannosauroid, one of many carnivorous three-toed predator dinosaurs known for being very big."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
        category = "spare_parts",
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "stego_sample",
        symbol = "q",
        color = "light_blue",
        name = ccb.content.plural_text("stegosaurus sample", "stegosaurus samples"),
        description = ccb.content.text("A sample of tissues and liquids from a living thyreophoran, one of many plant eating dinosaurs with natural protective armor."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
        category = "spare_parts",
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "horns_sample",
        symbol = "q",
        color = "light_blue",
        name = ccb.content.plural_text("ceratopsian sample", "ceratopsian samples"),
        description = ccb.content.text("A sample of tissues and liquids from a living ceratopsian, one of many plant eating dinosaurs with dramatic head adaptations useful for fighting and for finding a mate."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 114000,
        volume_ml = 250,
        category = "spare_parts",
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end
