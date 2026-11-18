local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dragon_black_scale",
        category = "spare_parts",
        symbol = "o",
        color = "black_white",
        name = ccb.content.plural_text("black dragon scale", "black dragon scales"),
        price_cents = 2500,
        mass_milligrams = 380000,
        volume_ml = 75,
        melee_to_hit = -4,
        description = ccb.content.text("A scale from a black dragon.  It still has its magical properties and acid resistance."),
    }
    item:material("black_dragon_scales", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 0)
    content.add(item)
end

do
    -- inspiration from bundle of planks
    local item = content.Item {
        id = "bundle_black_scale",
        copy_from = "dragon_black_scale",
        looks_like = "dragon_black_scale",
        symbol = "=",
        name = ccb.content.plural_text("bundle of black dragon scales", "bundles of black dragon scales"),
        description = ccb.content.text("Scales from a black dragon, bundled tightly together for storage.  Disassemble to unpack."),
    }
    item:adjust_measurements { price_cents = { factor = 10 }, volume_ml = { factor = 10 }, mass_milligrams = { factor = 10 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "black_dragon_tanned_hide",
        symbol = ",",
        color = "black_white",
        name = ccb.content.plural_text("black dragon hide", "black dragon hides"),
        description = ccb.content.text("Prepared hide from a black dragon.  Hard, acid-resistant, and with more scales could make a suit of armor as hard as steel and half as heavy."),
        price_cents = 50000,
        mass_milligrams = 2500000,
        volume_ml = 4000,
        category = "spare_parts",
        melee_to_hit = -1,
    }
    item:material("black_dragon_hide", 1)
    content.add(item)
end

do
    -- inspiration from bundle of leather
    local item = content.Item {
        id = "bundle_black_hide",
        copy_from = "black_dragon_tanned_hide",
        looks_like = "black_dragon_tanned_hide",
        symbol = ",",
        name = ccb.content.plural_text("bundle of black dragon hides", "bundles of black dragon hides"),
        description = ccb.content.text("Hides from a black dragon, bundled tightly together for storage.  Disassemble to unpack."),
    }
    item:adjust_measurements { price_cents = { factor = 10 }, volume_ml = { factor = 10 }, mass_milligrams = { factor = 10 } }
    content.add(item)
end
