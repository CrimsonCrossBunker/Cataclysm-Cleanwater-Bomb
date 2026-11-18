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

do
    -- The ids below represent the Aarne-Thompson System of folklore classification.  Do not change.
    local book = content.Item {
        id = "fairy_tales",
        name = content.plural_text("book of fairy tales", "books of fairy tales"),
        description = content.text("An amusing collection of folklore featuring the usual cast of fairies, goblins, and trolls."),
        mass_milligrams = 410000,
        volume_ml = 750,
        price_cents = 950,
        price_postapoc_cents = 100,
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
        variant_kind = "generic",
        snippet_category = "auto:fairy_tales",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1080,
        fun = 3,
        chapters = 24,
        scannable = true,
    }

    local snippets = content.SnippetCategory { id = "auto:fairy_tales" }
    snippets:entry {
        id = "fairyat_41",
        text = content.text("This fairy tale is about a wolf who eats so much salted meat she becomes trapped in the butcher's cellar."),
    }
    snippets:entry {
        id = "fairyat_50",
        text = content.text("In this traditional story of beastly intrigue, a clever fox convinces an elderly lion to kill a derogatory wolf."),
    }
    snippets:entry {
        id = "fairyat_111",
        text = content.text("An illustrated fairy tale book about a conversation between a mouse and a cat."),
    }
    snippets:entry {
        id = "fairyat_112",
        text = content.text("This illustrated fairy tale relates how a city mouse did visit his cousin in the country, and how each regarded the other's quality of life."),
    }
    snippets:entry {
        id = "fairyat_155",
        text = content.text("A fable in which the jackal wins the day via clever foolishness."),
    }
    snippets:entry {
        id = "fairyat_156",
        text = content.text("A slave mistakenly wanders into a lion's den - thus begins a fable which demonstrates mutual dependence regardless of size or status."),
    }
    snippets:entry {
        id = "fairyat_171",
        text = content.text("An amusing collection of stories featuring \"Goldilocks and The Three Bears\" on the cover."),
    }
    snippets:entry {
        id = "fairyat_222",
        text = content.text("A well illustrated fairy tale about a war between the birds and the beasts, with particulars on the wartime conduct and eventual fate of the bat."),
    }
    snippets:entry {
        id = "fairyat_285",
        text = content.text("This book, titled \"The Rattlesnake's Vengeance\" is a collection of Cherokee myths and legends.  \"285D\" is hand-written in pencil on the title page."),
    }
    snippets:entry {
        id = "fairyat_328",
        text = content.text("This fairy tale book is a regional variant of \"Jack and the Beanstalk.\""),
    }
    snippets:entry {
        id = "fairyat_333",
        text = content.text("This fairy tale book is titled \"Little Red Cap.\"  It details a red-cloaked child's various encounters with talking wolves."),
    }
    snippets:entry {
        id = "fairyat_366",
        text = content.text("A collection of ghost stories warning about the dangers of stealing from the dead."),
    }
    snippets:entry {
        id = "fairyat_402",
        text = content.text("An Irish fairy tale in which a Celtic poet marries a princess who has been cursed with the head of a pig."),
    }
    snippets:entry {
        id = "fairyat_408",
        text = content.text("A book of Italian fairy tales translated into English.  The cover features an orange fairy juggling a lemon, a lime, and a tangerine."),
    }
    snippets:entry {
        id = "fairyat_451",
        text = content.text("A book of fables about people who change into birds."),
    }
    snippets:entry {
        id = "fairyat_475",
        text = content.text("This compendium of amusing folk tales about the devil is titled \"Hell's Kettle: Legends of the Devil.\""),
    }
    snippets:entry {
        id = "fairyat_530",
        text = content.text("This charming book of Swedish fables is titled \"The Glass Mountain and the Princess.\""),
    }
    snippets:entry {
        id = "fairyat_555",
        text = content.text("A collection of fairy tale stories warning against the consequences of extreme greed."),
    }
    snippets:entry {
        id = "fairyat_570",
        text = content.text("This fable book is titled \"The Rabbit Herd.\"  Inside are woodcut illustrations of a peasant boy playing his flute for a mob of mischievous hares."),
    }
    snippets:entry {
        id = "fairyat_591",
        text = content.text("This book is titled \"The Thieving Pot: Folktales of the Arab World.\""),
    }
    snippets:entry {
        id = "fairyat_653",
        text = content.text("A book of legends collected by Traveller Johnny Cassidy in the 1960s."),
    }
    snippets:entry {
        id = "fairyat_758",
        text = content.text("A book by the Brothers Grimm, titled \"Eve's Unequal Children.\""),
    }
    snippets:entry {
        id = "fairyat_766",
        text = content.text("This book of fables expands upon the legend of the Seven Sleepers of Ephesus."),
    }
    snippets:entry {
        id = "fairyat_1060",
        text = content.text("In this fairy tale, a strong man frightens an ogre by squeezing water out of a stone."),
    }
    snippets:entry {
        id = "fairyat_1084",
        text = content.text("This book of rustic folk tales bears the title \"How to Shout Down the Devil.\""),
    }
    snippets:entry {
        id = "fairyat_1287",
        text = content.text("The title of this book is \"Village Folk-tales of Ceylon.\"  It includes fables about logical errors and foolish misjudgments of the Kadambawa men."),
    }
    snippets:entry {
        id = "fairyat_1461",
        text = content.text("This book of folk tales is titled \"The Girl with the Ugly Name, and Other Stories.\""),
    }
    snippets:entry {
        id = "fairyat_2025",
        text = content.text("Titled \"The Fleeing Pancake\", this collection of silly folk tales is suitable for small children."),
    }
    content.add(snippets)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_adrk",
        name = content.plural_text("The Adorkable Girl", "copies of The Adorkable Girl"),
        description = content.text("When a therapist's daughter transfers to a new school, she decides to change her personality type.  As her social life begins to blossom, can she maintain a healthy boundary between her home life and her public persona?"),
        mass_milligrams = 350000,
        copy_from = "book_fict_soft_ya_quiddity",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 17,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_ya_bjak",
        name = content.plural_text("Becoming Jackson", "copies of Becoming Jackson"),
        description = content.text("When Jackson gains the mystical talent to alter his appearance on command, will he be able to recognize himself in his own mirror?"),
        copy_from = "book_fict_soft_ya_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_coa2",
        name = content.plural_text("Pantheon: The Story of an Iranian Youth", "copies of Pantheon: The Story of an Iranian Youth"),
        description = content.text("A hard cover graphic novel about a young girl living in Iran during the 1980's, seeing the world change around her as Iraq invaded her country."),
        longest_side_mm = 270,
        copy_from = "book_fict_hard_ya_quiddity",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 960,
        fun = 2,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end
