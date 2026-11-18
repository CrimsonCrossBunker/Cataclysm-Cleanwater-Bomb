local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "mag_deduction_tabloid",
        category = "manuals",
        copy_from = "mag_deduction",
        looks_like = "mag_deduction",
        name = ccb.content.plural_text("The Noon", "issues of The Noon"),
        description = ccb.content.text("A tabloid paper with a rather unusually out-of-this-world articles even for tabloids' standard, ranging from something like an article about morticians selling the deceased's 'dreams' to the government to a sensational headline about a half-bat half-human boy causing 40-car pileup in the highway while driving away from police pursuit.  While most thought of The Noon as an amusing but otherwise mostly fake news paper in the past, the Cataclysm might bring the articles' presumably fake facts to light."),
        color = "red",
    }
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_deduction",
        category = "manuals",
        name = ccb.content.plural_text("The Holmesian Guide to Magickal Practice", "copies of The Holmesian Guide to Magickal Practice"),
        description = ccb.content.text("It's big and heavy, but full of great information about esoteric investigations."),
        mass_milligrams = 454000,
        volume_ml = 1250,
        price_cents = 2500,
        price_postapoc_cents = 1250,
        looks_like = "manual_first_aid",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 2,
        maximum_level = 3,
        intelligence = 9,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_teens_deduction",
        category = "manuals",
        name = ccb.content.plural_text("Scraggy-Boo and the Mystery Crew", "copies of Scraggy-Boo and the Mystery Crew"),
        description = ccb.content.text("A guide for teens interested in pursuing occult knowledge.  Readers often speak of encountering a guide in their dreams of a Russian Sheepdog, who introduces himself as Scraggy-Boo."),
        mass_milligrams = 192000,
        volume_ml = 250,
        price_cents = 4000,
        price_postapoc_cents = 750,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 1,
        maximum_level = 2,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    -- When possible, reading it should be literally painful.  Not much, but enough for the player to notice.
    local book = content.Item {
        id = "book_deduction_out_of_place",
        category = "manuals",
        name = ccb.content.plural_text("Out-of-place manuscript", "Out-of-place manuscript"),
        description = ccb.content.text("This book always feels like it shouldn't be where it is.  Its texts are incoherent and illogical, but they promise to help you understand something.  Reading a few words from its pages is enough to give you a headache."),
        mass_milligrams = 1360000,
        volume_ml = 2000,
        price_cents = 8500,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "black_white",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 4,
        maximum_level = 7,
        intelligence = 12,
        read_time_turns = 600,
        fun = -7,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_deduction",
        category = "manuals",
        name = ccb.content.plural_text("Esoteric Investigations Weekly", "issues of Esoteric Investigations Weekly"),
        description = ccb.content.text("A magazine for occult investigators.  These types of magazines proliferated in the decade prior to the Cataclysm."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 480,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "brown_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 8,
        read_time_turns = 480,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_deduction_black_iron_prison",
        category = "manuals",
        name = ccb.content.plural_text("Escaping the Black Iron Prison", "copies of Escaping the Black Iron Prison"),
        description = ccb.content.text("A hardbound book detailing numerous rituals and thought modifications in order to teach its readers how to break the shackles of mundanity."),
        mass_milligrams = 1360000,
        volume_ml = 2000,
        price_cents = 8500,
        price_postapoc_cents = 1250,
        symbol = "?",
        color = "black_white",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:clear_melee_damage()
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 4,
        intelligence = 10,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end
