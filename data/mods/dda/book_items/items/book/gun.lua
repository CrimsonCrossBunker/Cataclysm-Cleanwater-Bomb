local content = require("ccb").content

do
    local book = content.Item {
        id = "pocket_firearms",
        category = "manuals",
        name = content.plural_text("Pocket Guide to Firearm Safety", "copies of Pocket Guide to Firearm Safety"),
        description = content.text("This pocket-sized leather-bound guide to firearm safety combines a wealth of concise information with simple to follow instructions and easy to read illustrations."),
        mass_milligrams = 226000,
        volume_ml = 250,
        price_cents = 4000,
        price_postapoc_cents = 500,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "gun",
    }
    content.add(book)
end
