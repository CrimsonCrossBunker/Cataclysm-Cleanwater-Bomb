local content = require("ccb").content

do
    local book = content.Item {
        id = "book_nonf_hard_biography_living",
        name = content.plural_text("biography (living person)", "biographies (living person)"),
        description = content.text("A biography of a living person.  Well, living at the time it was written.  You'd be willing to bet they're shambling around looking for brains at the moment."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_biography_dead",
        name = content.plural_text("biography (deceased person)", "biographies (deceased person)"),
        description = content.text("A biography of someone who has already passed away.  At least they were lucky enough to live before the Cataclysm happened."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_autobiography",
        name = content.plural_text("autobiography", "autobiographies"),
        description = content.text("A biography of someone written by that very same someone.  Hopefully it's not too self-aggrandizing."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_history_ancient",
        name = content.plural_text("history book (ancient)", "history books (ancient)"),
        description = content.text("A real and true accounting of actual historical events, or at least the common understanding of those events."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_history_modern",
        name = content.plural_text("history book (modern)", "history books (modern)"),
        description = content.text("A history book about events that living people can still remember.  You might think this would make it easier to write about, but you would be wrong."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_self_help",
        name = content.plural_text("self-help book", "self-help books"),
        description = content.text("A book to help you sleep better, increase your productivity, finally accomplish those life goals, or attain psychological satisfaction."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_popular_science",
        name = content.plural_text("popular science book", "popular science books"),
        description = content.text("The entire history of the universe in a single book, or perhaps a book-length examination of an atom or the water cycle."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_language_learning",
        name = content.plural_text("language learning book", "language learning books"),
        description = content.text("A hardcover book dedicated to learning a new language.  If only the zombies could talk."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_religion",
        name = content.plural_text("religion book", "religion books"),
        description = content.text("A book about religion, not a religious book."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_parenting",
        name = content.plural_text("parenting book", "parenting books"),
        description = content.text("A book about raising children, including proper ways to punish them for breaking boundaries, making sure they're well-adjusted and happy, and equipping them with the skills they need to survive in the world.  That last part is a little outdated now."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_anythingcan",
        name = content.plural_text("Anything Can Be Beautiful", "copies of Anything Can Be Beautiful"),
        description = content.text("Stylist, designer, and glitter goddess Tiffynie Blust looks at the world with one mantra in mind: anything can be beautiful."),
        mass_milligrams = 771000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_handshome",
        name = content.plural_text("The Hands-On Home", "copies of The Hands-On Home"),
        description = content.text("An ecologically-minded take on modern homemaking, a practical guide to maximizing your time in the kitchen and beyond."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_loverms",
        name = content.plural_text("Rooms We Love", "copies of Rooms We Love"),
        description = content.text("A guide on how to affordably decorate rooms to suit your personality.  In the book, we visit rooms inspired by the needs of each homeowner and will see how they transformed their rooms."),
        mass_milligrams = 699000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_outkitchn",
        name = content.plural_text("Best Signature Outdoor Kitchens", "copies of Best Signature Outdoor Kitchens"),
        description = content.text("Outdoor space is one of the hottest amenities being considered by new and existing homeowners.  This book will show you how to turn any deck, patio, or other outside area into a great place to cook."),
        mass_milligrams = 617000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_plantshome",
        name = content.plural_text("The Art of Using Plants to Transform Your Home", "copies of The Art of Using Plants to Transform Your Home"),
        description = content.text("Bring gorgeous greenery into your life with this delightful guide to decorating your living space with a wide variety of plants.  Illustrated examples enable you to easily transform every corner of your interior space."),
        mass_milligrams = 580000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end
