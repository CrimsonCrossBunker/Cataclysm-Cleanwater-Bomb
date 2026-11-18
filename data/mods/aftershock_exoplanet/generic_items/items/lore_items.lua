local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_personal_card",
        category = "books",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("personal message card", "personal message cards"),
        snippet_category = "afs_personal_card",
        description = ccb.content.text("A creased card with images and a personal message."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_thi_deed",
        category = "books",
        symbol = ",",
        name = ccb.content.plural_text("ancient spaceship deed", "ancient spaceship deeds"),
        description = ccb.content.text("An ancient document from before the Discontinuity, detailing the purchase of the Vanishing Arc by your great-great-grandfather, signed and validated by a long nonexistent Earth polity.\n\nA simple legal curiosity of no real value, true ownership of this ship is guaranteed by the self-destruct mechanism you have programmed into its main reactor."),
        color = "red",
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_old_ship_medal",
        copy_from = "silver_medal",
        looks_like = "silver_medal",
        name = ccb.content.plural_text("ancient medal", "ancient medals"),
        description = ccb.content.text("An ancient medal given for exemplary service in Van Maneen's Exploratory Navy.  You have no idea what the Van Maanen Navy was, or how this thing ended up in the display case, but getting rid of it would make you uncomfortable."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_ship_ids",
        copy_from = "afs_thi_deed",
        looks_like = "afs_thi_deed",
        name = ccb.content.plural_text("forged ident codes", "forged ident codes"),
        description = ccb.content.text("Identity codes for Nyssia, Aztlan, Luzhan, and many other polities in the spinward frontier, all forgeries.  You fathom most of them would still work."),
    }
    content.add(item)
end
