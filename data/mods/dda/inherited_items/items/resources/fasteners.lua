local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "zipper_long_plastic",
        copy_from = "zipper_short_plastic",
        looks_like = "zipper_short_plastic",
        name = ccb.content.plural_text("long plastic zipper", "long plastic zippers"),
        description = ccb.content.text("A long zipper made from plastic, usually found on clothing."),
    }
    item:adjust_measurements { price_cents = { factor = 3 }, volume_ml = { factor = 3 }, mass_milligrams = { factor = 3 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "zipper_short_plastic",
        category = "spare_parts",
        name = ccb.content.plural_text("short plastic zipper", "short plastic zippers"),
        description = ccb.content.text("A short zipper made from plastic, usually found on footwear or clothing pockets."),
        mass_milligrams = 3000,
        volume_ml = 4,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("cotton", 1)
    content.add(item)
end
