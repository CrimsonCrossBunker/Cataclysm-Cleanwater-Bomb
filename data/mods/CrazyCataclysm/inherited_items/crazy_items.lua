local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "family_photo",
        copy_from = "family_photo",
        looks_like = "family_photo",
        category = "other",
        name = ccb.content.plural_text("blurry picture of a scowling cartoon ape", "blurry picture of a scowling cartoon apes"),
        description = ccb.content.text("Allegedly very important."),
        price_cents = 2000000000,
        price_postapoc_cents = 0,
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "old_key",
        copy_from = "old_key",
        looks_like = "old_key",
        category = "other",
        name = ccb.content.plural_text("penultimate key", "penultimate keys"),
        description = ccb.content.text("This opens the Blob Door.  Better hold on to it."),
        mass_milligrams = 25000000,
        symbol = "p",
        color = "dark_gray",
    }
    item:material("monolith", 1)
    content.replace(item)
end

do
    local item = content.Item {
        id = "coin_half_dollar",
        copy_from = "coin_half_dollar",
        looks_like = "coin_half_dollar",
        category = "currency",
        name = ccb.content.plural_text("50 Cent coin", "50 Cent coins"),
        description = ccb.content.text("A fifty-cent coin, featuring a portrait of famed rapper 50 Cent.  On the back is the date of minting, and the G-Unit symbol."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "troglobite_sample",
        copy_from = "troglobite_sample",
        looks_like = "troglobite_sample",
        name = ccb.content.plural_text("gamer sample", "gamer samples"),
        description = ccb.content.text("A slurry of… uhh…"),
    }
    content.replace(item)
end
