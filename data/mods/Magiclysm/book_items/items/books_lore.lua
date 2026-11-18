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

do
    -- Extra chapters to account for talking about magic
    local book = content.Item {
        id = "book_nonf_magic_origin_of_species",
        name = content.plural_text("On the Origin of Species by Means of Natural and Supernatural Selection", "copies of On the Origin of Species by Means of Natural and Supernatural Selection"),
        description = content.text("This is a mass-market paperback copy of Charles Darwin's famous book where he laid out his theory of evolution and the way that magic influences the course of speciation.  The book was extremely controversial when it came out for positing a recent common ancestor for humans and dwarves and for claiming that elves as a distinct species only date back to 3 million years before present."),
        symbol = "?",
        looks_like = "story_book",
        color = "green",
        mass_milligrams = 484000,
        volume_ml = 654,
        longest_side_mm = 230,
        price_cents = 4399,
        price_postapoc_cents = 1500,
        copy_from = "book_nonf_soft_tpl",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 900,
        fun = 2,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_empty_social_history_no_magic",
        name = content.plural_text("Running on Empty: A Social History of those Born Without Magic", "copies of Running on Empty: A Social History of those Born Without Magic"),
        description = content.text("A history of the treatment of the \"Empty\", people born with the inability to master even the simplest of spells.  From persecution to favored positions (since rulers could be sure the Empty had no magical means of plotting against them), this book chronicles their treatment across the ages."),
        symbol = "?",
        looks_like = "story_book",
        color = "light_gray",
        mass_milligrams = 1000000,
        volume_ml = 885,
        longest_side_mm = 230,
        price_cents = 2089,
        price_postapoc_cents = 1000,
        copy_from = "book_nonf_soft_tpl",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 1,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_history_antimagic_restraints",
        name = content.plural_text("Prisons and Magic: The History of Past and Present Antimagic Restraints", "copies of Prisons and Magic: The History of Past and Present Antimagic Restraints"),
        description = content.text("A detailed overview of the means used by ancient societies to keep imprisoned magic users inside prisons.  From the chains and gag to the mana-leech shackle, this book covers the myriad of ways prisons dealt with teleportation, invisibility, intangibility and every other magic that could be used for an evasion."),
        symbol = "?",
        looks_like = "story_book",
        color = "light_gray",
        mass_milligrams = 1000000,
        volume_ml = 885,
        longest_side_mm = 230,
        price_cents = 2089,
        price_postapoc_cents = 1000,
        copy_from = "book_nonf_soft_tpl",
    }
    book:material("paper", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 1,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end
