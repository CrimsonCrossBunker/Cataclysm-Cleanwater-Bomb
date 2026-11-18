local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "lab_postit_psi",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("yellow post-it note", "yellow post-it notes"),
        snippet_category = "lab_postit_psi",
        description = ccb.content.text("A bright post-it note."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 12,
        volume_ml = 1,
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
