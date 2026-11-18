local ccb = require("ccb")
local content = ccb.content

do
    -- Unique mission item for the CITY_COP.
    local item = content.Item {
        id = "family_photo",
        category = "other",
        name = ccb.content.plural_text("family photo", "family photos"),
        description = ccb.content.text("A photo of a smiling family on a camping trip.  One of the parents looks like a cleaner, happier version of a zombie you've seen."),
        mass_milligrams = 1000,
        volume_ml = 5,
        price_cents = 800,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "light_gray",
    }
    item:clear_flags()
    item:flag("BANK_NOTE_SHAPED")
    item:flag("PAPER_SHAPED")
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "old_key",
        category = "other",
        name = ccb.content.plural_text("key", "keys"),
        description = ccb.content.text("An old, nondescript North American Cylinder key.  Lord knows what lock it goes to; best not to bother with it."),
        mass_milligrams = 8000,
        volume_ml = 2,
        price_cents = 750,
        price_postapoc_cents = 1,
        symbol = "p",
        color = "dark_gray",
    }
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "LIXA_lab_postit",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("cyan post-it note", "cyan post-it notes"),
        snippet_category = "LIXA_lab_notes",
        description = ccb.content.text("A bright post-it note."),
        price_cents = 0,
        price_postapoc_cents = 0,
        copy_from = "lab_postit_bio",
        looks_like = "lab_postit_bio",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
