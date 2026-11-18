local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "demon_chitin_piece",
        category = "spare_parts",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("chunk of demon chitin", "chunks of demon chitin"),
        description = ccb.content.text("A piece of demon spider exoskeleton.  It is light and very durable, and probably has some magical properties."),
        price_cents = 1000,
        mass_milligrams = 89000,
        volume_ml = 250,
    }
    item:material("demon_chitin", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bundle_demon_chitin_piece",
        copy_from = "demon_chitin_piece",
        looks_like = "demon_chitin_piece",
        symbol = "=",
        name = ccb.content.plural_text("bundle of demon chitin chunks", "bundles of demon chitin chunks"),
        description = ccb.content.text("Pieces of demon spider exoskeleton, bundled tightly together for storage.  Disassemble to unpack."),
    }
    item:adjust_measurements { price_cents = { factor = 10 }, volume_ml = { factor = 10 }, mass_milligrams = { factor = 10 } }
    content.add(item)
end
