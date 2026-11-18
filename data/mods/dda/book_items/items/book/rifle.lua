local content = require("ccb").content

do
    local book = content.Item {
        id = "retool_instructions",
        category = "manuals",
        name = content.plural_text("retool instructions", "copies of retool instructions"),
        description = content.text("This is a small booklet, containing several diagrams and clearly worded instructions for assisting one in assembling, installing, and using their newly purchased weapon conversion kit.  The flyer's rear is covered in neatly printed rows of advertisements, displaying other products by the same manufacturer.  All in all, it, strangely enough, brings to mind nostalgic images of the instructions for assembling Legos—a very angry, explosive Lego construct that goes boom."),
        mass_milligrams = 25000,
        volume_ml = 100,
        price_cents = 150,
        price_postapoc_cents = 350,
        symbol = "?",
        looks_like = "mag_guns",
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
        skill = "rifle",
    }
    content.add(book)
end
