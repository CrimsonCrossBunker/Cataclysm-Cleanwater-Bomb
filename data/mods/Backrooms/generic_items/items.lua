local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "jug_cooler",
        category = "container",
        name = ccb.content.plural_text("water cooler jug", "water cooler jugs"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A sizable blue plastic jug meant to hold and supply water in a water cooler or similar dispenser.  Holds a lot of liquid, but unfortunately it doesn't come with a cap, making it hard to carry around when full."),
        mass_milligrams = 3740000,
        volume_ml = 20000,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 19000,
        max_weight_milligrams = 50000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_almond_water",
        category = "container",
        name = ccb.content.plural_text("almond water bottle", "almond water bottles"),
        description = ccb.content.text("A sealed glass bottle, holding a slightly-cloudy liquid."),
        ascii_picture = "bottle_plastic",
        mass_milligrams = 13000,
        volume_ml = 260,
        longest_side_mm = 180,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1250000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        sealed_spoil_multiplier = 0.0,
        moves = 400,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end
