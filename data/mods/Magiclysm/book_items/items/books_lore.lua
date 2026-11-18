local content = require("ccb").content

do
    local book = content.Item {
        id = "magazine_augmentative_review",
        copy_from = "mag_news",
        looks_like = "mag_news",
        name = content.plural_text("Augmentative Technomancy Review", "issues of Augmentative Technomancy Review"),
        description = content.text("This annual publication covers the latest advances in bionic technomancy, the implantation of metal into flesh.  There are some pretty promising new developments in here that will now never see the light of day."),
        symbol = "?",
        color = "pink",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "messed_up_spells_lorebook",
        name = content.plural_text("Magical Mishaps: When Spells Go Wrong", "copies of Magical Mishaps: When Spells Go Wrong"),
        description = content.text("A series of stories of the various ways magic can go wrong if the wrong ingredients, words, or gestures are used.  A lot of the stories are merely funny, like the magus who in trying to alter the Sorcerer's Hand spell caused music to follow her everywhere she went, but there's the occasional real tragedy mixed in as a cautionary tale."),
        mass_milligrams = 483000,
        volume_ml = 825,
        price_cents = 5000,
        price_postapoc_cents = 500,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 420,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
