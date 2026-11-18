local content = require("ccb").content

do
    local book = content.Item {
        id = "necropolis_freq",
        name = content.plural_text("frequency list", "frequency lists"),
        description = content.text("A notepad with a number of frequencies scribbled on it."),
        mass_milligrams = 200000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "pocket_firstaid",
        color = "light_cyan",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 2,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
