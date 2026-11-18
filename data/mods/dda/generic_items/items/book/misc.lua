local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "book_ruined",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("ruined book", "ruined books"),
        description = ccb.content.text("A ruined book.  Someone has thoroughly ruined this book by ripping pages out and covering the remainder in… is that paint?"),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1587000,
        volume_ml = 1500,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "book_pieces",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("pieces of books", "pieces of books"),
        description = ccb.content.text("Scraps of paper that used to be part of a book.  Completely useless now."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 120000,
        volume_ml = 200,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
