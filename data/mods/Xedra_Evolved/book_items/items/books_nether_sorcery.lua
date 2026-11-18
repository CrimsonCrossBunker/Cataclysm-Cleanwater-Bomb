local content = require("ccb").content

do
    local book = content.Item {
        id = "book_nether_sorcery_opening_of_the_way",
        category = "manuals",
        copy_from = "book_deduction_black_iron_prison",
        looks_like = "holybook_wicca",
        name = content.plural_text("On the Opening of the Way", "copies of On the Opening of the Way"),
        description = content.text("A thick tome that seems to be a collection of rituals which will allow one to \"reach out and seize the power from beyond\" and \"call down the dancers in the dark between the stars.\"  You suspect the authorities would not approve, were they still alive."),
    }
    book:book {
        required_level = 5,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 1800,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end
