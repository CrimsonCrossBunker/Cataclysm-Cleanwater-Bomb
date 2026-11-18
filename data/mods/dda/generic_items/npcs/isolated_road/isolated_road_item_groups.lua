local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "blacksmith_prototypes",
        category = "books",
        symbol = ",",
        color = "white",
        looks_like = "paper",
        name = ccb.content.plural_text("engineering notes", "engineering notes"),
        snippet_category = "artisan_docs",
        description = ccb.content.text("A collection of sketches and CAD designs marked up with pencil.  There are two peoples handwriting."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
