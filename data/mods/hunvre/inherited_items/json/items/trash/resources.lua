local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nurdle",
        category = "spare_parts",
        name = ccb.content.plural_text("nurdle", "nurdle"),
        description = ccb.content.text("Pre production plastic pellets, ready to be processed into all kinds of items."),
        color = "white",
        symbol = "=",
        price_postapoc_cents = 100,
        volume_ml = 5000,
        mass_milligrams = 5000000,
        display_type = "BY_VOLUME",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "degraded_nurdle",
        copy_from = "nurdle",
        looks_like = "nurdle",
        category = "spare_parts",
        name = ccb.content.plural_text("degraded nurdle", "degraded nurdle"),
        description = ccb.content.text("Yellowed and cloudy pellets of degraded polymers."),
        color = "light_gray",
    }
    item:adjust_measurements { price_postapoc_cents = { factor = 0.2 } }
    content.add(item)
end
