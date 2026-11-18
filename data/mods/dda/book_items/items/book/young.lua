local content = require("ccb").content

do
    local book = content.Item {
        id = "child_book",
        name = content.plural_text("children's book", "children's books"),
        description = content.text("A little book for little readers.  The colorful cartoon characters and sweet stories contained herein belong to a different time, before the dead walked and the world moved on."),
        mass_milligrams = 52000,
        volume_ml = 250,
        price_cents = 550,
        price_postapoc_cents = 100,
        symbol = "?",
        looks_like = "story_book",
        color = "light_cyan",
    }
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 240,
        fun = 1,
        chapters = 4,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_burn",
        name = content.plural_text("Nothing Burned", "copies of Nothing Burned"),
        description = content.text("A teenage influencer becomes fast friends with someone who may or may not be an actual demon."),
        copy_from = "book_fict_soft_ya_quiddity",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_hilo",
        name = content.plural_text("High and Low", "copies of High and Low"),
        description = content.text("In this work of adolescent fiction, a young Gemini discovers that the astrology section of his small town newspaper is eerily preminiscent.  His efforts to uncover the oracle reveal more than the stars could have predicted."),
        copy_from = "book_fict_soft_ya_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_myeyes",
        name = content.plural_text("Fire When You See My Eyes", "copies of Fire When You See My Eyes"),
        description = content.text("In a cataclysmic future, advanced technology gives parents access to video footage of every moment of their teenage children's lives."),
        copy_from = "book_fict_soft_ya_quiddity",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_pbbr",
        name = content.plural_text("Peanut Butter Bruised", "copies of Peanut Butter Bruised"),
        description = content.text("In this work of young adult fiction, a woman raised on food stamps falls in love with a young cook.  More importantly, she falls in love with the idea of becoming a professional chef."),
        copy_from = "book_fict_soft_ya_quiddity",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_rwya",
        name = content.plural_text("Ready When You Are", "copies of Ready When You Are"),
        description = content.text("When three teenage girls ditch class to drive cross-country together, they get a strong dose of life lessons on the road.  This work of young adult fiction explores how friendships evolve in early adulthood."),
        copy_from = "book_fict_soft_ya_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_sboy",
        name = content.plural_text("Study of a Boy", "copies of Study of a Boy"),
        description = content.text("A high school sophomore's personal journal is stolen and then leaked on social media.  When it goes viral, he is forced to contend with simultaneous fame and betrayal."),
        copy_from = "book_fict_soft_ya_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_sumv",
        name = content.plural_text("Summer Variables", "copies of Summer Variables"),
        description = content.text("In this book written primarily for young adults, a woman's modest summer internship results in an incredible discovery that attracts the attention of unsavory elements."),
        copy_from = "book_fict_soft_ya_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_ya_dark",
        name = content.plural_text("In a Dark Place", "copies of In a Dark Place"),
        description = content.text("Markia dreams about the future.  Theo longs for the past.  Together can they find a way to live in the now?"),
        copy_from = "book_fict_hard_ya_quiddity",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_hard_ya_btwo",
        name = content.plural_text("Betrayal Takes Two", "copies of Betrayal Takes Two"),
        description = content.text("A hard cover book for older teens.  The two main characters pull a cruel prank on their classmates, and are brought together both by their frantic efforts to avoid being caught and their shared sense of guilt."),
        copy_from = "book_fict_hard_ya_quiddity",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_coa",
        name = content.plural_text("coming of age novel", "coming of age novels"),
        description = content.text("A classic tale about growing up, portraying one young man's funny and poignant experiences with life, love, and sex."),
        mass_milligrams = 187000,
        volume_ml = 500,
        price_cents = 750,
        price_postapoc_cents = 50,
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end
