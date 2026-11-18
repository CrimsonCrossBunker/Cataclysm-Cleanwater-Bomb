local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "firmament_driver_book",
        category = "artifacts",
        name = ccb.content.plural_text("String Theory For Dummies", "copies of String Theory For Dummies"),
        description = ccb.content.text("A small hardcover book describing a quite preposterous version of string theory."),
        mass_milligrams = 77000,
        volume_ml = 334,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "*",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "firmament_driver" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_cable_whip",
        category = "artifacts",
        name = ccb.content.plural_text("taped jumper cable", "taped jumper cables"),
        description = ccb.content.text("A 3-ft (or about 1 m) jumper cable, wrapped with blue insulating tape.  Both sides lack connectors."),
        volume_ml = 500,
        mass_milligrams = 75000,
        symbol = "I",
        looks_like = "jumper_cable",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "cable_whip" }
    content.add(item)
end
