local content = require("ccb").content

do
    local book = content.Item {
        id = "book_horse_tack",
        category = "manuals",
        name = content.plural_text("The Practical Saddler", "copies of The Practical Saddler"),
        description = content.text("An illustrated guide to measuring a horse, cutting leather, and sewing bridles, saddles, and bags that fit.  Its full-sized patterns make practical tack much easier to produce."),
        mass_milligrams = 950000,
        volume_ml = 1250,
        price_cents = 3500,
        price_postapoc_cents = 1200,
        symbol = "?",
        looks_like = "manual_tailor",
        color = "brown",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 5,
        intelligence = 6,
        read_time_turns = 2100,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "tailor",
        proficiencies = {
            { id = "prof_closures", time_factor = 0.2, fail_factor = 0.2 },
            { id = "prof_leatherworking_basic", time_factor = 0.2, fail_factor = 0.2 },
            { id = "prof_leatherworking", time_factor = 0.2, fail_factor = 0.2 },
        },
    }
    content.add(book)
end
