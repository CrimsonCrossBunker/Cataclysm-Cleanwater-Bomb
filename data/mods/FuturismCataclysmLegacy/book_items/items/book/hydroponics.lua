local content = require("ccb").content

do
    local book = content.Item {
        id = "fcl_helixwirl_hydroponics_manual",
        category = "manuals",
        name = content.plural_text("Helixwirl Biotechnologies internal hydroponics memorandum", "Helixwirl Biotechnologies internal hydroponics memorandums"),
        description = content.text("An internal Helixwirl Biotechnologies memorandum detailing the hydroponics core's field-control architecture.  The documentation is dry and technical, except for one bizarre structure whose function cannot be identified.  A warning in huge, bright-red lettering reads: DO NOT ALTER, IF PRODUCTION REVEALS ANY DEVIATION FROM THE REFERENCE, DISCARD THE UNIT IMMEDIATELY."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 10000,
        price_postapoc_cents = 1000,
        looks_like = "file",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 8,
        intelligence = 12,
        read_time_turns = 5400,
        fun = -30,
        chapters = 0,
        scannable = true,
        skill = "electronics",
    }
    content.add(book)
end
