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

do
    local book = content.Item {
        id = "book_nonf_hard_photography_book",
        name = content.plural_text("photography collection", "photography collections"),
        description = content.text("A hardbound book containing a set of very impressive photographs of animals you'll never see and places you'll never be able to go to."),
        mass_milligrams = 3016000,
        volume_ml = 2000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_true_crime",
        name = content.plural_text("true crime book", "true crime books"),
        description = content.text("Part history, part biography, the story of a real crime and the people affected by it."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_business_strategy",
        name = content.plural_text("business strategy book", "business strategy books"),
        description = content.text("A book about analyzing business trends to keep hitting your KPIs and make sure your SMART goals are aligned with your overall strategic framework.  Basically useless now."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_travelogue",
        name = content.plural_text("travelogue", "travelogues"),
        description = content.text("Stories about traveling to a far-off place, meeting new people, and eating new foods.  The kind of things you'll never be able to do again."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_humor",
        name = content.plural_text("humorous book", "humorous books"),
        description = content.text("A book entirely written to make the reader laugh.  Honestly it's exactly what you need right now."),
        mass_milligrams = 1334000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_grtrms",
        name = content.plural_text("The Greatest Rooms of the Century", "copies of The Greatest Rooms of the Century"),
        description = content.text("A stunning collection of the best living spaces created and commissioned by the most influential people in interior design."),
        mass_milligrams = 3016000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 50,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_nyparti",
        name = content.plural_text("New York Parties", "copies of New York Parties"),
        description = content.text("Visit the homes of savvy tastemakers from the worlds of fashion, finance, and design, with this book of lavish photography."),
        mass_milligrams = 1606000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 1,
        chapters = 20,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_homemk_wmencolor",
        name = content.plural_text("Woman of Color", "copies of Woman of Color"),
        description = content.text("A collection of essays and advice on style, beauty, and motherhood.  Part memoir, part lifestyle guide, this book reflects the author's experience growing up as a woman of color in Brooklyn."),
        mass_milligrams = 658000,
        copy_from = "book_nonf_hard_homemk_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 1,
        chapters = 6,
        scannable = true,
    }
    content.add(book)
end

do
    -- This book belongs to two genres: wedding and kids
    local book = content.Item {
        id = "book_nonf_soft_wedding_coolring",
        name = content.plural_text("10 Cool Things About Being A Ring Bearer", "copies of 10 Cool Things About Being A Ring Bearer"),
        description = content.text("This book is for the delightful little ring bearer in your wedding.  The author depicts the responsibility and honor in being a ring bearer.  Your little angel will cherish this book as he or she learns how to behave on your perfect day."),
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 3,
        read_time_turns = 900,
        fun = 0,
        chapters = 1,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_parent_howtogen",
        name = content.plural_text("How to Raise a Gentleman: A Civilized Guide to Parenting", "copies of How to Raise a Gentleman: A Civilized Guide to Parenting"),
        description = content.text("A revised edition for parents who hope their little boy children will grow up to be the kind of men who know which fork to use, how to treat others, and generally make their parents proud."),
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 0,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_safety_radiaea",
        name = content.plural_text("International Approaches to Securing Radioactive Sources Against Terrorism", "copies of International Approaches to Securing Radioactive Sources Against Terrorism"),
        description = content.text("This book presents how to enhance cooperation and assistance between countries in support of International Atomic Energy Agency efforts to secure radioactive sources against the threat of terrorism."),
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 660,
        fun = 0,
        chapters = 49,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_psych_forpsych",
        name = content.plural_text("Principles of Forensic Psychiatry", "copies of Principles of Forensic Psychiatry"),
        description = content.text("This text addresses standards in the assessment and treatment of aggression and violence as well as psychological and neuroimaging assessments."),
        mass_milligrams = 2835000,
        volume_ml = 3673,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1320,
        fun = -2,
        chapters = 9,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_psych_grconres",
        name = content.plural_text("The Guide to Reflective Conflict Resolution", "copies of The Guide to Reflective Conflict Resolution"),
        description = content.text("The back cover of this hardbound book reads: \"Why should professionals care about reflective practice?  How do its principles and methods increase competence?  What characteristics distinguish reflective practitioners?\""),
        mass_milligrams = 494000,
        volume_ml = 761,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1500,
        fun = 0,
        chapters = 12,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_psych_moodalm",
        name = content.plural_text("The Oxbridge Handbook of Mood Ailments", "copies of The Oxbridge Handbook of Mood Ailments"),
        description = content.text("The Oxbridge Handbook of Mood Ailments provides detailed coverage of the characterization, understanding, and treatment of affective disorders.  It provides coverage of unipolar depression, bipolar disorder, and known variants of these illnesses."),
        mass_milligrams = 1152000,
        volume_ml = 1647,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 2400,
        fun = 0,
        chapters = 24,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_hard_psych_phonodis",
        name = content.plural_text("Phonological Acquisition and Disorders", "copies of Phonological Acquisition and Disorders"),
        description = content.text("Studying the phonologies of children with non-organic speech disorders, this volume details the latest findings in optimality theory, phonological acquisition and disorders.  It is intended for linguists and psychologists."),
        mass_milligrams = 730000,
        volume_ml = 1038,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 10,
        read_time_turns = 1800,
        fun = 0,
        chapters = 11,
        scannable = true,
    }
    content.add(book)
end

do
    -- An example of book that belongs in two genres: homemk and psych
    local book = content.Item {
        id = "book_nonf_hard_psych_thergar",
        name = content.plural_text("Therapeutic Gardens and Healing Spaces", "copies of Therapeutic Gardens and Healing Spaces"),
        description = content.text("This book addresses how to design therapeutic gardens.  It illustrates a variety of landscape designs appropriate for public spaces that promote mental health."),
        mass_milligrams = 1043000,
        volume_ml = 1110,
        copy_from = "book_nonf_hard_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1080,
        fun = 0,
        chapters = 12,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_adrugds",
        name = content.plural_text("Advances in Drug Delivery Systems", "copies of Advances in Drug Delivery Systems"),
        description = content.text("This softcover reprint covers an array of topics in pharmacology.  The physicochemical concepts of the refinement of bioresponsive drug delivery are presented in detail alongside a variety of current approaches employed in the development of zero order release systems."),
        mass_milligrams = 773000,
        volume_ml = 964,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 10,
        read_time_turns = 1800,
        fun = 0,
        chapters = 20,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_arteatds",
        name = content.plural_text("Using Art to Treat Eating Disorders", "copies of Using Art to Treat Eating Disorders"),
        description = content.text("An introductory guide for those wanting to explore the use of art to address eating disorders.  Art therapy is a particularly effective therapeutic intervention, as it allows people to express uncomfortable thoughts and feelings nonverbally."),
        mass_milligrams = 340000,
        volume_ml = 428,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 0,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_cggamers",
        name = content.plural_text("A Clinical Guide to Video Gamers", "copies of A Clinical Guide to Video Gamers"),
        description = content.text("This scholarly work considers the role that games play in psychological experiences and mental health.  Chapters examine the factors that compel individual gamers to select and identify with particular games and characters, as well as the different play styles, genres, and archetypes common in video games."),
        mass_milligrams = 295000,
        volume_ml = 442,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1800,
        fun = 0,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_paranoia",
        name = content.plural_text("Paranoia and the History of Madness", "copies of Paranoia and the History of Madness"),
        description = content.text("This book is an analysis of the use and misuse of paranoia throughout history and in contemporary society.  The impact of paranoia on societies is explored in detail."),
        mass_milligrams = 522000,
        volume_ml = 759,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1500,
        fun = 0,
        chapters = 12,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_psycolo",
        name = content.plural_text("Psychoanalysis and Colonialism", "copies of Psychoanalysis and Colonialism"),
        description = content.text("Freud referred to women's sexuality as a \"dark continent\" for psychoanalysis, drawing on colonial use of the same phrase to refer to Africa.  This book details how the problematic universalism of psychoanalysis led theorists to reject its relevance for postcolonial critique."),
        mass_milligrams = 454000,
        volume_ml = 734,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_psych_psycstlk",
        name = content.plural_text("The Psychology of Stalking", "copies of The Psychology of Stalking"),
        description = content.text("This book explores stalking from social, psychiatric, psychological and behavioral perspectives.  Topics include psychiatric diagnoses, offender-victim typologies, cyberstalking, false victimization syndrome, erotomania, domestic violence, the stalking of public figures, and many other aspects of stalking."),
        mass_milligrams = 400000,
        volume_ml = 521,
        copy_from = "book_nonf_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1080,
        fun = 0,
        chapters = 21,
        scannable = true,
    }
    content.add(book)
end
