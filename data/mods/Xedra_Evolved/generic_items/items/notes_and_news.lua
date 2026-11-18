local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "museum_plaques_visitors",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("museum plaque", "museum plaques"),
        snippet_category = "museum_plaques_visitors",
        description = ccb.content.text("A paper plaque.  It has words printed on it."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 12,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "museum_plaques_items",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("museum plaque", "museum plaques"),
        snippet_category = "museum_plaques_items",
        description = ccb.content.text("A paper plaque.  It has words printed on it."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 12,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
