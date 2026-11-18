local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "howto_traps",
        category = "manuals",
        name = ccb.content.plural_text("How to Trap Anything", "copies of How to Trap Anything"),
        description = ccb.content.text("A worn manual that describes how to set and disarm a wide variety of traps."),
        mass_milligrams = 454000,
        volume_ml = 500,
        price_cents = 2400,
        price_postapoc_cents = 750,
        symbol = "?",
        looks_like = "glassblowing_book",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 4,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_traps",
        category = "manuals",
        name = ccb.content.plural_text("Trapper's Life", "issues of Trapper's Life"),
        description = ccb.content.text("An in-depth magazine about trapping game.  There are lots of articles and diagrams that explain simple trap designs."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 450,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "mag_gaming",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 1,
        intelligence = 5,
        read_time_turns = 480,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_traps",
        category = "manuals",
        name = ccb.content.plural_text("The Modern Trapper", "copies of The Modern Trapper"),
        description = ccb.content.text("An extensive volume that details numerous methods of trapping game."),
        mass_milligrams = 422000,
        volume_ml = 500,
        price_cents = 2400,
        price_postapoc_cents = 1750,
        symbol = "?",
        looks_like = "manual_dodge",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_traps_mil",
        category = "manuals",
        name = ccb.content.plural_text("FM 20-32 Mine/Countermine Operations", "copies of FM 20-32 Mine/Countermine Operations"),
        description = ccb.content.text("A hefty military field manual about mine-warfare principles, the mechanics of different types of mines/IED's, and countermine operations."),
        looks_like = "manual_rifle",
        mass_milligrams = 422000,
        volume_ml = 500,
        price_cents = 2000,
        price_postapoc_cents = 2250,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "manual_traps_mil_basic",
        category = "manuals",
        name = ccb.content.plural_text("Booby Traps, IEDs, Mines and You: A Primer", "copies of Booby Traps, IEDs, Mines and You: A Primer"),
        description = ccb.content.text("A light military field manual about booby traps, IEDs, mines and how to avoid being blown up by them."),
        looks_like = "manual_rifle",
        mass_milligrams = 211000,
        volume_ml = 250,
        price_cents = 1000,
        price_postapoc_cents = 1125,
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 3,
        intelligence = 4,
        read_time_turns = 1200,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    -- The spelling is intentionally archaic, as this form is commonly used in the titles of books.
    local book = content.Item {
        id = "textbook_traps",
        category = "manuals",
        name = ccb.content.plural_text("The Compleat Trapper", "copies of The Compleat Trapper"),
        description = ccb.content.text("An in-depth book about trapping game animals, covering methods both modern and ancient."),
        mass_milligrams = 1100000,
        volume_ml = 2000,
        price_cents = 6000,
        price_postapoc_cents = 1750,
        symbol = "?",
        looks_like = "manual_dodge",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 3,
        maximum_level = 6,
        intelligence = 8,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "trappers_companion",
        category = "manuals",
        name = ccb.content.plural_text("The Trapper's Companion", "copies of The Trapper's Companion"),
        description = ccb.content.text("A folksy guide to trapping wild game using time-tested methods.  A bit in-depth for the beginner, it can provide a wealth of information to a knowledgeable trapper."),
        mass_milligrams = 1920000,
        volume_ml = 2000,
        price_cents = 920,
        price_postapoc_cents = 1250,
        symbol = "?",
        looks_like = "manual_carpentry",
        color = "blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 8)
    book:book {
        required_level = 5,
        maximum_level = 8,
        intelligence = 10,
        read_time_turns = 3300,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "traps",
    }
    content.add(book)
end
