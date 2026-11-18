local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_moons_tears_ingot",
        category = "manuals",
        name = ccb.content.plural_text("Report: LAUGHING DANCER metallurgy", "copies of Report: LAUGHING DANCER metallurgy"),
        description = ccb.content.text("A series of documents discussing the properties of the armor and weapons used by a group or organization only referred to as \"LAUGHING DANCER\".  Some of these described specifications don't seem physically possible."),
        mass_milligrams = 60000,
        volume_ml = 250,
        looks_like = "mag_glam",
        symbol = "?",
        color = "light_gray",
        price_cents = 8500,
        price_postapoc_cents = 1250,
    }
    book:material("paper", 1)
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_arvore_lashing_bough",
        copy_from = "book_martial",
        name = ccb.content.plural_text("sap-stained documents", "sets of sap-stained documents", "book"),
        price_postapoc_cents = 1000,
        mass_milligrams = 60000,
        description = ccb.content.text("A set of documents describing some kind of esoteric martial art that apparently controls the plants and power of nature.  Their are repeated references to \"lashing vines\" and \"poison claws.\""),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
        martial_art = "xe_ma_style_arvore_elemental",
    }
    content.add(book)
end
