local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_airship_piloting",
        category = "manuals",
        name = ccb.content.plural_text("The Complete Guide to Piloting Aircraft", "copies of The Complete Guide to Piloting Aircraft"),
        description = ccb.content.text("A comprehensive civilian flight manual covering every kind of aircraft, from helicopters to lighter-than-air craft.  It explains managing lift and ballast, steering with rotors and propellers, and handling changing winds."),
        mass_milligrams = 1400000,
        volume_ml = 1500,
        price_cents = 8500,
        price_postapoc_cents = 2500,
        symbol = "?",
        color = "light_blue",
        looks_like = "book_icef",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:melee_damage("bash", 4)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 3000,
        fun = 1,
        chapters = 0,
        scannable = true,
        skill = "driving",
    }
    content.add(book)
end
