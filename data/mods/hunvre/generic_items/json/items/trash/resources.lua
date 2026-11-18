local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "contaminated_dirt",
        category = "spare_parts",
        name = ccb.content.plural_text("contaminated dirt", "contaminated dirt"),
        description = ccb.content.text("Brownish biological matter mixed with toxic contaminants, generally a byproduct of cleaning processes, it's meant to be further processed and its components separated to be of any use."),
        color = "brown",
        symbol = "=",
        price_postapoc_cents = 0,
        volume_ml = 5000,
        mass_milligrams = 6250000,
        display_type = "BY_VOLUME",
    }
    item:material("soil", 1)
    item:material("plastic", 1)
    content.add(item)
end
