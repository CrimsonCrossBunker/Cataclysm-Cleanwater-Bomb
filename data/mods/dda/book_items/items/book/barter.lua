local content = require("ccb").content

do
    local book = content.Item {
        id = "mag_barter",
        category = "manuals",
        name = content.plural_text("Car Buyer's Guide", "copies of Car Buyer's Guide"),
        description = content.text("Normally this glossy, ad-filled magazine about cars would be pointless, but it has a series of articles on haggling techniques."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "speech",
    }
    content.add(book)
end
