local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "solar_cell_v3",
        name = ccb.content.plural_text("quantum solar cell", "quantum solar cells"),
        description = ccb.content.text("A small electronic device that can convert solar radiation into electric power.  This one uses exotic photovoltaic materials to reach extremely high efficiency."),
        price_cents = 50000,
        price_postapoc_cents = 1000,
        copy_from = "solar_cell_v2",
        looks_like = "solar_cell_v2",
    }
    content.add(item)
end
