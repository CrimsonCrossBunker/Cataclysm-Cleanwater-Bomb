local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "kiernans_notes",
        category = "manuals",
        name = ccb.content.plural_text("Kiernan's notes", "copies of Kiernan's notes"),
        description = ccb.content.text("The voluminous notes of an obviously talented paleontologist, dedicated biologist, and amateur author.  These notes jump from such topics as fossil digs, science fiction stories, also strangely enough notes on dinosaur biology and potential hybridization efforts."),
        mass_milligrams = 1200000,
        volume_ml = 750,
        price_cents = 300000,
        price_postapoc_cents = 150000,
        symbol = "?",
        looks_like = "adv_chemistry",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 10,
        maximum_level = 10,
        intelligence = 16,
        read_time_turns = 2100,
        fun = -3,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end
