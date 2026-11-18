local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "sheet_fibercloth",
        category = "spare_parts",
        name = ccb.content.plural_text("fibercloth sheet", "fibercloth sheets"),
        description = ccb.content.text("A 12 inch by 24 inch sheet of fabric woven from plant fiber, suitable for making clothing."),
        mass_milligrams = 38000,
        volume_ml = 47,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "green",
    }
    item:material("fibercloth", 1)
    content.add(item)
end
