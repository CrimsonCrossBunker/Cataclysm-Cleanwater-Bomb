local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_archery",
        name = ccb.content.plural_text("Lessons for the Novice Bowhunter", "copies of Lessons for the Novice Bowhunter"),
        description = ccb.content.text("This hefty paperback book contains all the information needed for novice archers to get started hunting with a variety of bows and crossbows."),
        price_postapoc_cents = 3000,
        price_cents = 2100,
        copy_from = "book_nonf_hard_arch_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "archery",
    }
    book:variants {
        {
            id = "book_archery",
            name = ccb.content.plural_text("Lessons for the Novice Bowhunter", "copies of Lessons for the Novice Bowhunter"),
            description = ccb.content.text("This hefty paperback book contains all the information needed for novice archers to get started hunting with a variety of bows and crossbows."),
        },
        -- 978-0285632653
        {
            id = "book_archery_1",
            name = ccb.content.plural_text("Archery Anatomy", "copies of Archery Anatomy"),
            description = ccb.content.text("A book that highlights archery techniques from the point of view of the relationship between the anatomy of the human body and the anatomy of the bow."),
        },
        -- 978-0764347917
        {
            id = "book_archery_2",
            name = ccb.content.plural_text("Way of Archery: A 1637 Chinese Military Training Manual", "copies of Way of Archery: A 1637 Chinese Military Training Manual"),
            description = ccb.content.text("The Way of Archery provides a detailed introduction to practicing archery in the traditional Chinese military style.  It explains the basics of how to shoot using the Asian thumb ring, proper posture, training regimen, equipment, and avoiding pitfalls in shooting."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_archery",
        name = ccb.content.plural_text("Zen and the Art of Archery", "copies of Zen and the Art of Archery"),
        description = ccb.content.text("This massive book contains a wealth of vital information for the novice archer."),
        copy_from = "book_nonf_hard_arch_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "archery",
    }
    book:variants {
        {
            id = "manual_archery",
            name = ccb.content.plural_text("Zen and the Art of Archery", "copies of Zen and the Art of Archery"),
            description = ccb.content.text("This massive book contains a wealth of vital information for the novice archer."),
        },
        -- 978-0811731331
        {
            id = "manual_archery_1",
            name = ccb.content.plural_text("Beginner's Guide to Traditional Archery", "copies of Beginner's Guide to Traditional Archery"),
            description = ccb.content.text("An easy-to-understand instruction manual for traditional archery.  Covers both target shooting and bow hunting."),
        },
        -- 978-1332070824
        {
            id = "manual_archery_2",
            name = ccb.content.plural_text("The Theory And Practice Of Archery", "copies of The Theory And Practice Of Archery"),
            description = ccb.content.text("Authored by Horace Ford, the champion archer of England for the years 1850 to 1859 and 1867, and known as one of the greatest archers of all time, this book holds all of his experience in archery, which is still relevant by modern standards."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_archery",
        category = "manuals",
        name = ccb.content.plural_text("Archery for Kids", "issues of Archery for Kids"),
        description = ccb.content.text("Will you be able to place the arrow right into the bullseye?  It is not that easy, but once you know how it's done, you will have a lot of fun with archery."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 250,
        symbol = "?",
        color = "pink",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 2,
        read_time_turns = 420,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "archery",
    }
    book:variants {
        {
            id = "mag_archery",
            name = ccb.content.plural_text("Archery for Kids", "issues of Archery for Kids"),
            description = ccb.content.text("Will you be able to place the arrow right into the bullseye?  It is not that easy, but once you know how it's done, you will have a lot of fun with archery."),
        },
        -- 978-1492588344
        {
            id = "mag_archery_1",
            name = ccb.content.plural_text("Archery Drill Book", "copies of Archery Drill Book"),
            description = ccb.content.text("\"Become a more consistent and accurate archer!\", The Archery Drill Book covers all aspects of the sport, with 130 of the best drills for developing superior technique, skill, physical stamina, and the focused mindset needed to shoot under pressure."),
        },
        -- 978-0811738347
        {
            id = "mag_archery_2",
            name = ccb.content.plural_text("Archery from A to Z", "copies of Archery from A to Z"),
            description = ccb.content.text("A beginner's guide to the equipment and shooting fundamentals that new shooters of all ages will benefit from."),
        },
        -- 978-1440091070
        {
            id = "mag_archery_2",
            name = ccb.content.plural_text("Anecdotes of Archery", "copies of Anecdotes of Archery"),
            description = ccb.content.text("\"Anecdotes of Archery - From the Earliest Ages to the Year 1791\" - This vintage book contains a comprehensive guide to archery, with historical details, information on archery in different cultures throughout the ages, anecdotes of notable events and battles, a glossary of archery terms, and much more."),
        },
    }
    content.add(book)
end
